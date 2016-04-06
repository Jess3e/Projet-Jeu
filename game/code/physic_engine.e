note
	description: "An engine that manages physics in the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	PHYSIC_ENGINE

create
	make

feature {NONE} -- Initialization
	make
			-- Initialization of `Current'
		do
			create {ARRAYED_LIST [BLOCK]} blocks.make (0)
			create room.make
		end

feature -- Access
	blocks: LIST[BLOCK]
			-- The list of blocks to check for collisions

	room: ROOM
			-- The room that the player is currently in
end
