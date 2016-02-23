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
			room_id := 1
			active := false
			create background.make
		end
feature
	active: BOOLEAN
	room_id: INTEGER
	background: BACKGROUND
end
