/mob/living/carbon/human/examine(mob/user, distance/* INF ahead */, mirror = 0)
	. = TRUE
	var/skipgloves = 0
	var/skipsuitstorage = 0
	var/skipjumpsuit = 0
	var/skipshoes = 0
	var/skipmask = 0
	var/skipears = 0
	var/skipeyes = 0
	var/skipface = 0

	//exosuits and helmets obscure our view and stuff.
	if(wear_suit)
		skipgloves = wear_suit.flags_inv & HIDEGLOVES
		skipsuitstorage = wear_suit.flags_inv & HIDESUITSTORAGE
		skipjumpsuit = wear_suit.flags_inv & HIDEJUMPSUIT
		skipshoes = wear_suit.flags_inv & HIDESHOES

	if(head)
		skipmask = head.flags_inv & HIDEMASK
		skipeyes = head.flags_inv & HIDEEYES
		skipears = head.flags_inv & HIDEEARS
		skipface = head.flags_inv & HIDEFACE

	if(wear_mask)
		skipeyes |= wear_mask.flags_inv & HIDEEYES
		skipears |= wear_mask.flags_inv & HIDEEARS
		skipface |= wear_mask.flags_inv & HIDEFACE

	//no accuately spotting headsets from across the room.
	if(distance > 3)
		skipears = 1

	var/list/msg = list("<span class='info'>*---------*\nThis is ")

	var/datum/gender/T = gender_datums[get_gender()]
	if(skipjumpsuit && skipface) //big suits/masks/helmets make it hard to tell their gender
		T = gender_datums[PLURAL]

	else if(species && species.ambiguous_genders)
		var/can_detect_gender = FALSE
		if(isobserver(user)) // Ghosts are all knowing.
			can_detect_gender = TRUE
		if(issilicon(user)) // Borgs are too because science.
			can_detect_gender = TRUE
		else if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.species && istype(species, H.species))
				can_detect_gender = TRUE

		if(!can_detect_gender)
			T = gender_datums[PLURAL] // Species with ambiguous_genders will not show their true gender upon examine if the examiner is not also the same species.
	else
		if(icon)
			msg += "[icon2html(icon, user)] " //fucking BYOND: this should stop dreamseeker crashing if we -somehow- examine somebody before their icon is generated

	if(!T)
		// Just in case someone VVs the gender to something strange. It'll runtime anyway when it hits usages, better to CRASH() now with a helpful message.
		CRASH("Gender datum was null; key was '[(skipjumpsuit && skipface) ? PLURAL : gender]'")

	msg += "<EM>[src.name]</EM>"

	var/is_synth = isSynthetic()
	if(!(skipjumpsuit && skipface))
		var/species_name = "\improper "
		if(is_synth && species.cyborg_noun)
			species_name += "[species.cyborg_noun] [species.get_bodytype(src)]"
		else
			species_name += "[species.name]"
		msg += ", <b><font color='[species.get_flesh_colour(src)]'>\a [species_name]!</font></b>[(user.can_use_codex() && SScodex.get_codex_entry(get_codex_value())) ?  SPAN_NOTICE(" \[<a href='?src=\ref[SScodex];show_examined_info=\ref[src];show_to=\ref[user]'>?</a>\]") : ""]"

	var/extra_species_text = species.get_additional_examine_text(src)
	if(extra_species_text)
		msg += "[extra_species_text]<br>"

	msg += "<br>"

	//uniform
	if(w_uniform && !skipjumpsuit)
		msg += "???? ???????? [w_uniform.get_examine_line()].\n"

	//head
	if(head)
		msg += "???? ???????????? [head.get_examine_line()].\n"

	//suit/armour
	if(wear_suit)
		msg += "???????????? ???????????? ?????????? [wear_suit.get_examine_line()].\n"
		//suit/armour storage
		if(s_store && !skipsuitstorage)
			msg += "?????????? [s_store.get_examine_line()] [wear_suit.name].\n"

	//back
	if(back)
		msg += "???? ?????????? [back.get_examine_line()].\n"

	//left hand
	if(l_hand)
		msg += "?? ?????????? ???????? ???????????? [l_hand.get_examine_line()].\n"

	//right hand
	if(r_hand)
		msg += "?? ???????????? ???????? ???????????? [r_hand.get_examine_line()].\n"

	//gloves
	if(gloves && !skipgloves)
		msg += "???? ?????????? ?????????????????? [gloves.get_examine_line()].\n"
	else if(blood_DNA)
		msg += "<span class='warning'>???????????????? ?????????????????? [(hand_blood_color != SYNTH_BLOOD_COLOUR) ? "????????????" : "????????????"]!</span>\n"

	//belt
	if(belt)
		msg += "???? ?????????? ???????????? [belt.get_examine_line()].\n"

	//shoes
	if(shoes && !skipshoes)
		msg += "???? ?????????? [shoes.get_examine_line()].\n"
	else if(feet_blood_DNA)
		msg += "<span class='warning'>?????????????????????? [(feet_blood_color != SYNTH_BLOOD_COLOUR) ? "????????????" : "????????????"]!</span>\n"

	//mask
	if(wear_mask && !skipmask)
		msg += "???? ???????? [wear_mask.get_examine_line()].\n"

	//eyes
	if(glasses && !skipeyes)
		msg += "?????????? ?????????????? [glasses.get_examine_line()].\n"

	//left ear
	if(l_ear && !skipears)
		msg += "?? ?????????? ?????? [l_ear.get_examine_line()].\n"

	//right ear
	if(r_ear && !skipears)
		msg += "???? ?? ?? ???????????? [r_ear.get_examine_line()].\n"

	//ID
	if(wear_id)
		msg += "?????????? ???? ???????? [wear_id.get_examine_line()].\n"

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/handcuffs/cable))
			msg += "<span class='warning'>???????????? [icon2html(handcuffed, user)] ?? ??????????????!</span>\n"
		else
			msg += "<span class='warning'>?????????? ???????????? ?? [icon2html(handcuffed, user)] ????????????????????!</span>\n"

	//buckled
	if(buckled)
		msg += "<span class='warning'>???????????????? [icon2html(buckled, user)] ???????????????????????? [buckled]!</span>\n"

	//Jitters
	if(is_jittery)
		if(jitteriness >= 300)
			msg += "<span class='warning'><B>[T.He] [T.is] ?????????? ???????????? ????????????????!</B></span>\n"
		else if(jitteriness >= 200)
			msg += "<span class='warning'>[T.He] [T.is] ???????????????? ????????????????.</span>\n"
		else if(jitteriness >= 100)
			msg += "<span class='warning'>[T.He] [T.is] ?????????????????? ??????????????????????.</span>\n"

	//Disfigured face
	if(!skipface) //Disfigurement only matters for the head currently.
		var/obj/item/organ/external/head/E = get_organ(BP_HEAD)
		if(E && (E.status & ORGAN_DISFIGURED)) //Check to see if we even have a head and if the head's disfigured.
			if(E.species) //Check to make sure we have a species
				msg += E.species.disfigure_msg(src)
			else //Just in case they lack a species for whatever reason.
				msg += "<span class='warning'>???????? ???????????????? ??????????????????????!</span>\n"

	//splints
	for(var/organ in list(BP_L_LEG, BP_R_LEG, BP_L_ARM, BP_R_ARM))
		var/obj/item/organ/external/o = get_organ(organ)
		if(o && o.splinted && o.splinted.loc == o)
			msg += "<span class='warning'>???? [o.name] ?????????????????? ????????!</span>\n"

	if(mSmallsize in mutations)
		msg += "[T.He] [T.is] small halfling!\n"

	if (src.stat)
		msg += "<span class='warning'>???? ???????????????? ?? ???????????????? ??????, ?????????? ?????????????????? ?????? ????????????????.</span>\n"
		if((stat == DEAD || /*INF*/status_flags & FAKEDEATH ||/*/INF*/ is_asystole() || src.losebreath) && distance <= 3)
			msg += "<span class='warning'>???? ??????????.</span>\n"

	if (fire_stacks > 0)
		msg += "[T.He] ???????????????? ??????????????.\n"
	else if (fire_stacks < 0)
		msg += "[T.He] looks wet.\n"
	if(on_fire)
		msg += "<span class='warning'>??????????!.</span>\n"

	var/ssd_msg = species.get_ssd(src)
	if(ssd_msg && (!should_have_organ(BP_BRAIN) || has_brain()) && stat != DEAD \
	&& !(status_flags & FAKEDEATH)) //INF
		if(!key)
			msg += "<span class='deadsay'>???? ?????????? ???????????? ?? ????????.</span>\n"
		else if(!client)
			msg += "<span class='deadsay'>????????, ???????????</span>\n"

	if (admin_paralyzed)
		msg += SPAN_DEBUG("OOC: [T.He] [T.has] been paralyzed by staff. Please avoid interacting with [T.him] unless cleared to do so by staff.") + "\n"

	var/obj/item/organ/external/head/H = organs_by_name[BP_HEAD]
	if(istype(H) && H.forehead_graffiti && H.graffiti_style)
		if(user != src || mirror) //INF
			msg += "<span class='notice'>[T.He] [T.has] \"[H.forehead_graffiti]\" written on [T.his] [H.name] in [H.graffiti_style]!</span>\n"

	if(became_younger)
		msg += "???????????????? ?????????????? ????????????. ???? ?????????????? ???????????? ????????.\n"
	if(became_older)
		msg += "???????????????? ?????????????? ????????????. ???? ?????????????? ???????????? ????????.\n"

	var/list/wound_flavor_text = list()
	var/applying_pressure = ""
	var/list/shown_objects = list()
	var/list/hidden_bleeders = list()

	for(var/organ_tag in species.has_limbs)

		var/list/organ_data = species.has_limbs[organ_tag]
		var/organ_descriptor = organ_data["descriptor"]
		var/obj/item/organ/external/E = organs_by_name[organ_tag]

		if(!E)
			wound_flavor_text[organ_descriptor] = "<b>?????????????????????? [organ_descriptor].</b>\n"
			continue

		wound_flavor_text[E.name] = ""

		if(E.applied_pressure == src)
			applying_pressure = "<span class='info'>?????????? ???? [E.name].</span><br>"

		var/obj/item/clothing/hidden
		var/list/clothing_items = list(head, wear_mask, wear_suit, w_uniform, gloves, shoes)
		for(var/obj/item/clothing/C in clothing_items)
			if(istype(C) && (C.body_parts_covered & E.body_part))
				hidden = C
				break

		if(hidden && user != src)
			if(E.status & ORGAN_BLEEDING && !(hidden.item_flags & ITEM_FLAG_THICKMATERIAL)) //not through a spacesuit
				if(!hidden_bleeders[hidden])
					hidden_bleeders[hidden] = list()
				hidden_bleeders[hidden] += E.name
		else
			if(E.is_stump())
				wound_flavor_text[E.name] += "<b>?????????? ?????????????? ??????, ?????? ???????????? ???????? [organ_descriptor].</b>\n"
				if(LAZYLEN(E.wounds) && E.parent)
					wound_flavor_text[E.name] += "[T.He] [T.has] [E.get_wounds_desc()] on [T.his] [E.parent.name].<br>"
			else
				if(!is_synth && BP_IS_ROBOTIC(E) && (E.parent && !BP_IS_ROBOTIC(E.parent) && !BP_IS_ASSISTED(E.parent)))
					wound_flavor_text[E.name] = "[T.He] [T.has] a [E.name].\n"
				var/wounddesc = E.get_wounds_desc()
				if(wounddesc != "nothing")
					wound_flavor_text[E.name] += "[T.He] [T.has] [wounddesc] on [T.his] [E.name].<br>"
		if(!hidden || distance <=1)
			if(E.dislocated > 0)
				wound_flavor_text[E.name] += "???????????????? ????????????!<br>"
			if(((E.status & ORGAN_BROKEN) && E.brute_dam > E.min_broken_damage) || (E.status & ORGAN_MUTATED))
				wound_flavor_text[E.name] += "[E.name] ?? ?????????????? ??????????????????!<br>"

		for(var/datum/wound/wound in E.wounds)
			var/list/embedlist = wound.embedded_objects
			if(LAZYLEN(embedlist))
				shown_objects += embedlist
				var/parsedembed[0]
				for(var/obj/embedded in embedlist)
					if(!parsedembed.len || (!list_find(parsedembed, embedded.name) && !list_find(parsedembed, "multiple [embedded.name]")))
						parsedembed.Add(embedded.name)
					else if(!list_find(parsedembed, "multiple [embedded.name]"))
						parsedembed.Remove(embedded.name)
						parsedembed.Add("multiple "+embedded.name)
				wound_flavor_text["[E.name]"] += "???? [wound.desc] ?? [E.name] ???????????? [english_list(parsedembed, and_text = " and \a ", comma_text = ", \a ")]!<br>"
	for(var/hidden in hidden_bleeders)
		wound_flavor_text[hidden] = "?????????? ?????????????? ???????????? [hidden] ?????????? [english_list(hidden_bleeders[hidden])]!<br>"

	msg += "<span class='warning'>"
	for(var/limb in wound_flavor_text)
		msg += wound_flavor_text[limb]
	msg += "</span>"

	for(var/obj/implant in get_visible_implants(0))
		if(implant in shown_objects)
			continue
		msg += "<span class='danger'>[src] ???? ???????? ???????????? [implant.name]!</span>\n"
	if(digitalcamo)
		msg += "[T.He] [T.is] repulsively uncanny!\n"

	if(hasHUD(user, HUD_SECURITY))
		var/perpname = "wot"
		var/criminal = "None"

		var/obj/item/card/id/id = GetIdCard()
		if(istype(id))
			perpname = id.registered_name
		else
			perpname = src.name

		if(perpname)
			var/datum/computer_file/report/crew_record/R = get_crewmember_record(perpname)
			if(R)
				criminal = R.get_criminalStatus()

			msg += "<span class = 'deptradio'>Criminal status:</span> <a href='?src=\ref[src];criminal=1'>\[[criminal]\]</a>\n"
			msg += "<span class = 'deptradio'>Security records:</span> <a href='?src=\ref[src];secrecord=`'>\[View\]</a>\n"

	if(hasHUD(user, HUD_MEDICAL))
		var/perpname = "wot"
		var/medical = "None"

		var/obj/item/card/id/id = GetIdCard()
		if(istype(id))
			perpname = id.registered_name
		else
			perpname = src.name

		var/datum/computer_file/report/crew_record/R = get_crewmember_record(perpname)
		if(R)
			medical = R.get_status()

		msg += "<span class = 'deptradio'>Physical status:</span> <a href='?src=\ref[src];medical=1'>\[[medical]\]</a>\n"
		msg += "<span class = 'deptradio'>Medical records:</span> <a href='?src=\ref[src];medrecord=`'>\[View\]</a>\n"


	if(print_flavor_text()) msg += "[print_flavor_text()]\n"

	if(isghost(user) && (public_record || med_record || sec_record || gen_record))
		msg += "<span class = 'deptradio'>Records:</span> <a href='?src=\ref[src];check_records=1'>\[View\]</a>\n"

	if(ooc_notes && !skipface)
		msg += "<span class = 'deptradio'>OOC Notes:</span> <a href='?src=\ref[src];ooc_notes=1'>\[View\]</a>\n"

	msg += "*---------*</span><br>"
	msg += applying_pressure

	if (pose)
		if( findtext(pose,".",length(pose)) == 0 && findtext(pose,"!",length(pose)) == 0 && findtext(pose,"?",length(pose)) == 0 )
			pose = addtext(pose,".") //Makes sure all emotes end with a period.
//[INF]
		switch(gender)
			if(MALE)  msg += "???? [pose]\n"
			if(FEMALE)msg += "?????? [pose]\n"
			else      msg += "?????? [pose]\n"

	if(user.mind.changeling)
		if(user == src)
			msg += SPAN_LING("????.\n")
		else if(isSynthetic())
			msg += SPAN_LING("?????????????????????? ?????????? ???????????? ?? ??????????????.\n")
		else if(MUTATION_HUSK in mutations)
			msg += SPAN_LING("?????????????????????? ?????????? ?????????? ???????????????? ???????????????????? ??????????????...\n")
		else if(species.species_flags & SPECIES_FLAG_NO_SCAN)
			msg += SPAN_LING("?????????? ?? ?????????????????? ?????????????????????? ?????????? ?????????? ????????????????... ????????????????????.\n")
		else if(stat == DEAD && world.time - timeofdeath > 3 MINUTES)
			msg += SPAN_LING("???????? ?????????????????????? ?????????? ?????? ?????????? ??????????????????????.\n")
		else if(islesserform(src))
			msg += SPAN_LING("???????? ?????????????????? ???? ???????? ?????? ???????????? ????????????... ???? ?????? ?????????????..\n")
		else if(check_compatable_genome())
			msg += SPAN_LING("<i>?????????????????????? ?????????? ?????????? ???????????????? ?????????? ???????? ??????-???? ??????????...</i>\n")
		else
			msg += SPAN_LING("?????????????????????? ????????????????...\n")
//[/INF]
/*[ORIG]
		if(gender == MALE)
			msg += "???? [pose]\n"
		else if(gender == FEMALE)
			msg += "?????? [pose]\n"
		else
			msg += "?????? [pose]\n"
[/ORIG]*/
	var/show_descs = show_descriptors_to(user, T)
	if(show_descs)
		msg += "<span class='notice'>[jointext(show_descs, "<br>")]</span>"
	to_chat(user, jointext(msg, null))

//Helper procedure. Called by /mob/living/carbon/human/examine() and /mob/living/carbon/human/Topic() to determine HUD access to security and medical records.
/proc/hasHUD(mob/M as mob, hudtype)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/clothing/glasses/G = H.glasses
		var/obj/item/card/id/ID = M.GetIdCard()
		var/obj/item/organ/internal/augment/active/hud/AUG
		for (var/obj/item/organ/internal/augment/active/hud/A in H.internal_organs) // Check for installed and active HUD implants
			if (A.hud_type & hudtype)
				AUG = A
				break

		return ((istype(G) && ((G.hud_type & hudtype) || (G.hud && (G.hud.hud_type & hudtype)))) && G.check_access(ID)) || AUG?.active && AUG.check_access(ID)
	else if(istype(M, /mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = M
		for(var/obj/item/borg/sight/sight in list(R.module_state_1, R.module_state_2, R.module_state_3))
			if(istype(sight) && (sight.hud_type & hudtype))
				return TRUE
	return FALSE

/mob/living/carbon/human/verb/pose()
	set name = "Set Pose"
	set desc = "Sets a description which will be shown when someone examines you."
	set category = "IC"

	pose =  sanitize(input(usr, "This is [src]. [get_visible_gender() == MALE ? "He" : get_visible_gender() == FEMALE ? "She" : "They"]...", "Pose", null)  as text)


/*  var/obj/item/organ/external/head/O = locate(/obj/item/organ/external/head) in organs
	if(O && O.get_teeth() < O.max_teeth)
		msg += "<span class='warning'><B>[O.get_teeth() <= 0 ? "All" : "[O.max_teeth - O.get_teeth()]"] [T.his] ?????????? ??????????????????????</B></span>\n" */


/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavour Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	var/list/HTML = list()
	HTML += "<meta charset=\"UTF-8\"><body>"
	HTML += "<tt><center>"
	HTML += "<b>Update Flavour Text</b> <hr />"
	HTML += "<br></center>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=general'>General:</a> "
	HTML += TextPreview(flavor_texts["general"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=head'>Head:</a> "
	HTML += TextPreview(flavor_texts["head"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=face'>Face:</a> "
	HTML += TextPreview(flavor_texts["face"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=eyes'>Eyes:</a> "
	HTML += TextPreview(flavor_texts["eyes"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=torso'>Body:</a> "
	HTML += TextPreview(flavor_texts["torso"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=arms'>Arms:</a> "
	HTML += TextPreview(flavor_texts["arms"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=hands'>Hands:</a> "
	HTML += TextPreview(flavor_texts["hands"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=legs'>Legs:</a> "
	HTML += TextPreview(flavor_texts["legs"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_change=feet'>Feet:</a> "
	HTML += TextPreview(flavor_texts["feet"])
	HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];flavor_change=done'>\[Done\]</a>"
	HTML += "<tt>"
	show_browser(src, jointext(HTML,null), "window=flavor_changes;size=430x300")
