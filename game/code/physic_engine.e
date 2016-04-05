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
		do

			create blocks.make (0)
			create room.make
		end

feature -- Access
	blocks: ARRAYED_LIST[BLOCK]

	room: ROOM
end
