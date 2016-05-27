note
	description: "This class stores everything that is in every blocks."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

deferred class
	BLOCK

inherit
	DRAWABLE
		rename
			make as make_drawable,
			make_resizable as make_resizable_drawable
		end

feature -- Access

	contact_action(a_player:PLAYER; a_direction:INTEGER_32):INTEGER_32
			-- The action to do when the `a_player' is contacting `Current' from `a_direction'.
			-- Returns a new direction for the player
		deferred
		ensure
			valid_direction : a_direction >= 0 and a_direction <= 4
		end

	reset
			-- The action to do when the room is reset.
		deferred
		end

end
