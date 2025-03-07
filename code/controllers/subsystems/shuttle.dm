SUBSYSTEM_DEF(shuttle)
	name = "Shuttle"
	wait = 2 SECONDS
	priority = SS_PRIORITY_SHUTTLE
	init_order = SS_INIT_SHUTTLE                 //Should be initialized after all maploading is over and atoms are initialized, to ensure that landmarks have been initialized.

	var/overmap_halted = FALSE                   //Whether ships can move on the overmap; used for adminbus.
	var/list/ships = list()                      //List of all ships.

	var/list/shuttles = list()                   //maps shuttle tags to shuttle datums, so that they can be looked up.
	var/list/process_shuttles = list()           //simple list of shuttles, for processing
	var/list/registered_shuttle_landmarks = list()
	var/last_landmark_registration_time
	var/list/shuttle_logs = list()               //Keeps records of shuttle movement, format is list(datum/shuttle = datum/shuttle_log)
	var/list/shuttle_areas = list()              //All the areas of all shuttles.
	var/list/map_hash_to_areas = list()      //This helps shuttles locate correct areas. Format: list(string map_hash = list(area_type = area_instance)).
	var/list/docking_registry = list()           //Docking controller tag -> docking controller program, mostly for init purposes.
	var/list/docking_beacons = list()			 //Magnetic docking beacons, used for free-form landing in secure areas.

	var/list/landmarks_awaiting_sector = list()  //Stores automatic landmarks that are waiting for a sector to finish loading.
	var/list/landmarks_still_needed = list()     //Stores landmark_tags that need to be assigned to the sector (landmark_tag = sector) when registered.
	var/list/shuttles_to_initialize              //A queue for shuttles to initialize at the appropriate time.
	var/list/sectors_to_initialize               //Used to find all sector objects at the appropriate time.
	var/block_queue = TRUE

	var/tmp/list/working_shuttles

/datum/controller/subsystem/shuttle/Initialize()
	last_landmark_registration_time = world.time
	for(var/shuttle_type in subtypesof(/datum/shuttle)) // This accounts for most shuttles, though away maps can queue up more.
		var/datum/shuttle/shuttle = shuttle_type
		if(!initial(shuttle.defer_initialisation))
			LAZYDISTINCTADD(shuttles_to_initialize, shuttle_type)
	block_queue = FALSE
	clear_init_queue()
	. = ..()

/datum/controller/subsystem/shuttle/fire(resumed = FALSE)
	if (!resumed)
		working_shuttles = process_shuttles.Copy()

	while (working_shuttles.len)
		var/datum/shuttle/shuttle = working_shuttles[working_shuttles.len]
		working_shuttles.len--
		if(shuttle.process_state && (shuttle.Process(wait, times_fired, src) == PROCESS_KILL))
			process_shuttles -= shuttle

		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/shuttle/proc/clear_init_queue()
	if(block_queue)
		return
	initialize_shuttles()
	initialize_sectors()

/datum/controller/subsystem/shuttle/proc/initialize_shuttles()
	var/list/shuttles_made = list()
	for(var/shuttle_type in shuttles_to_initialize)
		var/shuttle = initialize_shuttle(shuttle_type, shuttles_to_initialize[shuttle_type])
		if(shuttle)
			shuttles_made += shuttle
	hook_up_motherships(shuttles_made)
	shuttles_to_initialize = null

/datum/controller/subsystem/shuttle/proc/initialize_sectors()
	for(var/sector in sectors_to_initialize)
		initialize_sector(sector)
	sectors_to_initialize = null

/datum/controller/subsystem/shuttle/proc/register_landmark(shuttle_landmark_tag, obj/effect/shuttle_landmark/shuttle_landmark)
	if (registered_shuttle_landmarks[shuttle_landmark_tag])
		CRASH("Attempted to register shuttle landmark with tag [shuttle_landmark_tag], but it is already registered!")
	if (istype(shuttle_landmark))
		registered_shuttle_landmarks[shuttle_landmark_tag] = shuttle_landmark
		last_landmark_registration_time = world.time

		var/obj/effect/overmap/visitable/O = landmarks_still_needed[shuttle_landmark_tag]
		if(O) //These need to be added to sectors, which we handle.
			try_add_landmark_tag(shuttle_landmark_tag, O)
			landmarks_still_needed -= shuttle_landmark_tag
		else if(istype(shuttle_landmark, /obj/effect/shuttle_landmark/automatic)) //These find their sector automatically
			O = global.overmap_sectors[num2text(shuttle_landmark.z)]
			O ? O.add_landmark(shuttle_landmark, shuttle_landmark.shuttle_restricted) : (landmarks_awaiting_sector += shuttle_landmark)

/datum/controller/subsystem/shuttle/proc/unregister_landmark(shuttle_landmark_tag)
	LAZYREMOVE(registered_shuttle_landmarks, shuttle_landmark_tag)

/datum/controller/subsystem/shuttle/proc/get_landmark(var/shuttle_landmark_tag)
	return registered_shuttle_landmarks[shuttle_landmark_tag]

//Checks if the given sector's landmarks have initialized; if so, registers them with the sector, if not, marks them for assignment after they come in.
//Also adds automatic landmarks that were waiting on their sector to spawn.
/datum/controller/subsystem/shuttle/proc/initialize_sector(obj/effect/overmap/visitable/given_sector)
	given_sector.populate_sector_objects() // This is a late init operation that sets up the sector's map_z and does non-overmap-related init tasks.

	for(var/landmark_tag in given_sector.initial_generic_waypoints)
		if(!try_add_landmark_tag(landmark_tag, given_sector))
			landmarks_still_needed[landmark_tag] = given_sector

	for(var/shuttle_type in given_sector.initial_restricted_waypoints)
		for(var/landmark_tag in given_sector.initial_restricted_waypoints[shuttle_type])
			if(!try_add_landmark_tag(landmark_tag, given_sector))
				landmarks_still_needed[landmark_tag] = given_sector

	var/landmarks_to_check = landmarks_awaiting_sector.Copy()
	for(var/thing in landmarks_to_check)
		var/obj/effect/shuttle_landmark/automatic/landmark = thing
		if(landmark.z in given_sector.map_z)
			given_sector.add_landmark(landmark, landmark.shuttle_restricted)
			landmarks_awaiting_sector -= landmark

/datum/controller/subsystem/shuttle/proc/try_add_landmark_tag(landmark_tag, obj/effect/overmap/visitable/given_sector)
	var/obj/effect/shuttle_landmark/landmark = get_landmark(landmark_tag)
	if(!landmark)
		return

	if(landmark.landmark_tag in given_sector.initial_generic_waypoints)
		given_sector.add_landmark(landmark)
		. = 1
	for(var/shuttle_type in given_sector.initial_restricted_waypoints)
		if(landmark.landmark_tag in given_sector.initial_restricted_waypoints[shuttle_type])
			given_sector.add_landmark(landmark, shuttle_type)
			. = 1

/datum/controller/subsystem/shuttle/proc/initialize_shuttle(var/shuttle_type, var/map_hash, var/list/add_args)
	var/datum/shuttle/shuttle = shuttle_type
	if(TYPE_IS_ABSTRACT(shuttle))
		return null
	var/list/shuttle_args = list(map_hash)
	if(length(add_args))
		shuttle_args += add_args
	shuttle = new shuttle(arglist(shuttle_args))
	shuttle_areas |= shuttle.shuttle_area
	return shuttle

/datum/controller/subsystem/shuttle/proc/hook_up_motherships(shuttles_list)
	for(var/datum/shuttle/S in shuttles_list)
		if(S.mothershuttle && !S.motherdock)
			var/datum/shuttle/mothership = shuttles[S.mothershuttle]
			if(mothership)
				S.motherdock = S.current_location.landmark_tag
				mothership.shuttle_area |= S.shuttle_area
			else
				error("Shuttle [S] was unable to find mothership [mothership]!")

/datum/controller/subsystem/shuttle/proc/toggle_overmap(new_setting)
	if(overmap_halted == new_setting)
		return
	overmap_halted = !overmap_halted
	for(var/ship in ships)
		var/obj/effect/overmap/visitable/ship/ship_effect = ship
		overmap_halted ? ship_effect.halt() : ship_effect.unhalt()

/datum/controller/subsystem/shuttle/proc/ship_by_name(name)
	for (var/obj/effect/overmap/visitable/ship/ship in ships)
		if (ship.name == name)
			return ship

/datum/controller/subsystem/shuttle/proc/ship_by_type(type)
	for (var/obj/effect/overmap/visitable/ship/ship in ships)
		if (ship.type == type)
			return ship

/datum/controller/subsystem/shuttle/proc/ship_by_shuttle(shuttle)
	for(var/obj/effect/overmap/visitable/ship/landable/landable in SSshuttle.ships)
		if(landable.shuttle == shuttle)
			return landable

/datum/controller/subsystem/shuttle/proc/docking_beacons_by_z(z_levels)
	. = list()
	if(!islist(z_levels))
		z_levels = list(z_levels)
	for(var/obj/machinery/docking_beacon/beacon in docking_beacons)
		if(beacon.z in z_levels)
			. |= beacon

/datum/controller/subsystem/shuttle/stat_entry()
	..("Shuttles:[shuttles.len], Ships:[ships.len], L:[registered_shuttle_landmarks.len][overmap_halted ? ", HALT" : ""]")