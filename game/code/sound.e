note
	description: "Summary description for {SOUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SOUND

inherit
	AUDIO_LIBRARY_SHARED

feature {NONE}
	sound_source:AUDIO_SOURCE

feature
	agent_play_sound:ACTION_SEQUENCE[TUPLE[source:AUDIO_SOURCE]]
	
end
