/obj/screen/robot/inventory
	name              = "inventory"
	icon_state        = "inventory"
	screen_loc        = ui_borg_inventory

/obj/screen/robot/inventory/handle_click(mob/user, params)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(R.module)
			R.hud_used.toggle_show_robot_modules()
			return 1
		to_chat(R, "You haven't selected a module yet.")
