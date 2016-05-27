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
			draw,
			set_events,
			exit_menu,
			launch_library,
			on_resume,
			on_mouse_motion,
			on_mouse_released
		end

create
	make_game_engine

feature {NONE} -- Initialization
	make_game_engine(a_context:CONTEXT)
		-- Initialization for `Current'.
		do
			make(a_context)
			create background.make (a_context.window.width, a_context.window.height, a_context.ressources_factory.room_background_texture)
			create return_button.make(32, 672, a_context.ressources_factory.return_button_texture, a_context.ressources_factory.return_button_texture_hovered, void, a_context.ressources_factory.button_sound)
			create room_overlay.make(0, 0, a_context.window.width, a_context.window.height, a_context.ressources_factory.room_overlay_texture)
			create text_color.make_rgb (0, 0, 0)
			create key_count_text_surface.make ("0", a_context.ressources_factory.pixelated_font (42), text_color)
			create key_count_texture.make_from_surface (a_context.renderer, key_count_text_surface)
			create key_overlay.make (920, 584, key_count_texture.width, key_count_texture.height, key_count_texture)
			create death_overlay.make (247, 197, a_context.ressources_factory.death_overlay_texture.width, a_context.ressources_factory.death_overlay_texture.height, a_context.ressources_factory.death_overlay_texture)
			create room_clear_overlay.make (212, 180, a_context.ressources_factory.room_clear_overlay_texture.width, a_context.ressources_factory.room_clear_overlay_texture.height, a_context.ressources_factory.room_clear_overlay_texture)
			button_list.extend(return_button)
			overlay_list.extend(room_overlay)
			overlay_list.extend(key_overlay)
			return_button.agent_click_button.extend(agent on_click_return_button)
			is_showing_death_overlay := false
			is_showing_clear_overlay := false
			key_count := 0
		end

feature -- Access
	set_room(a_new_room:ROOM)
			-- Sets the room of `Current' to `a_new_room'
		do
			room := a_new_room
		end

	launch_library
			-- Launches the library
		do
			game_library.launch_with_iteration_per_second(60)
		end

	exit_menu
			-- Exits the launch loop of `Current'
		do
			active := false
		end

	draw
			-- Draws everything in `Current'
		do
			render_engine.clear
			render_engine.render_list.wipe_out
			render_engine.render_list.extend (background)
			render_engine.render_list.append (overlay_list)
			render_engine.render_list.append (button_list)
			if attached room as la_room then
				render_engine.render_list.append (la_room.block_list)
			end
			render_engine.render
		end

	set_events(a_context:CONTEXT)
			-- Sets the events when `Current' is the active
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend(agent on_iteration)
			a_context.window.mouse_button_released_actions.extend (agent on_mouse_released)
			a_context.window.mouse_motion_actions.extend (agent on_mouse_motion)
			a_context.window.key_pressed_actions.extend(agent on_key_press)
			a_context.window.key_released_actions.extend(agent on_key_release)
		end

	restart_level
			-- Restarts the room of `Current'
		do
			if attached room as la_room then
				context.physic_engine.reset_room(la_room)
			end
			is_showing_death_overlay := false
			is_showing_clear_overlay := false
			context.render_engine.render_list.prune_all (death_overlay)
			context.render_engine.render_list.prune_all (room_clear_overlay)
		end

	on_resume
			-- Action to do when the library stops and `Current' is resumed
		do
			restart_level
		end

feature {NONE} -- Implementation
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
			end
		end

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

	on_key_press(a_timestamp:NATURAL_32; a_key_state:GAME_KEY_STATE)
			-- When the user pressed a key
		do
			if a_key_state.is_up and not a_key_state.is_repeat then
				context.physic_engine.move_player_up
			end
			if a_key_state.is_left and not a_key_state.is_repeat then
				context.physic_engine.move_player_left
			end
			if a_key_state.is_right and not a_key_state.is_repeat then
				context.physic_engine.move_player_right
			end
			if a_key_state.is_down and not a_key_state.is_repeat then
				context.physic_engine.move_player_down
			end
		end

	on_key_release(a_timestamp:NATURAL_32; a_key_state:GAME_KEY_STATE)
			-- When the user released a key
		do
			if a_key_state.is_r and not is_showing_clear_overlay then
				restart_level
			end
			if a_key_state.is_return and is_showing_clear_overlay then
				-- Add to rankings
				on_click_return_button
			end
			if a_key_state.is_escape then
				on_click_return_button
			end
		end

	on_iteration(a_timestamp:NATURAL_32)
			-- When the main loop iterates
		do
			if attached room as la_room then
				context.physic_engine.handle_physics(la_room)
				if attached context.physic_engine.find_player_in_block_list (la_room.block_list) as la_player then
					check_key_count(la_player.key_count)
					if la_player.is_dead and not is_showing_death_overlay then
						context.render_engine.render_list.extend (death_overlay)
						is_showing_death_overlay := true
					end
					if la_player.has_reached_goal and not is_showing_clear_overlay then
						context.render_engine.render_list.extend (room_clear_overlay)
						is_showing_clear_overlay := true
					end
				end
			end
			context.render_engine.update
		end

	on_click_return_button
			-- When the `return_button' is clicked
		do
			return_level := 2
			stop_library
		end

	check_key_count(a_player_key_count:INTEGER_32)
			-- Looks at the amount of key the player has and shows it on screen
		local
			l_key_count_string:STRING_8
		do
			if a_player_key_count /= key_count then
				key_count := a_player_key_count
				l_key_count_string := key_count.to_hex_string
				if key_count < 10 then
					l_key_count_string := l_key_count_string.substring (l_key_count_string.count, l_key_count_string.count)
				else
					l_key_count_string := l_key_count_string.substring (l_key_count_string.count - 1, l_key_count_string.count)
				end
				create key_count_text_surface.make (l_key_count_string, context.ressources_factory.pixelated_font (42), text_color)
				create key_count_texture.make_from_surface (context.renderer, key_count_text_surface)
				key_overlay.set_texture (key_count_texture)
			end
		end

	room:detachable ROOM
			-- The current room played

	room_overlay:OVERLAY
			-- An overlay for `Current'

	return_button:BUTTON
			-- The button to return to the menu rooms

	room_clear_overlay:OVERLAY
			-- The overlay that is shown when the player finishes a room

	death_overlay:OVERLAY
			-- The overlay that is shown when the player dies

	key_overlay:OVERLAY
			-- The overlay used to show the amount of keys

	key_count:INTEGER_32
			-- The amount of keys that the player has

	key_count_text_surface:TEXT_SURFACE_BLENDED
			-- The surface that shows the amount of keys owned

	key_count_texture:GAME_TEXTURE
			-- The texture that shows the amount of keys

	text_color:GAME_COLOR
			-- The color used to write text

	is_showing_death_overlay:BOOLEAN
			-- If the death overlay is currently shown or not

	is_showing_clear_overlay:BOOLEAN
			-- If the room clear overlay is currently shown or not

	move_count:INTEGER_32
			-- The amount of moves made by the player

	room_end_time:INTEGER_32
			-- The number of seconds needed to complete the room
end
