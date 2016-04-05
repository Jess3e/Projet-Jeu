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
			create physics.make
			create audio.make
			create network.make
			create main_menu.make(context)

			game_library.iteration_actions.extend (agent on_iteration)
			game_library.quit_signal_actions.extend (agent on_quit)
		end

feature -- Access
	run
		do
			render_engine.render

			game_library.launch
		end

	render_engine: RENDER_ENGINE

	physics: PHYSIC_ENGINE

	audio: AUDIO_ENGINE

	network: NETWORK_ENGINE

	main_menu: MENU_MAIN

	context: CONTEXT


feature {NONE} -- Implementation
	on_quit(a_timestamp: NATURAL_32)
		do
			game_library.stop
		end

	on_iteration(a_timestamp: NATURAL_32)
		do
			audio_library.update
		end

end
