note
	description: "A button with an item that can have a sound and an action when clicked."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

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

feature {NONE} -- Initialization
	make(a_x, a_y:INTEGER_32; a_textures:TUPLE [texture, hovered_texture, clicked_texture:GAME_TEXTURE]; a_audio_file:AUDIO_SOUND_FILE)
			-- Initialization of `Current' using `a_textures' to make an image at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
		do
			make_drawable(a_x, a_y, a_textures.texture)
			make_basic(a_textures, a_audio_file)
		end

	make_resizable(a_x, a_y , a_width, a_height:INTEGER_32; a_textures:TUPLE [texture, hovered_texture, clicked_texture:GAME_TEXTURE]; a_audio_file:AUDIO_SOUND_FILE)
			-- Initialization of `Current' using `a_textures' to make an image with the dimensions of (`a_width'x`a_height')
			-- and at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			make_resizable_drawable(a_x, a_y , a_width, a_height, a_textures.texture)
			make_basic(a_textures, a_audio_file)
		end

	make_basic(a_textures:TUPLE [texture, hovered_texture, clicked_texture:GAME_TEXTURE]; a_audio_file:AUDIO_SOUND_FILE)
			-- Initialization of everything common in `make' and in `make_resizable'
		require
			valid_normal_texture: not a_textures.texture.has_error
			valid_hovered_texture: not a_textures.hovered_texture.has_error
			valid_clicked_texture: not a_textures.clicked_texture.has_error
			valid_audio_file: not a_audio_file.has_error
		do
			normal_texture := a_textures.texture
			hovered_texture := a_textures.hovered_texture
			clicked_texture := a_textures.clicked_texture
			audio_file := a_audio_file
			make_sound
			create agent_click_button
		ensure
			normal_texture_set: a_textures.texture = normal_texture
			hovered_texture_set: a_textures.hovered_texture = hovered_texture
			clicked_texture_set: a_textures.clicked_texture = clicked_texture
			audio_file_set: a_audio_file = audio_file
		end

feature -- Access
	agent_click_button:ACTION_SEQUENCE [TUPLE]
			-- The action executed when clicking `Current'

	hovered:BOOLEAN

	on_click
		do
			agent_click_button.call
			if attached clicked_texture as la_clicked_texture then
				texture := la_clicked_texture
			end
		end

	on_mouse_in
		do
			if attached hovered_texture as la_hovered_texture then
				texture := la_hovered_texture
			end
		end

	on_mouse_out
		do
			if attached normal_texture as la_normal_texture then
				texture := la_normal_texture
			end
		end

feature {NONE} -- Implementation
	normal_texture:detachable GAME_TEXTURE
			-- The normal texture of `Current'

	hovered_texture:detachable GAME_TEXTURE
			-- The texture shown when hovering `Current'

	clicked_texture:detachable GAME_TEXTURE
			-- The texture shown when clicking `Current'
end
