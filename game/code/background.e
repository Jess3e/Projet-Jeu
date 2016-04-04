note
	description: "Summary description for {BACKGROUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BACKGROUND

inherit
	DRAWABLE
		rename
			make as make_drawable
		end

create
	make

feature {NONE}
	make(a_window_width, a_window_height:INTEGER_32; a_texture:GAME_TEXTURE)
		do
			make_resizable(0, 0 , a_window_width, a_window_height, a_texture)
		end
end
