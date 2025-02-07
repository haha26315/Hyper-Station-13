/mob/dead/observer/say(message, bubble_type, var/list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if (!message)
		return

	var/message_mode = get_message_mode(message)
	if(client && (message_mode == MODE_ADMIN || message_mode == MODE_DEADMIN))
		message = copytext_char(message, 3)
		message = trim_left(message)

		if(message_mode == MODE_ADMIN)
			client.cmd_admin_say(message)
		else if(message_mode == MODE_DEADMIN)
			client.dsay(message)
		return

	src.log_talk(message, LOG_SAY, tag="ghost")

	if(check_emote(message))
		return

	. = say_dead(message)

/mob/dead/observer/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args) //parent calls can't overwrite the current proc args.
	var/atom/movable/to_follow = speaker
	if(radio_freq)
		var/atom/movable/virtualspeaker/V = speaker

		if(isAI(V.source))
			var/mob/living/silicon/ai/S = V.source
			to_follow = S.eyeobj
		else
			to_follow = V.source
	var/link = FOLLOW_LINK(src, to_follow)
	// Recompose the message, because it's scrambled by default
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mode, FALSE, source)
	to_chat(src, "[link] [message]")

