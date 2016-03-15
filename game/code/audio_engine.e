note
	description: "Summary description for {AUDIO_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUDIO_ENGINE

create
	make

feature {NONE}
	make
		do
			create {ARRAYED_LIST [SOUND]} sound_list.make (0)
		end

feature
	play_sounds
		do
			across sound_list as sound loop
				--sound.item.play
			end
		end

	add_sound(sound:SOUND)
		do
			sound_list.extend (sound)
		end

feature {NONE}

	sound_list: LIST [SOUND]

end
