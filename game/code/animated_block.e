note
	description: "A {BLOCK} that has an animation"
	author: "Jessee Lefebvre"
	date: "2016-05-26"
	revision: "1.0"

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
			-- Initialization of `Current' with the animation lenght `a_lenght', at the index `a_current_index' and with a delay of `a_frame_delay' ticks
		do
			make_drawable(a_x, a_y, a_texture)
			frame_delay := a_frame_delay
			current_index := a_current_index
			lenght := a_lenght
			is_animating := true
			sub_image_width := a_texture.width // lenght
			sub_image_height := a_texture.height
		end

feature -- Access
	draw(a_renderer:GAME_RENDERER)
			-- Draw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			if is_visible then
				if attached texture as la_texture then
					a_renderer.draw_sub_texture_with_scale(la_texture, sub_image_width * current_index, 0,
						sub_image_width, sub_image_height, x, y, sub_image_width, sub_image_height)
				end
			end
		end

	redraw(a_renderer:GAME_RENDERER)
			-- Redraw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			if is_animating then
				increment_index
			end
			draw(a_renderer)
		end


	set_index(a_new_index:INTEGER_32)
			-- Sets the value of `current_index' of the animation to the value of `a_new_index'
		require
			valid_new_index : a_new_index >= 0 and a_new_index < lenght
		do
			current_index := a_new_index
		end

	increment_index
			-- Increments the index of the animation to show the next image
		do
			if frame_counter >= frame_delay and is_animating then
				if current_index = lenght - 1 then
					set_index(0)
					animation_end
				else
					set_index(current_index + 1)
				end
				frame_counter := 0
			else
				frame_counter := frame_counter + 1
			end
		end

	is_animating:BOOLEAN
			-- Tells if the animation is running or not

	lenght:INTEGER_32
			-- The lenght of the animation

	current_index:INTEGER_32
			-- The index of the animation currently used

	frame_delay:INTEGER_32
			-- The delay to way in ticks for the animation to change

	sub_image_width:INTEGER_32
			-- The height of the image shown on screen

	sub_image_height:INTEGER_32
			-- The height of the image shown on screen

feature {NONE} -- Implementation

	animation_end
			-- Action to do when the animation of the block ends
		do
		end

	frame_counter:INTEGER_32
			-- A counter that increments every tick and resets when the animation changes

end
