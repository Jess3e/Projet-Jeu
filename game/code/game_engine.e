note
	description: "The main engine of the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	GAME_ENGINE

inherit
	MENU
		redefine
			draw_menu,
			set_events,
			exit_menu
		end

create
	make_game_engine

feature {NONE} -- Initialization
	make_game_engine(a_context:CONTEXT; a_room:ROOM)
		-- Initialization for `Current'.
		do
			make(a_context)
			create mutex.make
			create timer.make(mutex)
			timer.launch
			room := a_room
			background := room.background
			create return_button.make(32, 672, a_context.ressources_factory.return_button_texture, a_context.ressources_factory.return_button_texture_hovered,
						a_context.ressources_factory.return_button_texture_hovered, a_context.ressources_factory.button_sound)
			create room_overlay.make(0, 0, a_context.window.width, a_context.window.height, a_context.ressources_factory.room_overlay_texture)
			overlay_list.extend(room_overlay)
			button_list.extend(return_button)
			return_button.agent_click_button.extend(agent on_click_return_button)
		end

feature -- Access
	exit_menu
			-- Exit the launch loop of `Current'
		do
			timer.stop_thread
			active := false
		end

	draw_menu
			-- Draw everything in `Current'
		do
			render_engine.clear
			render_engine.render_list.extend (background)
			render_engine.render_list.append (overlay_list)
			render_engine.render_list.append (button_list)
			render_engine.render_list.append (room.block_list)
			render_engine.render
		end

	set_events(a_context:CONTEXT)
			-- Sets the events when `Current' is the active
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)
		end

feature {NONE} -- Implementation
	on_click_return_button
			-- When the `return_button' is clicked
		do
			return_level := 2
			stop_library
		end

	room:ROOM
			-- The current room played

	room_overlay:OVERLAY
			-- An overlay for `Current'

	return_button:BUTTON
			-- The button to return to the menu rooms

	timer:TIMER

	mutex:MUTEX
end
