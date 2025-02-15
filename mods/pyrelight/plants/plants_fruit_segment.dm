/datum/unit_test/icon_test/food_shall_have_icon_states/assemble_skipped_types()
	..()
	skip_types |= typesof(/obj/item/food/fruit_segment)

/obj/item/food/fruit_segment
	name = "abstract fruit segment"
	is_spawnable_type = FALSE
	material = /decl/material/solid/organic/plantmatter
	var/datum/fruit_segment/fruit_template

/obj/item/food/fruit_segment/Destroy()
	. = ..()
	fruit_template = null

/obj/item/food/fruit_segment/Initialize(ml, material_key, datum/fruit_segment/_template, obj/item/_fruit)
	if(!_template)
		PRINT_STACK_TRACE("Fruit segment created with no template datum.")
		return INITIALIZE_HINT_QDEL
	name = _template.name
	desc = _template.desc
	icon = _fruit.icon
	icon_state = "seg_[_template.icon_state]"
	fruit_template = _template
	return ..()

/obj/item/food/fruit_segment/initialize_reagents(populate)
	create_reagents(fruit_template.reagent_total)
	return ..()

/obj/item/food/fruit_segment/populate_reagents()
	for(var/rid in fruit_template.reagents)
		reagents.add_reagent(rid, fruit_template.reagents[rid])
	return ..()

/obj/item/food/fruit_segment/get_examine_strings(mob/user, distance, infix, suffix)
	. = ..()
	if(distance <= 1 && fruit_template.examine_info && (!fruit_template.examine_info_skill || !fruit_template.examine_info_rank || user.skill_check(fruit_template.examine_info_skill, fruit_template.examine_info_rank)))
		. += fruit_template.examine_info
