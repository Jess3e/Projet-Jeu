note
	description: "Summary description for {PHYSIC_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHYSIC_ENGINE

create
	make

feature {NONE}
	make
		do

			create blocks.make (0)
			create room.make
		end

feature

	blocks: ARRAYED_LIST[BLOCK]
	room: ROOM
end
