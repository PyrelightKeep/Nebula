/obj/machinery/meter
	name = "meter"
	desc = "A meter that monitors gas composition, pressure, and temperature in the attached pipe."
	icon = 'icons/obj/meter.dmi'
	icon_state = "meterX"
	var/atom/target = null //A pipe for the base type
	anchored = TRUE
	power_channel = ENVIRON
	idle_power_usage = 15

	uncreated_component_parts = list(
		/obj/item/stock_parts/power/apc
	)
	public_variables = list(
		/decl/public_access/public_variable/gas,
		/decl/public_access/public_variable/pressure,
		/decl/public_access/public_variable/temperature
	)
	stock_part_presets = list(/decl/stock_part_preset/radio/basic_transmitter/meter = 1)

	frame_type = /obj/item/machine_chassis/pipe_meter
	construct_state = /decl/machine_construction/default/panel_closed/item_chassis
	base_type = /obj/machinery/meter

/obj/machinery/meter/Initialize()
	. = ..()
	if(!target)
		set_target(locate(/obj/machinery/atmospherics/pipe) in loc)
	if(!target)
		set_target(loc)

/obj/machinery/meter/proc/set_target(atom/new_target)
	clear_target()
	target = new_target
	events_repository.register(/decl/observ/destroyed, target, src, PROC_REF(clear_target))

/obj/machinery/meter/proc/clear_target()
	if(target)
		events_repository.unregister(/decl/observ/destroyed, target, src)
		target = null

/obj/machinery/meter/return_air()
	if(target)
		return target.return_air()
	return ..()

/obj/machinery/meter/Destroy()
	clear_target()
	. = ..()

/obj/machinery/meter/Process()
	..()
	if(!target)
		icon_state = "meterX"
		return 0

	if(stat & (BROKEN|NOPOWER))
		icon_state = "meter0"
		return 0

	var/datum/gas_mixture/environment = return_air()
	if(!environment)
		icon_state = "meterX"
		return 0

	var/env_pressure = environment.return_pressure()
	if(env_pressure <= (0.15 ATM))
		icon_state = "meter0"
	else if(env_pressure <= (1.8 ATM))
		var/val = round(env_pressure/(0.3 ATM) + 0.5)
		icon_state = "meter1_[val]"
	else if(env_pressure <= (30 ATM))
		var/val = round(env_pressure/(5 ATM)-0.35) + 1
		icon_state = "meter2_[val]"
	else if(env_pressure <= (59 ATM))
		var/val = round(env_pressure/(5 ATM) - 6) + 1
		icon_state = "meter3_[val]"
	else
		icon_state = "meter4"

/obj/machinery/meter/get_examine_strings(mob/user, distance, infix, suffix)
	. = ..()

	if(distance > 3 && !(isAI(user) || isghost(user)))
		. += SPAN_WARNING("You are too far away to read it.")

	else if(stat & (NOPOWER|BROKEN))
		. += SPAN_WARNING("The display is off.")

	else if(src.target)
		var/datum/gas_mixture/environment = target.return_air()
		if(environment)
			. += "The pressure gauge reads [round(environment.return_pressure(), 0.01)] kPa; [round(environment.temperature,0.01)]K ([round(environment.temperature-T0C,0.01)]&deg;C)."
		else
			. += "The sensor error light is blinking."
	else
		. += "The connect error light is blinking."

// turf meter -- prioritizes turfs over pipes for target acquisition

/obj/machinery/meter/turf/Initialize()
	if (!target)
		set_target(loc)
	. = ..()

/obj/machinery/meter/starts_with_radio
	uncreated_component_parts = list(
		/obj/item/stock_parts/radio/transmitter/basic/buildable,
		/obj/item/stock_parts/power/apc
	)

/decl/stock_part_preset/radio/basic_transmitter/meter
	transmit_on_tick = list(
		"pressure" = /decl/public_access/public_variable/pressure,
	)
	frequency = ATMOS_TANK_FREQ