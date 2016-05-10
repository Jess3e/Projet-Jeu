note
	description: "A {BLOCK} that the player needs to reach in order to beat a room."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	GOAL

inherit
	BLOCK

create
	make

feature {NONE} -- Initialization
	make(a_x, a_y:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization for `Current' using `a_texture' to make an image at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
		do
			make_drawable(a_x, a_y, a_texture)
		end
end
