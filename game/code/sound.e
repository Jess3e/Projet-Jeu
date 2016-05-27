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
			audio_library.sources_add
			audio_source := audio_library.last_source_added
		end

feature -- Access

	audio_source:AUDIO_SOURCE
			-- The source that plays the music

	audio_file:AUDIO_SOUND_FILE
			-- The file of the sound to play
end
