note
	description: "A class that can be drawn on screen."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"


deferred class
	DRAWABLE

feature {NONE} -- Initialization
	make(a_x, a_y:INTEGER_32; a_texture:GAME_TEXTURE)
		do
			x := a_x
			y := a_y
			texture := a_texture
			if attached texture as l_texture then
				width := l_texture.width
				height := l_texture.height
			end
		end

	make_resizable(a_x, a_y , a_width, a_height:INTEGER_32; a_texture:GAME_TEXTURE)
		do
			make(a_x, a_y, a_texture)
			width := a_width
			height := a_height
		end

feature -- Access
	draw(a_renderer:GAME_RENDERER)
		do
			if attached texture as l_texture then
				a_renderer.draw_sub_texture_with_scale (
										l_texture, 0, 0, l_texture.width, l_texture.height,
										x, y, width, height
									)
			end
		end

	set_texture(a_new_texture:GAME_TEXTURE)
		do
			texture := a_new_texture
		end

	x:INTEGER_32

	y:INTEGER_32

	width:INTEGER_32

	height:INTEGER_32

feature {NONE} -- Implementation
	texture:detachable GAME_TEXTURE

end
