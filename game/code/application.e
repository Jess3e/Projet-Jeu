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
		-- Run the game
		local
			l_game_engine:detachable GAME_ENGINE
		do
			game_library.enable_video
			audio_library.enable_sound
			image_file_library.enable_image (true, false, false)

			create l_game_engine.make
			if not l_game_engine.context.ressources_factory.has_error then
				l_game_engine.run
			end
			l_game_engine := void
			game_library.clear_all_events
			
			game_library.quit_library
			audio_library.quit_library
			image_file_library.quit_library
		end

end
