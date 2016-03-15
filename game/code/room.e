note
	description: "Summary description for {ROOM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOM

create
	make

feature {NONE}
	make
		do
			id := 1
			active := false

		end
feature
	active: BOOLEAN
	id: INTEGER
end
