note
	description: "A {MENU} that manages the main game screen."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	MENU_MAIN

inherit
	MENU

create
	make

feature {NONE} -- Initialization
	make(a_context:CONTEXT; a_render_engine:RENDER_ENGINE)
			-- Initialization of `Current' with `a_context' which containst the renderer, the window and the ressources_factory
		do
			create {ARRAYED_LIST[BUTTON]} button_list.make (4)

			create start_button.make_resizable(288, 240, 192, 192, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture_hovered,
						a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)

			create config_button.make_resizable(544, 240, 192, 192, a_context.ressources_factory.config_button_texture, a_context.ressources_factory.start_button_texture,
						a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)

			create ranking_button.make_resizable(288, 496, 192, 192, a_context.ressources_factory.ranking_button_texture, a_context.ressources_factory.start_button_texture,
						a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)

			create exit_button.make_resizable(544, 496, 192, 192, a_context.ressources_factory.exit_button_texture, a_context.ressources_factory.start_button_texture,
						a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)

			create background.make (a_context.window.width, a_context.window.height, a_context.ressources_factory.background_texture)

			render_engine := a_render_engine
			render_engine.clear
			button_list.extend (start_button)
			button_list.extend (config_button)
			button_list.extend (ranking_button)
			button_list.extend (exit_button)
			render_engine.render_list.extend (background)
			render_engine.render_list.append (button_list)
			render_engine.render

			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)

			start_button.agent_click_button.extend (agent on_click_start_button)
		end

feature {NONE} -- Implementation
	on_mouse_released(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_RELEASED_STATE; a_nb_clicks: NATURAL_8)
			-- When the user releashed the mouse button on the `window'
		do
			if a_mouse_state.is_left_button_released then
				across button_list as la_button loop
					if a_mouse_state.x >= la_button.item.x and a_mouse_state.x <= la_button.item.x + la_button.item.width then
						if a_mouse_state.y >= la_button.item.y and a_mouse_state.y <= la_button.item.y + la_button.item.height then
							la_button.item.on_click
						end
					end
				end
			end
		end


	on_mouse_motion(a_timestamp:NATURAL_32; a_mouse_state:GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y:INTEGER_32)
			-- When the user moved the mouse button in the `window'
		local
			l_hover:BOOLEAN
		do
			across button_list as la_button loop
				l_hover := false
				if a_mouse_state.x >= la_button.item.x and a_mouse_state.x <= la_button.item.x + la_button.item.width then
					if a_mouse_state.y >= la_button.item.y and a_mouse_state.y <= la_button.item.y + la_button.item.height then
						l_hover := true
					end
				end
				if l_hover then
					la_button.item.on_mouse_in
				else
					la_button.item.on_mouse_out
				end
				render_engine.update
			end
		end

	play_sound(a_source:AUDIO_SOURCE)
			-- Play a the source `a_source'
		require
			valid_audio_source: not a_source.has_error
		do
			a_source.play
		end

	on_click_start_button
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

end

