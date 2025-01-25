// ANIMA OVERRIDES
/decl/stack_recipe/potentia
	recipe_skill = /decl/skill/crafting/artifice

/obj/item/runestone
	work_skill = /decl/skill/crafting/artifice

/decl/material/solid/potentia
	arcana_skill = SKILL_SCIENCE

/decl/runestone_spell_archetype
	arcana_skill = SKILL_SCIENCE

// Removal of space skills
/datum/map/shaded_hills/get_available_skill_types()
	. = ..()
	. -= list(
		SKILL_EVA,
		SKILL_MECH,
		SKILL_PILOT,
		SKILL_COMPUTER,
		SKILL_FORENSICS,
		SKILL_ELECTRICAL,
		SKILL_ATMOS,
		SKILL_ENGINES,
		SKILL_DEVICES,
		SKILL_CONSTRUCTION, // Anything using this should be replaced with another skill.
	)
