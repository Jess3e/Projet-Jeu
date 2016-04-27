note
	description: "The main playable character of the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	PLAYER

inherit
	DRAWABLE
		rename
			make as make_drawable
		end

create
	make

feature {NONE} -- Initialization
	make
			-- Initialization of `Current'
		do

		end
end
