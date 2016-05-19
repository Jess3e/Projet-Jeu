note
	description: "A {BLOCK} that the player needs to reach in order to beat a room."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	GOAL

inherit
	ANIMATED_BLOCK
		rename
			make as make_animated
		end

create
	make

feature {NONE} -- Initialization
	make(a_x, a_y, a_animation_lenght, a_animation_index, a_frame_delay:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization for `Current' using `a_texture' to make an image at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
		do
			make_animated(a_x, a_y, a_animation_lenght, a_animation_index, a_frame_delay, a_texture)
		end
end
