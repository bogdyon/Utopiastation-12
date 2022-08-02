//TODO: Convert this over for languages.
/mob/living/carbon/brain/say(var/message)
	if (silent)
		return

	message = sanitize(message)

	if(!(container && istype(container, /obj/item/device/mmi)))
		return //No MMI, can't speak, bucko./N
	else
		var/datum/language/speaking = parse_language(message)
		if(speaking)
			message = copytext(message, max(2+length(speaking.key),3)) //inf, was message = copytext(message, 2+length(speaking.key))
		var/verb = "says"
		var/ending = copytext(message, length(message) - 1)
		if (speaking)
			verb = speaking.get_spoken_verb(ending)
		else
			if(copytext(ending, length(ending))=="!")
				verb = pick("восклицает","выкрикивает") //INF, WAS verb=pick("exclaims","shouts","yells")
			if(copytext(ending, length(ending))=="?")
				verb = "спрашивает"  //INF, WAS verb="asks

		if(prob(emp_damage*4))
			if(prob(10))//10% chane to drop the message entirely
				return
			else
				message = Gibberish(message, (emp_damage*6))//scrambles the message, gets worse when emp_damage is higher

		if(speaking && speaking.flags & HIVEMIND)
			speaking.broadcast(src,trim(message))
			return

		if(istype(container, /obj/item/device/mmi/radio_enabled))
			var/obj/item/device/mmi/radio_enabled/R = container
			if(R.radio)
				spawn(0) R.radio.hear_talk(src, sanitize(message), verb, speaking)
		..(trim(message), speaking, verb)
