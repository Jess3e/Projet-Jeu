note
	description: "A {BLOCK} that breaks when the player contacts it."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	WEAK_WALL

inherit
	ANIMATED_BLOCK
		rename
			make as make_animated
		redefine
			animation_end
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
			is_animating := false
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
				l_direction := 0
				is_animating := true
			end
			Result := l_direction
		end

	reset
			-- The action to do when the room is reset.
		do
			is_visible := true
			is_animating := false
			set_index (0)
		end

feature {NONE} -- Implementation

	animation_end
			-- Action to do when the animation of the block ends
		do
			reset
			is_visible := false
		end
end
