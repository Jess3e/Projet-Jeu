note
	description: "A {MENU} that manages the main game screen."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	MENU_MAIN

inherit
	MENU
		redefine
			make
		end

	SOUND
		rename
			make as make_sound
		end

create
	make

feature {NONE} -- Initialization
	make(a_context:CONTEXT)
			-- Initialization of `Current' with `a_context' which containst the renderer, the window and the ressources_factory
		do
			Precursor(a_context)
			make_sound
			audio_file := a_context.ressources_factory.menu_music
			create start_button.make_resizable(288, 240, 192, 192, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture_hovered,
						a_context.ressources_factory.start_button_texture_clicked, a_context.ressources_factory.button_sound)
			create config_button.make_resizable(544, 240, 192, 192, a_context.ressources_factory.config_button_texture, a_context.ressources_factory.config_button_texture_hovered,
						a_context.ressources_factory.config_button_texture_clicked, a_context.ressources_factory.button_sound)
			create ranking_button.make_resizable(288, 496, 192, 192, a_context.ressources_factory.ranking_button_texture, a_context.ressources_factory.ranking_button_texture_hovered,
						a_context.ressources_factory.ranking_button_texture_clicked, a_context.ressources_factory.button_sound)
			create exit_button.make_resizable(544, 496, 192, 192, a_context.ressources_factory.exit_button_texture, a_context.ressources_factory.exit_button_texture_hovered,
						a_context.ressources_factory.exit_button_texture_clicked, a_context.ressources_factory.button_sound)
			create background.make (a_context.window.width, a_context.window.height, a_context.ressources_factory.background_texture)
			start_button.agent_click_button.extend (agent on_click_start_button)
			exit_button.agent_click_button.extend (agent on_click_exit_button)
			button_list.extend (start_button)
			button_list.extend (config_button)
			button_list.extend (ranking_button)
			button_list.extend (exit_button)
			audio_source.queue_sound_infinite_loop (audio_file)
			audio_source.play
		end

feature {NONE} -- Implementation

	on_click_start_button
			-- When the `start_button' is clicked
		do
			create {MENU_ROOMS} next_menu.make(context)
			stop_library
		end

	on_click_exit_button
			-- When the `exit_button' is clicked
		do
			on_quit(1)
		end

	start_button:BUTTON
			-- The button to start the game

	config_button:BUTTON
			-- The button to start the config menu

	ranking_button:BUTTON
			-- The button to view the highscores

	exit_button:BUTTON
			-- The button to exit the game
end

