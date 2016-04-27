note
	description : "Target class for the game."
	date        : "2016-04-04"
	revision    : "1.0"

class
	APPLICATION

inherit
	GAME_LIBRARY_SHARED
	AUDIO_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Run the game and then close the librairies
		do
			run_game
			close_game
		end

	run_game
			-- Run the game
		local
			l_menu_main:MENU
			l_ressources_factory:RESSOURCES_FACTORY
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
			l_render_engine:RENDER_ENGINE
			l_context:CONTEXT
		do
			game_library.enable_video
			audio_library.enable_sound
			image_file_library.enable_image(true, false, false)
			l_window_builder.set_title("Blocus")
			l_window_builder.set_dimension(1024, 768)
			l_window_builder.set_is_position_centered(True)
			l_window := l_window_builder.generate_window
			create l_render_engine.make(l_window)
			create l_ressources_factory.make(l_window.renderer, l_window.pixel_format)
			create l_context.make(l_window.renderer, l_window, l_ressources_factory, l_render_engine)
			create {MENU_MAIN} l_menu_main.make(l_context)
			l_menu_main.launch(1)
		end


	close_game
			-- Close the libraries
		do
			game_library.clear_all_events
			game_library.quit_library
			audio_library.quit_library
			image_file_library.quit_library
		end
end
