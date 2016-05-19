note
	description: "A class that can be drawn on screen."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"


deferred class
	DRAWABLE

feature {NONE} -- Initialization
	make(a_x, a_y:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization of `Current' with the texture `a_texture' at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
			valid_texture: not a_texture.has_error
		do
			x := a_x
			y := a_y
			texture := a_texture
			width := a_texture.width
			height := a_texture.height
			visible := true
		ensure
			x_set: a_x = x
			y_set: a_y = y
			texture_set: a_texture = texture
		end

	make_resizable(a_x, a_y , a_width, a_height:INTEGER_32; a_texture:GAME_TEXTURE)
			-- Initialization of `Current' with the texture `a_texture' with the dimension (`a_width'x`a_height')
			-- at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			make(a_x, a_y, a_texture)
			width := a_width
			height := a_height
		ensure
			x_set: a_x = x
			y_set: a_y = y
			width_set: a_width = width
			height_set: a_height = height
			texture_set: a_texture = texture
		end

feature -- Access
	draw(a_renderer:GAME_RENDERER)
			-- Draw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			if visible then
				if attached texture as la_texture then
					a_renderer.draw_sub_texture_with_scale (
										la_texture, 0, 0, la_texture.width, la_texture.height,
										x, y, width, height)
				end
			end
		end

	redraw(a_renderer:GAME_RENDERER)
			-- Redraw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		do
			draw(a_renderer)
		end

	set_texture(a_new_texture:GAME_TEXTURE)
			-- Sets the `texture' of `Current' as `a_new_texture'
		require
			valid_texture: not a_new_texture.has_error
		do
			texture := a_new_texture
		ensure
			texture_set: a_new_texture = texture
		end

	x:INTEGER_32
			-- The x position of `Current'

	y:INTEGER_32
			-- The y position of `Current'

	width:INTEGER_32
			-- The width of `Current'

	height:INTEGER_32
			-- The height of `Current'

	visible:BOOLEAN
			-- The visibility of `Current'

feature {NONE} -- Implementation
	texture:GAME_TEXTURE
		-- The texture representing `Current'

invariant
	invalid_x: x >= 0
	invalid_y: y >= 0
	invalid_width: width > 0
	invalid_height: height > 0
end
