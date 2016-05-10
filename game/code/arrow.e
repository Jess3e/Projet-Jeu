note
	description: "A {BLOCK} that changes the direction that the player is moving."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	ARROW

inherit
	BLOCK

create
	make

feature {NONE} -- Initialization
	make(a_x, a_y, a_direction:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization for `Current' using `a_texture' to make an image at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
			valid_direction: a_direction >= 0 and a_direction <= 3
		do
			make_drawable(a_x, a_y, a_texture)
		end
end
