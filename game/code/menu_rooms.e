note
	description: "Summary description for {MENU_ROOMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ROOMS

inherit
	MENU
		redefine
			make
		end

create
	make

feature {NONE}
	make(a_context:CONTEXT)
			-- Initialization of `Current' with `a_context' which containst the renderer, the window and the ressources_factory
		do
			Precursor(a_context)
			create room_factory.make(a_context.ressources_factory)
			create background.make(a_context.window.width, a_context.window.height, a_context.ressources_factory.background_texture)
			create menu_overlay.make(0, 0, a_context.window.width, a_context.window.height, a_context.ressources_factory.menu_room_overlay_texture)
			create room_1_button.make(160, 365, a_context.ressources_factory.menu_room_button_texture, a_context.ressources_factory.menu_room_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			create room_2_button.make(352, 365, a_context.ressources_factory.menu_room_button_texture, a_context.ressources_factory.menu_room_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			create room_3_button.make(544, 365, a_context.ressources_factory.menu_room_button_texture, a_context.ressources_factory.menu_room_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			create room_4_button.make(736, 365, a_context.ressources_factory.menu_room_button_texture, a_context.ressources_factory.menu_room_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			create return_button.make(180, 560, a_context.ressources_factory.return_button_texture, a_context.ressources_factory.return_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			button_list.extend(room_1_button)
			button_list.extend(room_2_button)
			button_list.extend(room_3_button)
			button_list.extend(room_4_button)
			button_list.extend(return_button)
			overlay_list.extend(menu_overlay)
			return_button.agent_click_button.extend(agent on_click_return_button)
			room_1_button.agent_click_button.extend(agent on_click_room_1_button)
			room_2_button.agent_click_button.extend(agent on_click_room_2_button)
		end

feature {NONE} -- Implementation
	on_click_return_button
			-- When the `return_button' is clicked
		do
			return_level := 1
			stop_library
		end

	on_click_room_1_button
		do
			create next_room.make(room_factory.blocks_room_1, background)
			if attached next_room as la_room then
				create {GAME_ENGINE} next_menu.make_game_engine(context, la_room)
			end
			stop_library
		end

	on_click_room_2_button
		do
			create next_room.make(room_factory.blocks_room_2, background)
			if attached next_room as la_room then
				create {GAME_ENGINE} next_menu.make_game_engine(context, la_room)
			end
			stop_library
		end

	on_click_room_3_button
		do

		end

	on_click_room_4_button
		do

		end

	menu_overlay:OVERLAY
			-- The overlay for the menu

	return_button:BUTTON
			-- The button to return to the main menu

	room_1_button:BUTTON
			-- The button to access the room 1

	room_2_button:BUTTON
			-- The button to access the room 2

	room_3_button:BUTTON
			-- The button to access the room 3

	room_4_button:BUTTON
			-- The button to access the room 4

	next_room:detachable ROOM

	room_factory:ROOM_FACTORY
end
