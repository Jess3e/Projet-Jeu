note
	description: "A factory that is used generate ressources for the game."
	author: "Jessee Lefebvre, inspired by Louis Marchand (https://github.com/tioui/Tic-Tac-Toes)"
	date: "2016-04-04"
	revision: "1.0"

class
	RESSOURCES_FACTORY

create
	make

feature {NONE} -- Constants
	Images_directory:READABLE_STRING_GENERAL
			-- The directory (or sub-directory) containing the image files
		once
			Result := "ressources/images"
		end

	Audio_directory:READABLE_STRING_GENERAL
			-- The directory (or sub-directory) containing the audio files
		once
			Result := "ressources/audio"
		end

	Fonts_directory:READABLE_STRING_GENERAL
			-- The directory (or sub-directory) containing the font files
		once
			Result := "ressources/fonts"
		end

	Image_file_extension:READABLE_STRING_GENERAL
			-- The complete extension of the image files
		once
			Result := "png"
		end

	Font_file_extension:READABLE_STRING_GENERAL
			-- The complete extension of the font files
		once
			Result := "ttf"
		end

	Audio_file_extension:READABLE_STRING_GENERAL
			-- The complete extension of the audio files
		once
			Result := "ogg"
		end

feature {NONE} -- Initialization
	make(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of `Current' using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			has_error := False
			make_images(a_renderer, a_format)
		end

	make_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every texture using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			make_block_images(a_renderer, a_format)
			make_button_images(a_renderer, a_format)
			if attached load_image(a_renderer, "background") as la_image then
				background_texture := la_image
			else
				create background_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "menu_room_overlay") as la_image then
				menu_room_overlay_texture := la_image
			else
				create menu_room_overlay_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "room_overlay") as la_image then
				room_overlay_texture := la_image
			else
				create room_overlay_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

	make_block_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every block texture using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			if attached load_image(a_renderer, "player") as la_image then
				player_texture := la_image
			else
				create player_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "wall") as la_image then
				wall_texture := la_image
			else
				create wall_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "weak_wall") as la_image then
				weak_wall_texture := la_image
			else
				create weak_wall_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "spike") as la_image then
				spike_texture := la_image
			else
				create spike_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "key") as la_image then
				key_texture := la_image
			else
				create key_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "locked_block") as la_image then
				locked_block_texture := la_image
			else
				create locked_block_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

	make_button_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every button texture using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			make_hovered_button_images(a_renderer, a_format)
			make_clicked_button_images(a_renderer, a_format)
			if attached load_image(a_renderer, "start_button_small") as la_image then
				start_button_texture := la_image
			else
				create start_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "return_button") as la_image then
				return_button_texture := la_image
			else
				create return_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "room_button") as la_image then
				menu_room_button_texture := la_image
			else
				create menu_room_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "config_button_small") as la_image then
				config_button_texture := la_image
			else
				create config_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "highscore_button_small") as la_image then
				ranking_button_texture := la_image
			else
				create ranking_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "exit_button_small") as la_image then
				exit_button_texture := la_image
			else
				create exit_button_texture.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

	make_hovered_button_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every button texture hovered using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			if attached load_image(a_renderer, "room_button_hover") as la_image then
				menu_room_button_texture_hovered := la_image
			else
				create menu_room_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "return_button_hovered") as la_image then
				return_button_texture_hovered := la_image
			else
				create return_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "start_button_small_hovered") as la_image then
				start_button_texture_hovered := la_image
			else
				create start_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "config_button_small_hovered") as la_image then
				config_button_texture_hovered := la_image
			else
				create config_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "highscore_button_small_hovered") as la_image then
				ranking_button_texture_hovered := la_image
			else
				create ranking_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "exit_button_small_hovered") as la_image then
				exit_button_texture_hovered := la_image
			else
				create exit_button_texture_hovered.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

	make_clicked_button_images(a_renderer:GAME_RENDERER; a_format:GAME_PIXEL_FORMAT_READABLE)
			-- Initialization of every button texture clicked using `a_renderer' and `a_format'
			-- to create default {GAME_TEXTURE}
		do
			if attached load_image(a_renderer, "start_button_small_clicked") as la_image then
				start_button_texture_clicked := la_image
			else
				create start_button_texture_clicked.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "config_button_small_clicked") as la_image then
				config_button_texture_clicked := la_image
			else
				create config_button_texture_clicked.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "highscore_button_small_clicked") as la_image then
				ranking_button_texture_clicked := la_image
			else
				create ranking_button_texture_clicked.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
			if attached load_image(a_renderer, "exit_button_small_clicked") as la_image then
				exit_button_texture_clicked := la_image
			else
				create exit_button_texture_clicked.make_not_lockable(a_renderer, a_format, 1, 1)
				has_error := True
			end
		end

feature -- Access
	return_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal return button.

	return_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered return button.

	menu_room_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal room button.

	menu_room_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered room button.

	start_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal start button.

	start_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered start button.

	start_button_texture_clicked:GAME_TEXTURE
			-- The image texture that represents the clicked start button

	config_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal config button

	config_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered config button

	config_button_texture_clicked:GAME_TEXTURE
			-- The image texture that represents the clicked config button

	ranking_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal ranking button

	ranking_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered ranking button

	ranking_button_texture_clicked:GAME_TEXTURE
			-- The image texture that represents the clicked ranking button

	exit_button_texture:GAME_TEXTURE
			-- The image texture that represents the normal exit button

	exit_button_texture_hovered:GAME_TEXTURE
			-- The image texture that represents the hovered exit button

	exit_button_texture_clicked:GAME_TEXTURE
			-- The image texture that represents the clicked exit button

	player_texture:GAME_TEXTURE
			-- The image texture that represents the player

	wall_texture:GAME_TEXTURE
			-- The image texture that represents a wall

	weak_wall_texture:GAME_TEXTURE
			-- The image texture that represents a weak wall

	spike_texture:GAME_TEXTURE
			-- The image texture that represents a spike

	key_texture:GAME_TEXTURE
			-- The image texture that represents a key

	locked_block_texture:GAME_TEXTURE
			-- The image texture that represents a lockey block

	background_texture:GAME_TEXTURE
			-- The image texture that represents the background

	menu_room_overlay_texture:GAME_TEXTURE
			-- The image texture that represents the menu room overlay

	room_overlay_texture:GAME_TEXTURE
			-- The image texture that represents the room overlay

	button_sound:AUDIO_SOUND_FILE
			-- The audio sound file of a button click
		local
			l_path:PATH
		do
			create l_path.make_from_string(Audio_directory)
			l_path := l_path.extended("sound")
			l_path := l_path.appended_with_extension(Audio_file_extension)
			create Result.make(l_path.name)
			if Result.is_openable then
				Result.open
			end
		end

	menu_music:AUDIO_SOUND_FILE
			-- The audio sound file of the menu music
		local
			l_path:PATH
		do
			create l_path.make_from_string(Audio_directory)
			l_path := l_path.extended("music")
			l_path := l_path.appended_with_extension(Audio_file_extension)
			create Result.make(l_path.name)
			if Result.is_openable then
				Result.open
			end
		end

	has_error:BOOLEAN

feature {NONE} -- Implementation
	load_image(a_renderer:GAME_RENDERER; a_name:READABLE_STRING_GENERAL):detachable GAME_TEXTURE
			-- Create a {GAME_TEXTURE} from an image file identified by `a_name'
		local
			l_image:IMG_IMAGE_FILE
			l_path:PATH
		do
			Result := Void
			create l_path.make_from_string(Images_directory)
			l_path := l_path.extended(a_name)
			l_path := l_path.appended_with_extension(Image_file_extension)
			create l_image.make(l_path.name)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create Result.make_from_image(a_renderer, l_image)
					if Result.has_error then
						Result := Void
					end
				end
			end
		ensure
			Image_Exist: attached Result
		end
end
