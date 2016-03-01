note
	description: "Summary description for {DRAWABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"


deferred class
	DRAWABLE

feature
	make(a_renderer:GAME_RENDERER; a_ressources_factory:RESSOURCES_FACTORY; a_x, a_y, a_type:INTEGER_32)
		do
			renderer := a_renderer
			ressources_factory := a_ressources_factory
			x := a_x
			y := a_y
			type := a_type
			create_image
			if attached image as l_image then
				width := l_image.width
				height := l_image.height
			end
		end

	make_resizable(a_renderer:GAME_RENDERER; a_ressources_factory:RESSOURCES_FACTORY; a_x, a_y , a_width, a_height, a_type:INTEGER_32)
		do
			renderer := a_renderer
			ressources_factory := a_ressources_factory
			x := a_x
			y := a_y
			width := a_width
			height := a_height
			type := a_type
			create_image
		end

	draw
		do
			if attached image as l_image then
				renderer.draw_sub_texture_with_scale (
										l_image, 0, 0, l_image.width, l_image.height,
										x, y, width, height
									)
			end
		end

	create_image
		do
			image := void
		end

feature
	x:INTEGER_32

	y:INTEGER_32

	width:INTEGER_32

	height:INTEGER_32

	type:INTEGER_32

feature {NONE}
	image:detachable GAME_TEXTURE

	ressources_factory:RESSOURCES_FACTORY

	renderer:GAME_RENDERER

end
