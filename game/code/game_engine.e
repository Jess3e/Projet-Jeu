note
	description: "The main engine of the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED
	AUDIO_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		-- Initialization for `Current'.
		local
			l_ressources_factory:RESSOURCES_FACTORY
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
		do
			create l_window_builder

			l_window_builder.set_title ("Game Project")
			l_window_builder.set_dimension (1024, 768)
			l_window_builder.set_is_position_centered (True)
			l_window := l_window_builder.generate_window

			create render_engine.make(l_window)
			create l_ressources_factory.make(l_window.renderer, l_window.pixel_format)
			create context.make(l_window.renderer, l_window, l_ressources_factory)
			create physic_engine.make
			create audio_engine.make
			create network_engine.make
			create main_menu.make(context)

			game_library.iteration_actions.extend (agent on_iteration)
			game_library.quit_signal_actions.extend (agent on_quit)
		end

feature -- Access
	run
			-- Launch the game library
		require
			valid_ressources_factory: not context.ressources_factory.has_error
			valid_window: not context.window.has_error
			valid_renderer: not context.renderer.has_error
		do
			render_engine.render
			game_library.launch
		end

	render_engine: RENDER_ENGINE
			-- The engine that renders the game window

	physic_engine: PHYSIC_ENGINE
			-- The engine that manages the physics of the game

	audio_engine: AUDIO_ENGINE
			-- The engine that manages the audio of the game

	network_engine: NETWORK_ENGINE
			-- The engine that manages the network of the game

	main_menu: MENU_MAIN
			-- The main menu of the game

	context: CONTEXT
			-- A context that stores important arguments

feature {NONE} -- Implementation
	on_quit(a_timestamp: NATURAL_32)
			-- When the user close the window
		do
			game_library.stop
		end

	on_iteration(a_timestamp: NATURAL_32)
			-- When the main game loop iterate
		do
			audio_library.update
		end

end
