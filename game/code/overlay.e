note
	description: "Summary description for {OVERLAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OVERLAY

inherit
	DRAWABLE
		rename
			make as make_drawable
		end

create
	make

feature {NONE} -- Initialization
	make(a_x, a_y, a_width, a_height:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization of `Current' with the texture `a_texture' with dimension (`a_window_width'x`a_window_heigh')
		do
			make_resizable(a_x, a_y , a_width, a_height, a_texture)
		end
end
