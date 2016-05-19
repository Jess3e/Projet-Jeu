note
	description: "Summary description for {ANIMATED_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANIMATED_BLOCK

inherit
	BLOCK
		redefine
			draw,
			redraw
		end

feature {NONE} -- Initialization
	make(a_x, a_y, a_lenght, a_current_index, a_frame_delay:INTEGER_32; a_texture:GAME_TEXTURE)
		do
			make_drawable(a_x, a_y, a_texture)
			frame_delay := a_frame_delay
			current_index := a_current_index
			lenght := a_lenght
			check_reset := false
			reset := false
		end

	make_with_reset_check(a_x, a_y, a_lenght, a_current_index, a_frame_delay:INTEGER_32; a_texture:GAME_TEXTURE)
		do
			make(a_x, a_y, a_lenght, a_current_index, a_frame_delay, a_texture)
			check_reset := true
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

	redraw(a_renderer:GAME_RENDERER)
			-- Redraw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			increment_index
			draw(a_renderer)
		end

	lenght:INTEGER_32

	current_index:INTEGER_32

	frame_delay:INTEGER_32

	change_index(a_new_index:INTEGER_32)
		require
			valid_new_index : a_new_index >= 0 and a_new_index < lenght
		do
			current_index := a_new_index
		end

	increment_index
		do
			if frame_counter >= frame_delay then
				if current_index = lenght - 1 then
					change_index(0)
					reset := true
				else
					change_index(current_index + 1)
				end
				frame_counter := 0
			else
				frame_counter := frame_counter + 1
			end
		end

	check_reset:BOOLEAN


feature {NONE} -- Implementation
	reset:BOOLEAN

	frame_counter:INTEGER_32
end
