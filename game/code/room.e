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
			create music.make
			create background.make
			create sprites.make
			create sounds.make (0)
		end
feature
	active: BOOLEAN
	room_id: INTEGER
	music: MUSIC
	background: BACKGROUND
	sprites: LINKED_LIST[SPRITE]
	sounds: ARRAYED_LIST[SOUND]
end
