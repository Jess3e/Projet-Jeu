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
	sound:AUDIO_SOUND_FILE

feature
	handle_sound
		do
			create agent_play_sound
			audio_library.sources_add
			sound_source := audio_library.last_source_added
		end

	agent_play_sound:ACTION_SEQUENCE[TUPLE[source:AUDIO_SOURCE]]

end
