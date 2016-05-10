note
	description: "Summary description for {ANIMATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANIMATION

inherit
	DRAWABLE
		rename
			make as make_drawable,
			draw as draw_drawable
		end

feature {NONE} -- Initialization
	make(a_lenght, a_current_index:INTEGER_32)
		do
			reset := true
		end

	make_with_reset_check(a_lenght, a_current_index:INTEGER_32)
		do
			make(a_lenght, a_current_index)
			reset := false
		end

feature -- Access
	draw(a_renderer:GAME_RENDERER)
			-- Draw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			if visible then
				if attached texture as la_texture then
					a_renderer.draw_sub_texture_with_scale(la_texture, la_texture.width // lenght * current_index, 0,
						la_texture.width // lenght, la_texture.height, x, y, la_texture.width // lenght, la_texture.height)
				end
			end
		end

	lenght:INTEGER_32

	current_index:INTEGER_32

	change_index(a_new_index:INTEGER_32)
		require
			valid_new_index : a_new_index >= 0 and a_new_index < lenght
		do
			current_index := a_new_index
		end

	increment_index
		do
			if current_index = lenght - 1 then
				change_index(0)
				reset := true
			else
				change_index(current_index + 1)
			end
		end

	check_reset:BOOLEAN


feature {NONE} -- Implementation
	reset:BOOLEAN

end
