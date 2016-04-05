note
	description: "An engine that manages sounds in the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	AUDIO_ENGINE

create
	make

feature {NONE} -- Initialization
	make
		do
			create {ARRAYED_LIST [SOUND]} sound_list.make (0)
		end

feature -- Access
	play_sounds
		do
			across sound_list as sound loop

			end
		end

	add_sound(sound:SOUND)
		do
			sound_list.extend (sound)
		end

feature {NONE} -- Implementation

	sound_list: LIST [SOUND]

end
