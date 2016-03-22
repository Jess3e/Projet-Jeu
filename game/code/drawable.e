note
	description: "Summary description for {DRAWABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"


deferred class
	DRAWABLE

feature {NONE}
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
			x := a_x
			y := a_y
			width := a_width
			height := a_height
			texture := a_texture
		end

feature
	draw(a_renderer:GAME_RENDERER)
		do
			if attached texture as l_texture then
				a_renderer.draw_sub_texture_with_scale (
										l_texture, 0, 0, l_texture.width, l_texture.height,
										x, y, width, height
									)
			end
		end

feature
	x:INTEGER_32

	y:INTEGER_32

	width:INTEGER_32

	height:INTEGER_32

feature {NONE}
	texture:detachable GAME_TEXTURE

end
