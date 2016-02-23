note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit
	SPRITE
	SOUND

create
	make

feature {NONE}
	make
		do
			create agent_play_sound
			audio_library.sources_add
			sound_source := audio_library.last_source_added
		end

feature -- access

	on_jump
		do
			--physics pour on_jump
			--sound_source.queue_sound (---)
			agent_play_sound.call(sound_source)
		end

end
