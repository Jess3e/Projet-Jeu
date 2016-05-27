note
	description: "A {BLOCK} that the player can only get through with a key."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	LOCKED_BLOCK

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
		local
			l_direction:INTEGER_32
		do
			l_direction := a_direction
			if is_visible then
				if a_player.key_count > 0 then
					a_player.set_key_count (a_player.key_count - 1)
					is_visible := false
					l_direction := 0
				else
					l_direction := 0
				end
			end
			Result := l_direction
		end

	reset
			-- The action to do when the room is reset.
		do
			is_visible := true
		end
end
