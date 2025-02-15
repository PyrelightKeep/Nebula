/obj/item/food/fruit
	name = "abstract fruit"
	desc = "A mysterious fruit of some kind."
	icon = 'mods/pyrelight/icons/fruit/debug.dmi'
	icon_state = "base"
	material = /decl/material/solid/organic/plantmatter
	is_spawnable_type = FALSE
	var/examine_info
	var/examine_info_skill = SKILL_BOTANY
	var/examine_info_rank = SKILL_BASIC
	var/list/removed_segments

/obj/item/food/fruit/initialize_reagents(populate)
	var/segment_amount = 0
	for(var/datum/fruit_segment/comp as anything in get_composition())
		if(comp.contributes_to_fruit_reagents)
			segment_amount += comp.reagent_total
	create_reagents(segment_amount)
	return ..()

/obj/item/food/fruit/populate_reagents()
	for(var/datum/fruit_segment/comp as anything in get_composition())
		if(!comp.contributes_to_fruit_reagents)
			continue
		for(var/rid in comp.reagents)
			reagents.add_reagent(rid, comp.reagents[rid])
	return ..()

/obj/item/food/fruit/Destroy()
	removed_segments = null
	return ..()

/obj/item/food/fruit/on_update_icon()
	. = ..()
	var/list/comp_count = list()
	for(var/datum/fruit_segment/comp as anything in get_composition())
		if(!comp.contributes_to_fruit_icon)
			continue
		var/remaining = comp.dissect_amount - LAZYACCESS(removed_segments, comp)
		if(remaining > 0)
			for(var/i = 1 to remaining)
				add_overlay(image(icon, "[comp.icon_state][++comp_count[comp.name]]"))

/obj/item/food/fruit/get_examine_strings(mob/user, distance, infix, suffix)
	. = ..()
	if(distance > 1)
		return
	if(examine_info && (!examine_info_skill || !examine_info_rank || user.skill_check(examine_info_skill, examine_info_rank)))
		. += examine_info

/obj/item/food/fruit/get_examine_hints(mob/user, distance, infix, suffix)
	. = ..()
	if(distance > 1)
		return
	var/list/fruit_comp_strings = list()
	for(var/datum/fruit_segment/comp as anything in get_composition())
		var/remaining = comp.dissect_amount - LAZYACCESS(removed_segments, comp)
		if(remaining <= 0)
			continue
		if(!comp.dissect_skill || !comp.dissect_skill_requirement || user.skill_check(comp.dissect_skill, comp.dissect_skill_requirement))
			var/decl/tool_archetype/tool = comp.dissect_tool && GET_DECL(comp.dissect_tool)
			var/comp_string_index = tool?.name ? ADD_ARTICLE(tool.name) : "your hands"
			LAZYINITLIST(fruit_comp_strings[comp_string_index])
			fruit_comp_strings[comp_string_index][comp.name] += comp.dissect_amount

	for(var/comp_ind in fruit_comp_strings)
		var/list/comp_string_comps = list()
		for(var/comp_string in fruit_comp_strings[comp_ind])
			comp_string_comps += "[fruit_comp_strings[comp_ind][comp_string]] [comp_string]\s"
		if(length(comp_string_comps))
			LAZYADD(., SPAN_NOTICE("With [comp_ind], you could harvest [english_list(comp_string_comps)]."))

/obj/item/food/fruit/attackby(obj/item/W, mob/living/user)
	if(!user?.check_intent(I_FLAG_HARM))
		var/list/fruit_comp = get_composition()
		for(var/datum/fruit_segment/comp as anything in fruit_comp)
			var/remaining = comp.dissect_amount - LAZYACCESS(removed_segments, comp)
			if(remaining <= 0 || !comp.dissect_tool || !W.get_tool_quality(comp.dissect_tool))
				continue
			comp.on_harvest(W, user, src)
			return TRUE
	return ..()

/obj/item/food/fruit/attack_self(mob/user)
	var/list/fruit_comp = get_composition()
	for(var/datum/fruit_segment/comp as anything in fruit_comp)
		var/remaining = comp.dissect_amount - LAZYACCESS(removed_segments, comp)
		if(remaining <= 0 || comp.dissect_tool)
			continue
		if(!comp.dissect_skill || !comp.dissect_skill_requirement || user.skill_check(comp.dissect_skill, comp.dissect_skill_requirement))
			comp.on_harvest(null, user, src)
			return TRUE
	return ..()

/obj/item/food/fruit/proc/get_composition()
	return

/obj/item/food/fruit/proc/remove_segment(var/datum/fruit_segment/remove_comp)

	LAZYINITLIST(removed_segments)
	removed_segments[remove_comp]++
	if(reagents?.total_volume && remove_comp.contributes_to_fruit_reagents)
		for(var/rid in remove_comp.reagents)
			reagents.remove_reagent(rid, remove_comp.reagents[rid])

	var/list/fruit_comp = get_composition()
	for(var/datum/fruit_segment/comp as anything in fruit_comp)
		var/remaining = comp.dissect_amount - LAZYACCESS(removed_segments, comp)
		if(remaining > 0)
			update_icon()
			return

	qdel(src)
