/obj/screen/robot/store
	name       = "store"
	icon_state = "store"
	screen_loc = ui_borg_store

/obj/screen/robot/store/handle_click(mob/user, params)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(R.module)
			R.uneq_active()
			R.hud_used.update_robot_modules_display()
		else
			to_chat(R, "You haven't selected a module yet.")
