note
	description: "Summary description for {MENU_ROOMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ROOMS

inherit
	MENU

create
	make

feature {NONE}
	make(a_context:CONTEXT)
			-- Initialization of `Current' with `a_context' which containst the renderer, the window and the ressources_factory
		do
			create {ARRAYED_LIST[BUTTON]} button_list.make (3)
--			create start_button.make_resizable(288, 240, 192, 192, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
--			create config_button.make_resizable(544, 240, 192, 192, a_context.ressources_factory.config_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
--			create ranking_button.make_resizable(288, 496, 192, 192, a_context.ressources_factory.ranking_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
--			create exit_button.make_resizable(544, 496, 192, 192, a_context.ressources_factory.exit_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.start_button_texture, a_context.ressources_factory.button_sound)
			create background.make (a_context.window.width, a_context.window.height, a_context.ressources_factory.background_texture)

			button_list.extend (start_button)

			background.draw (a_context.renderer)
			start_button.draw (a_context.renderer)
			config_button.draw (a_context.renderer)
			ranking_button.draw (a_context.renderer)
			exit_button.draw (a_context.renderer)

			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)
		end
end
