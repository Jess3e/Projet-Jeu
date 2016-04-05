note
	description: "A room in the game that has a goal."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	ROOM

create
	make

feature {NONE} -- Initialization
	make
		do
			id := 1
			active := false

		end
		
feature -- Access
	active: BOOLEAN

	id: INTEGER

end
