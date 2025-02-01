/obj/screen/robot/module/select
	name              = "module"
	icon              = 'icons/mob/screen/styles/robot/module.dmi'
	icon_state        = "nomod"
	screen_loc        = ui_borg_module

/obj/screen/robot/module/select/on_update_icon()
	. = ..()
	icon_state = initial(icon_state)
	var/mob/living/silicon/robot/owner = owner_ref?.resolve()
	if(istype(owner) && owner.modtype)
		icon_state = lowertext(owner.modtype)

/obj/screen/robot/module/select/handle_click(mob/user, params)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		R.pick_module()
