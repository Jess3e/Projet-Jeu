note
	description: "A class that shows and manages a menu."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

deferred class
	MENU

inherit
	GAME_LIBRARY_SHARED

feature {NONE} -- Initialization
	make(a_context:CONTEXT)
		do
			create {ARRAYED_LIST[BUTTON]} button_list.make (1)
			create {ARRAYED_LIST[OVERLAY]} overlay_list.make (1)
			context := a_context
			render_engine := a_context.render_engine
			menu_level := 0
			return_level := 0
		end

feature -- Access
	button_list:LIST[BUTTON]
			-- A list of all buttons in `Current'

	overlay_list:LIST[OVERLAY]
			-- A list of all overlays in `Current'

	background:BACKGROUND
			-- The background of `Current'

	render_engine:RENDER_ENGINE
			-- The engine that renders the window

	context:CONTEXT
			-- A context that stores important arguments

	next_menu:detachable MENU
			-- The menu to launch when an action is done

	menu_level:INTEGER_8
			-- The level of `Current'

	return_level:INTEGER_8
			-- The level to go back when `Current' is closed

	launch_library
			-- Launches the library
		do
			game_library.launch
		end

	stop_library
			-- Stops the library
		do
			game_library.stop
		end

	exit_menu
			-- Exit the launch loop of `Current'
		do
			active := false
		end

	launch(a_menu_level:INTEGER_8)
			-- Main loop of `Current'
		do
			menu_level := a_menu_level
			from
				active := true
			until
				active = false
			loop
				set_events(context)
				draw
				launch_library
				game_library.clear_all_events
				on_resume
				if attached next_menu as la_next_menu then
					la_next_menu.launch(menu_level + 1)
					return_level := la_next_menu.return_level
				end
				next_menu := void
				if menu_level > return_level then
					exit_menu
				end
			end
		end

	draw
			-- Draw everything in `Current'
		do
			render_engine.clear
			render_engine.render_list.extend (background)
			render_engine.render_list.append (overlay_list)
			render_engine.render_list.append (button_list)
			render_engine.render
		end

	set_events(a_context:CONTEXT)
			-- Sets the events when `Current' is the active
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)
		end

	on_resume
			-- Actions to do when the library stops
		do
		end

feature {NONE} -- Implementation
	on_quit(a_timestamp:NATURAL_32)
			-- When the user tries to quit by closing the `window'
		do
			exit_menu
			return_level := 0
			stop_library
		end

	on_mouse_released(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_RELEASED_STATE; a_nb_clicks: NATURAL_8)
			-- When the user releashed the mouse button on the `window'
		do
			if a_mouse_state.is_left_button_released then
				across button_list as la_button loop
					if a_mouse_state.x >= la_button.item.x and a_mouse_state.x <= la_button.item.x + la_button.item.width then
						if a_mouse_state.y >= la_button.item.y and a_mouse_state.y <= la_button.item.y + la_button.item.height then
							la_button.item.on_click
							render_engine.update
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

	active:BOOLEAN
			-- If the menu is active or not
end
