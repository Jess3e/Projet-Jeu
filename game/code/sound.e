note
	description: "Any sound that can be played."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

deferred class
	SOUND

inherit
	AUDIO_LIBRARY_SHARED

feature {NONE} -- Initialization
	make
			-- Initialization of `Current'
		do
			create agent_play_sound
			audio_library.sources_add
			audio_source := audio_library.last_source_added
		end

feature -- Access
	agent_play_sound:ACTION_SEQUENCE[TUPLE[source:AUDIO_SOURCE]]

	audio_source:AUDIO_SOURCE

	audio_file:AUDIO_SOUND_FILE
end
