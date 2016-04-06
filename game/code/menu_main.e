note
	description: "A {MENU} that manages the main game screen."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	MENU_MAIN

inherit
	GAME_LIBRARY_SHARED
	MENU

create
	make

feature {NONE} -- Initialization
	make(a_context:CONTEXT)
			-- Initialization of `Current' with `a_context' which containst the renderer, the window and the ressources_factory
		do
			create {ARRAYED_LIST[BUTTON]} button_list.make (3)
			create start_button.make_resizable(288, 240, 192, 192, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
			create config_button.make_resizable(544, 240, 192, 192, a_context.ressources_factory.config_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
			create ranking_button.make_resizable(288, 496, 192, 192, a_context.ressources_factory.ranking_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
			create exit_button.make_resizable(544, 496, 192, 192, a_context.ressources_factory.exit_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
			create background.make (a_context.window.width, a_context.window.height, a_context.ressources_factory.background_texture)

			--start_button.agent_click_button.extend (agent on_click_start_button)
			button_list.extend (start_button)

			background.draw (a_context.renderer)
			start_button.draw (a_context.renderer)
			config_button.draw (a_context.renderer)
			ranking_button.draw (a_context.renderer)
			exit_button.draw (a_context.renderer)

			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)
		end

feature {NONE} -- Implementation
	on_mouse_released(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_RELEASED_STATE; a_nb_clicks: NATURAL_8)
			-- When the user releashed the mouse button on the `window'
		do
			if a_mouse_state.is_left_button_released then
				if a_mouse_state.x >= start_button.x and a_mouse_state.x <= start_button.x + start_button.width then
					if a_mouse_state.y >= start_button.y and a_mouse_state.y <= start_button.y + start_button.height then
						on_click_start_button(a_timestamp)
					end
				end
			end
		end


	on_mouse_motion(a_timestamp:NATURAL_32; a_mouse_state:GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y:INTEGER_32)
			-- When the user moved the mouse button in the `window'
		do

		end

	play_sound(a_source:AUDIO_SOURCE)
			-- Play a the source `a_source'
		require
			valid_audio_source: not a_source.has_error
		do
			a_source.play
		end

	on_click_start_button(a_timestamp: NATURAL_32)
			-- When the `start_button' is clicked
		do

		end

	start_button:BUTTON
			-- The button to start the game

	config_button:BUTTON
			-- The button to start the config menu

	ranking_button:BUTTON
			-- The button to view the highscores

	exit_button:BUTTON
			-- The button to exit the game

	background:BACKGROUND
			-- The background of `Current'

	button_list:LIST[BUTTON]
			-- A list of all buttons in `Current'
end

