note
	description: "A room in the game that has a goal."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	ROOM

create
	make

feature {NONE} -- Initialization                           SIZE : 30 x 16
	make (a_block_list:LIST[BLOCK]; a_background:BACKGROUND)
			-- Initialization of `Current'
		do
			active := false
			background := a_background
			block_list := a_block_list
		end

feature -- Access
	active: BOOLEAN
		-- If room is the one currently played by the player

	background: BACKGROUND
			-- The background of `Current'

	block_list: LIST[BLOCK]
			-- The list of blocks `Current'

feature {NONE} -- Implementation

end
