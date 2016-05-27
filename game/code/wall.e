note
	description: "A regular {BLOCK}."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	WALL

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

feature -- Access
	contact_action(a_player:PLAYER; a_direction:INTEGER_32):INTEGER_32
			-- The action to do when the `a_player' is contacting `Current' from `a_direction'.
			-- Returns a new direction for the player
		do
			Result := 0
		end

	reset
			-- The action to do when the room is reset.
		do
		end
end
