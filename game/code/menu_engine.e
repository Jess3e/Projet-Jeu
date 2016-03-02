note
	description: "Summary description for {MENU_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE}
	make(a_ressources_factory:RESSOURCES_FACTORY; a_render_engine:RENDER_ENGINE)
		do

			create start_button.make_resizable(a_render_engine.renderer, a_ressources_factory, 10, 10, 256, 64, 1)

			a_render_engine.add_render_list (start_button)
			a_render_engine.window.mouse_button_released_actions.extend (agent on_mouse_released)

		end

	on_mouse_released(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_RELEASED_STATE; a_nb_clicks: NATURAL_8)
		do
			if a_mouse_state.is_left_button_released then
				if a_mouse_state.x >= start_button.x and a_mouse_state.x <= start_button.x + start_button.width then
					if a_mouse_state.y >= start_button.y and a_mouse_state.y <= start_button.y + start_button.height then
						start_button.on_click
						start_button.agent_play_sound.extend (agent play_sound)
					end
				end
			end
		end

	play_sound(a_source:AUDIO_SOURCE)
		do
			a_source.play
		end

	start_button:BUTTON


end

