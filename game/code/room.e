note
	description: "A room in the game that has a goal."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	ROOM

create
	make

feature {NONE} -- Initialization                           SIZE : 31 x 16
	make (a_id:INTEGER; a_block_list:LIST[BLOCK]; a_background:BACKGROUND)
			-- Initialization of `Current'
		do
			id := a_id
			active := false
			background := a_background
			block_list := a_block_list
		end

feature -- Access
	active: BOOLEAN
		-- If room is the one currently played by the player

	set_id(a_id:INTEGER)
			-- Set the `id' of `Current' to `a_id'
		require
			valid_id: a_id > 0
		do
			id := a_id
		ensure
			id_set: a_id = id
		end

feature {NONE} -- Implementation
	id: INTEGER
		-- The unique id of `Current'

	block_list: LIST[BLOCK]
		-- The list of blocks `Current'

	background: BACKGROUND
		-- The background of `Current'
end
