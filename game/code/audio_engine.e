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
			-- Initialization of `Current'
		do
			create {LINKED_LIST [SOUND]} sound_list.make
		end

feature -- Access
	play_sounds
			-- Play all the sounds in the sound_list
		do
			across sound_list as sound loop
				-- play
			end
		end

	sound_list: LIST [SOUND]
			-- List of all the sounds to play
end
