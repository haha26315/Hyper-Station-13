//process
/obj/machinery/cloudcatcher
	name = "CloudCatcher"
	desc = "Uses Layenia crystals recrystalized onto uninsulated gold wiring to reduce local gravity and induce flight in an area."
	layer = ABOVE_OBJ_LAYER
	var/duration = 30 // How long tiles should continue having no gravity after being pulled away
	var/forced_value = 0 // What value the gravity is set to
	var/range = 10 //What range the gravity should be changed within

	var/flyDuration = 30

	density = TRUE
	use_power = NO_POWER_USE
	//idle_power_usage = 5
	//active_power_usage = 1000

	icon = 'icons/machinery/cloudcatcher.dmi'
	icon_state = "online"


	var/datum/proximity_monitor/advanced/dampening_field
	var/list/atom/movable/tracked
	var/image/effect
	var/field_radius = 3
	var/active = FALSE

	//var/consoleless_interface = FALSE			//Whether it can be used without a console.
	//var/list/categories = list()
	//var/datum/component/remote_materials/materials
	//var/allowed_department_flags = ALL
	//var/production_animation				//What's flick()'d on print.
	//var/allowed_buildtypes = NONE
	//var/list/datum/design/cached_designs
	//var/list/datum/design/matching_designs
	//var/screen = RESEARCH_FABRICATOR_SCREEN_MAIN
	//var/selected_category

/obj/machinery/Initialize()
	GLOB.machines += src

	//START_PROCESSING(SSfastprocess, src)

	//START_PROCESSING(SSmachines, src)
	//if(ispath(circuit, /obj/item/circuitboard))
	//	circuit = new circuit
	//	circuit.apply_default_parts(src)

	//if(!speed_process)
	//	START_PROCESSING(SSmachines, src)
	//else
	//
	//power_change()
	//RegisterSignal(src, COMSIG_ENTER_AREA, .proc/power_change)

	//if (occupant_typecache)
	//	occupant_typecache = typecacheof(occupant_typecache)

/*
/obj/machinery/cloudcatcher/process()

	for(var/turf/T in view(range,src))

		var/datum/component/C = T.AddComponent(/datum/component/forced_gravity,forced_value)
			QDEL_IN(C,duration)

	for(var/mob/living/M in view(range,src))

		M.flying = TRUE

		var/list/flying = list()
		//flying |= M
		var/datum/component/temp_flight/F = M.AddComponent(/datum/component/temp_flight(flyDuration))
		//INVOKE_ASYNC(src, .proc/removeTempFlight, flying)

/obj/machinery/cloudcatcher/proc/removeTempFlight(list/flying)

	sleep(flyDuration)

	for(var/mob/living/M in flying)
		if(!M && !QDELETED(M))
			M.flying = FALSE


/datum/component/temp_flight
	var/mood //Real happiness
	var/sanity = 100 //Current sanity
	var/shown_mood //Shown happiness, this is what others can see when they try to examine you, prevents antag checking by noticing traitors are always very happy.
	var/mood_level = 5 //To track what stage of moodies they're on
	var/sanity_level = 5 //To track what stage of sanity they're on
	var/mood_modifier = 1 //Modifier to allow certain mobs to be less affected by moodlets
	var/datum/mood_event/list/mood_events = list()
	var/insanity_effect = 0 //is the owner being punished for low mood? If so, how much?
	var/holdmyinsanityeffect = 0 //before we edit our sanity lets take a look
	var/obj/screen/mood/screen_obj
	var/lastupdate = 0

/datum/component/mood/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	//START_PROCESSING(SSmood, src)

	//RegisterSignal(parent, COMSIG_ADD_MOOD_EVENT, .proc/add_event)
	//RegisterSignal(parent, COMSIG_CLEAR_MOOD_EVENT, .proc/clear_event)
	//RegisterSignal(parent, COMSIG_INCREASE_SANITY, .proc/IncreaseSanity)
	//RegisterSignal(parent, COMSIG_DECREASE_SANITY, .proc/DecreaseSanity)

	//RegisterSignal(parent, COMSIG_MOB_HUD_CREATED, .proc/modify_hud)
	//var/mob/living/owner = parent
	//if(owner.hud_used)
	//	modify_hud()
	//	var/datum/hud/hud = owner.hud_used
	//	hud.show_hud(hud.hud_version)

/datum/component/mood/Destroy()
	STOP_PROCESSING(SSmood, src)
	unmodify_hud()
	return ..()
*/
/*
/datum/component/mood/proc/update_mood() //Called whenever a mood event is added or removed
	mood = 0
	shown_mood = 0
	for(var/i in mood_events)
		var/datum/mood_event/event = mood_events[i]
		mood += event.mood_change
		if(!event.hidden)
			shown_mood += event.mood_change

	mood *= mood_modifier
	shown_mood *= mood_modifier

	switch(mood)
		if(-INFINITY to MOOD_LEVEL_SAD4)
			mood_level = 1
		if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
			mood_level = 2
		if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
			mood_level = 3
		if(MOOD_LEVEL_SAD2 to MOOD_LEVEL_SAD1)
			mood_level = 4
		if(MOOD_LEVEL_SAD1 to MOOD_LEVEL_HAPPY1)
			mood_level = 5
		if(MOOD_LEVEL_HAPPY1 to MOOD_LEVEL_HAPPY2)
			mood_level = 6
		if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
			mood_level = 7
		if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
			mood_level = 8
		if(MOOD_LEVEL_HAPPY4 to INFINITY)
			mood_level = 9
	update_mood_icon()


/datum/component/mood/proc/update_mood_icon()
	var/mob/living/owner = parent
	if(owner.client && owner.hud_used)
		if(sanity < 25)
			screen_obj.icon_state = "mood_insane"
		else if (owner.has_status_effect(/datum/status_effect/chem/enthrall))//Fermichem enthral chem, maybe change?
			screen_obj.icon_state = "mood_entrance"
		else
			screen_obj.icon_state = "mood[mood_level]"
*/

/datum/component/temp_flight/process() //Called on SSmood process
	if(QDELETED(parent)) // workaround to an obnoxious sneaky periodical runtime.
		qdel(src)
		return
	var/mob/living/owner = parent

	switch(mood_level)
		if(1)
			DecreaseSanity(src, 0.2)
		if(2)
			DecreaseSanity(src, 0.125, SANITY_CRAZY)
		if(3)
			DecreaseSanity(src, 0.075, SANITY_UNSTABLE)
		if(4)
			DecreaseSanity(src, 0.025, SANITY_DISTURBED)
		if(5)
			IncreaseSanity(src, 0.1)
		if(6)
			IncreaseSanity(src, 0.15)
		if(7)
			IncreaseSanity(src, 0.20)
		if(8)
			IncreaseSanity(src, 0.25, SANITY_GREAT)
		if(9)
			IncreaseSanity(src, 0.4, SANITY_GREAT)

	if(insanity_effect != holdmyinsanityeffect)
		if(insanity_effect > holdmyinsanityeffect)
			owner.crit_threshold += (insanity_effect - holdmyinsanityeffect)
		else
			owner.crit_threshold -= (holdmyinsanityeffect - insanity_effect)

	holdmyinsanityeffect = insanity_effect

	HandleNutrition(owner)
	HandleThirst(owner)


/*
//Peacekeeper Cyborg Projectile Dampenening Field
/obj/item/borg/projectile_dampen
	name = "\improper Hyperkinetic Dampening projector"
	desc = "A device that projects a dampening field that weakens kinetic energy above a certain threshold. <span class='boldnotice'>Projects a field that drains power per second while active, that will weaken and slow damaging projectiles inside its field.</span> Still being a prototype, it tends to induce a charge on ungrounded metallic surfaces."
	icon = 'icons/obj/device.dmi'
	icon_state = "shield"
	var/maxenergy = 1500
	var/energy = 1500
	var/energy_recharge = 7.5
	var/energy_recharge_cyborg_drain_coefficient = 0.4
	var/cyborg_cell_critical_percentage = 0.05
	var/mob/living/silicon/robot/host = null
	var/datum/proximity_monitor/advanced/dampening_field
	var/projectile_damage_coefficient = 0.5
	var/projectile_damage_tick_ecost_coefficient = 2	//Lasers get half their damage chopped off, drains 50 power/tick. Note that fields are processed 5 times per second.
	var/projectile_speed_coefficient = 1.5		//Higher the coefficient slower the projectile.
	var/projectile_tick_speed_ecost = 15
	var/list/obj/item/projectile/tracked
	var/image/projectile_effect
	var/field_radius = 3
	var/active = FALSE
	var/cycle_delay = 0
*/
/*
/obj/item/borg/projectile_dampen/debug
	maxenergy = 50000
	energy = 50000
	energy_recharge = 5000
*/

/obj/machinery/cloudcatcher/Initialize()
	. = ..()
	effect = image('icons/effects/fields.dmi', "projectile_dampen_effect")
	tracked = list()
	icon_state = "shield0"
	START_PROCESSING(SSfastprocess, src)
	host = loc

/obj/machinery/cloudcatcher/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/*
/obj/item/borg/projectile_dampen/attack_self(mob/user)
	if(cycle_delay > world.time)
		to_chat(user, "<span class='boldwarning'>[src] is still recycling its projectors!</span>")
		return
	cycle_delay = world.time + PKBORG_DAMPEN_CYCLE_DELAY
	if(!active)
		if(!user.has_buckled_mobs())
			activate_field()
		else
			to_chat(user, "<span class='warning'>[src]'s safety cutoff prevents you from activating it due to living beings being ontop of you!</span>")
	else
		deactivate_field()
	update_icon()
	to_chat(user, "<span class='boldnotice'>You [active? "activate":"deactivate"] [src].</span>")
*/
/obj/machinery/cloudcatcher/update_icon()
	icon_state = "[initial(icon_state)][active]"

/obj/machinery/cloudcatcher/proc/activate_field()
	if(istype(dampening_field))
		QDEL_NULL(dampening_field)
	dampening_field = make_field(/datum/proximity_monitor/advanced/peaceborg_dampener, list("current_range" = field_radius, "host" = src, "projector" = src))
	var/mob/living/silicon/robot/owner = get_host()
	if(owner)
		owner.module.allow_riding = FALSE
	active = TRUE

/obj/machinery/cloudcatcher/proc/deactivate_field()
	QDEL_NULL(dampening_field)
	visible_message("<span class='warning'>\The [src] shuts off!</span>")
	for(var/P in tracked)
		restore_gravity(P)
	active = FALSE

	var/mob/living/silicon/robot/owner = get_host()
	if(owner)
		owner.module.allow_riding = TRUE

/obj/machinery/cloudcatcher/proc/get_host()
	return src

/*
/obj/machinery/cloudcatcher/dropped()
	. = ..()
	host = loc

/obj/item/borg/projectile_dampen/equipped()
	. = ..()
	host = loc

/obj/item/borg/projectile_dampen/on_mob_death()
	deactivate_field()
	. = ..()
*/
/obj/machinery/cloudcatcher/process()
	//process_recharge()
	//process_usage()
	update_location()

/obj/machinery/cloudcatcher/proc/update_location()
	if(dampening_field)
		dampening_field.HandleMove()
/*
/obj/machinery/cloudcatcher/proc/process_usage()
	var/usage = 0
	for(var/I in tracked)
		var/obj/item/projectile/P = I
		if(!P.stun && P.nodamage)	//No damage
			continue
		usage += projectile_tick_speed_ecost
		usage += (tracked[I] * projectile_damage_tick_ecost_coefficient)
	energy = CLAMP(energy - usage, 0, maxenergy)
	if(energy <= 0)
		deactivate_field()
		visible_message("<span class='warning'>[src] blinks \"ENERGY DEPLETED\".</span>")

/obj/item/borg/projectile_dampen/proc/process_recharge()
	if(!istype(host))
		if(iscyborg(host.loc))
			host = host.loc
		else
			energy = CLAMP(energy + energy_recharge, 0, maxenergy)
			return
	if(host.cell && (host.cell.charge >= (host.cell.maxcharge * cyborg_cell_critical_percentage)) && (energy < maxenergy))
		host.cell.use(energy_recharge*energy_recharge_cyborg_drain_coefficient)
		energy += energy_recharge
*/
/obj/machinery/cloudcatcher/proc/dampen_gravity(atom/movable/A, track = TRUE)
	if(tracked[A])
		return
	//if(track_projectile)
	//	tracked[P] = P.damage
	//P.damage *= projectile_damage_coefficient
	//P.speed *= projectile_speed_coefficient
	A.add_overlay(projectile_effect)

/obj/machinery/cloudcatcher/proc/restore_gravity(atom/movable/A)
	tracked -= A
	//P.damage *= (1/projectile_damage_coefficient)
	//P.speed *= (1/projectile_speed_coefficient)
	A.cut_overlay(effect)