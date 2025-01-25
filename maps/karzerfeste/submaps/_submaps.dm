#define MAP_TEMPLATE_CATEGORY_KARZ_DUNGEON "template_karz_dungeon"

/datum/map_template/karzerfeste
	abstract_type = /datum/map_template/karzerfeste
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS
	area_usage_test_exempted_root_areas = list(
		/area/karzerfeste/caves/point_of_interest
	)
	var/cost = 1

/datum/map_template/karzerfeste/get_template_cost()
	return cost

/area/karzerfeste/caves/point_of_interest
	name        = "Point Of Interest"
	description = null

/area/karzerfeste/caves/point_of_interest/dungeon
	name        = "Point of Interest - Dungeon"

/area/karzerfeste/caves/point_of_interest/dungeon/hallway
	name        = "Point Of Interest - Dungeon Hallway"

/datum/map_template/karzerfeste/dungeon
	abstract_type = /datum/map_template/karzerfeste/dungeon
	template_categories = list(MAP_TEMPLATE_CATEGORY_KARZ_DUNGEON)
	area_usage_test_exempted_root_areas = list(
		/area/karzerfeste/caves/point_of_interest/dungeon
	)

/datum/map_template/karzerfeste/dungeon/barracks
	name     = "dungeon barracks"
	mappaths = list("maps/karzerfeste/submaps/dungeon_barracks.dmm")

/datum/map_template/karzerfeste/dungeon/butchery
	name     = "dungeon butchery"
	mappaths = list("maps/karzerfeste/submaps/dungeon_butchery.dmm")

/datum/map_template/karzerfeste/dungeon/hall
	name     = "dungeon feasting hall"
	mappaths = list("maps/karzerfeste/submaps/dungeon_feasting_hall.dmm")

/datum/map_template/karzerfeste/dungeon/foundry
	name     = "dungeon foundry"
	mappaths = list("maps/karzerfeste/submaps/dungeon_foundry.dmm")

/datum/map_template/karzerfeste/dungeon/kitchen
	name     = "dungeon kitchen"
	mappaths = list("maps/karzerfeste/submaps/dungeon_kitchen.dmm")

/datum/map_template/karzerfeste/dungeon/library
	name     = "dungeon library"
	mappaths = list("maps/karzerfeste/submaps/dungeon_library.dmm")

/datum/map_template/karzerfeste/dungeon/pool_small
	name     = "dungeon small pool"
	mappaths = list("maps/karzerfeste/submaps/dungeon_pool_small.dmm")

/datum/map_template/karzerfeste/dungeon/pool
	name     = "dungeon pool"
	mappaths = list("maps/karzerfeste/submaps/dungeon_pool.dmm")

/datum/map_template/karzerfeste/dungeon/smithy
	name     = "dungeon smithy"
	mappaths = list("maps/karzerfeste/submaps/dungeon_smithy.dmm")

/datum/map_template/karzerfeste/dungeon/surgery
	name     = "dungeon surgery"
	mappaths = list("maps/karzerfeste/submaps/dungeon_surgery.dmm")

/datum/map_template/karzerfeste/dungeon/workshop
	name     = "dungeon workshop"
	mappaths = list("maps/karzerfeste/submaps/dungeon_workshop.dmm")

/datum/map_template/karzerfeste/dungeon/spider_nest
	name     = "dungeon spider nest"
	mappaths = list("maps/karzerfeste/submaps/dungeon_spider_nest.dmm")

/datum/map_template/karzerfeste/dungeon/hallway
	abstract_type                    = /datum/map_template/karzerfeste/dungeon/hallway
	template_flags                   = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_ALLOW_DUPLICATES | TEMPLATE_FLAG_GENERIC_REPEATABLE
	area_coherency_test_exempt_areas = list(/area/karzerfeste/caves/point_of_interest/dungeon/hallway)

/datum/map_template/karzerfeste/dungeon/hallway/vertical_aqueduct
	name     = "dungeon vertical aqueduct"
	mappaths = list("maps/karzerfeste/submaps/dungeon_vertical_aqueduct.dmm")

/datum/map_template/karzerfeste/dungeon/hallway/horizontal_aqueduct
	name     = "dungeon horizontal aqueduct"
	mappaths = list("maps/karzerfeste/submaps/dungeon_horizontal_aqueduct.dmm")

/datum/map_template/karzerfeste/dungeon/hallway/vertical_hallway
	name     = "dungeon vertical hallway"
	mappaths = list("maps/karzerfeste/submaps/dungeon_vertical_hallway.dmm")

/datum/map_template/karzerfeste/dungeon/hallway/horizontal_hallway
	name     = "dungeon horizontal hallway"
	mappaths = list("maps/karzerfeste/submaps/dungeon_horizontal_hallway.dmm")
