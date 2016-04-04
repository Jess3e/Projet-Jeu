note
	description: "Summary description for {BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON

inherit
	DRAWABLE
		rename
			make as make_drawable,
			make_resizable as make_resizable_drawable
		end

	SOUND
		rename
			make as make_sound
		end

create
	make, make_resizable

feature {NONE}
	make(a_x, a_y:INTEGER_32; a_textures:TUPLE [texture, hovered_texture, clicked_texture:GAME_TEXTURE]; a_audio_file:AUDIO_SOUND_FILE)
		do
			make_drawable(a_x, a_y, a_textures.texture)
			make_basic(a_textures.hovered_texture, a_textures.clicked_texture, a_audio_file)
		end

	make_resizable(a_x, a_y , a_width, a_height:INTEGER_32; a_textures:TUPLE [texture, hovered_texture, clicked_texture:GAME_TEXTURE]; a_audio_file:AUDIO_SOUND_FILE)
		do
			make_resizable_drawable(a_x, a_y , a_width, a_height, a_textures.texture)
			make_basic
		end

	make_basic(a_hovered_texture, a_clicked_texture:GAME_TEXTURE; a_audio_file:AUDIO_SOUND_FILE)
		do
			hovered_texture := a_hovered_texture
			clicked_texture := a_clicked_texture
			audio_file := a_audio_file
			make_sound
			create agent_click_button
		end

feature

	agent_click_button:ACTION_SEQUENCE [detachable TUPLE [timestamp: NATURAL_32]]

feature {NONE}
	hovered_texture:GAME_TEXTURE

	clicked_texture:GAME_TEXTURE

end
