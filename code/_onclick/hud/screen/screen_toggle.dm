/obj/screen/toggle
	name = "toggle"
	icon_state = "other"
	screen_loc = ui_inventory

/obj/screen/toggle/handle_click(mob/user, params)
	if(!user.hud_used)
		return
	return user.hud_used.toggle_show_inventory()
