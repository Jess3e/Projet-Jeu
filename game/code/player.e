note
	description: "The main playable character of the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	PLAYER

inherit
	DRAWABLE


	SOUND

create
	make

feature {NONE} -- Initialization
	--make
	--	do
	--		create agent_play_sound
	--		audio_library.sources_add
	--		source := audio_library.last_source_added
	--		file := ressources_factory.button_sound
	--	end

feature -- Access
	on_jump
		do
			--physics pour on_jump
			--sound_source.queue_sound (---)
			agent_play_sound.call(source)
		end
end
