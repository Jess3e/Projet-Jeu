note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit
	DRAWABLE


	SOUND

create
	make

feature {NONE}
	--make
	--	do
	--		create agent_play_sound
	--		audio_library.sources_add
	--		source := audio_library.last_source_added
	--		file := ressources_factory.button_sound
	--	end

feature -- access

	on_jump
		do
			--physics pour on_jump
			--sound_source.queue_sound (---)
			agent_play_sound.call(source)
		end
end
