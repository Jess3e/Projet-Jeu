note
	description: "A factory that is used generate ressources for the game."
	author: "Jessee Lefebvre, inspired by Louis Marchand (https://github.com/tioui/Tic-Tac-Toes)"
	date: "2016-04-04"
	revision: "1.0"

class
	RESSOURCES_FACTORY

create make

feature {NONE} -- Constants
	Images_directory:READABLE_STRING_GENERAL
		once
			Result := "ressources/images"
		end

	Audio_directory:READABLE_STRING_GENERAL
		once
			Result := "ressources/audio"
		end

	Fonts_directory:READABLE_STRING_GENERAL
		once
			Result := "ressources/fonts"
		end

	Image_file_extension:READABLE_STRING_GENERAL
		once
			Result := "png"
		end

	Font_file_extension:READABLE_STRING_GENERAL
		once
			Result := "ttf"
		end

	Audio_file_extension:READABLE_STRING_GENERAL
		once
			Result := "ogg"
		end

feature {NONE} -- Initialization
	make(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
		do
			has_error := False
			make_images(a_renderer, a_format)
		end

	make_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every *_image using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			if attached load_image(a_renderer, "start_button_small") as la_image then
				start_button_texture := la_image
			else
				create start_button_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "config_button_small") as la_image then
				config_button_texture := la_image
			else
				create config_button_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "highscore_button_small") as la_image then
				ranking_button_texture := la_image
			else
				create ranking_button_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "exit_button_small") as la_image then
				exit_button_texture := la_image
			else
				create exit_button_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "player") as la_image then
				player_texture := la_image
			else
				create player_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "wall") as la_image then
				wall_texture := la_image
			else
				create wall_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "background") as la_image then
				background_texture := la_image
			else
				create background_texture.make_not_lockable (a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

feature -- Access
	start_button_texture:GAME_TEXTURE

--	start_button_texture_hovered:GAME_TEXTURE

--	start_button_texture_clicked:GAME_TEXTURE

	config_button_texture:GAME_TEXTURE

--	config_button_texture_hovered:GAME_TEXTURE

--	config_button_texture_clicked:GAME_TEXTURE

	ranking_button_texture:GAME_TEXTURE

--	ranking_button_texture_hovered:GAME_TEXTURE

--	ranking_button_texture_clicked:GAME_TEXTURE

	exit_button_texture:GAME_TEXTURE

--	exit_button_texture_hovered:GAME_TEXTURE

--	exit_button_texture_clicked:GAME_TEXTURE

	player_texture:GAME_TEXTURE

	wall_texture:GAME_TEXTURE

	background_texture:GAME_TEXTURE

	button_sound:AUDIO_SOUND_FILE
		local
			l_path:PATH
		do
			create l_path.make_from_string (Audio_directory)
			l_path := l_path.extended ("sound")
			l_path := l_path.appended_with_extension (Audio_file_extension)
			create Result.make (l_path.name)
			if Result.is_openable then
				Result.open
			end
		end

	menu_music:AUDIO_SOUND_FILE
		local
			l_path:PATH
		do
			create l_path.make_from_string (Audio_directory)
			l_path := l_path.extended ("music")
			l_path := l_path.appended_with_extension (Audio_file_extension)
			create Result.make (l_path.name)
			if Result.is_openable then
				Result.open
			end
		end

	has_error:BOOLEAN

feature {NONE} -- Implementation
	load_image(a_renderer:GAME_RENDERER; a_name:READABLE_STRING_GENERAL):detachable GAME_TEXTURE
		local
			l_image:IMG_IMAGE_FILE
			l_path:PATH
		do
			Result := Void
			create l_path.make_from_string (Images_directory)
			l_path := l_path.extended (a_name)
			l_path := l_path.appended_with_extension (Image_file_extension)
			create l_image.make (l_path.name)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create Result.make_from_image (a_renderer, l_image)
					if Result.has_error then
						Result := Void
					end
				end
			end
		ensure
			Image_Exist: attached Result
		end

end
