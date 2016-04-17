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
			create {ARRAYED_LIST[BLOCK]} blocks.make (1)
			create {ARRAYED_LIST[ROOM]} room_list.make (1)
		end

feature -- Access
	blocks: LIST[BLOCK]
			-- The list of blocks to check for collisions

	current_room:detachable ROOM
			-- The room that the player is currently in

	room_list: LIST[ROOM]
			-- The list of every rooms in the game

feature {NONE} -- Implementation
	update_current_room
			-- Updates the `current_room' to the last active room in the `room_list'
		do
			across room_list as room loop
				if room.item.active then
					current_room := room.item
				end
			end
		end

end
