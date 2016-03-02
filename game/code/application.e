note
	description : "test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

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
		local
			l_game_engine:detachable GAME_ENGINE
		do
			game_library.enable_video
			audio_library.enable_sound
			image_file_library.enable_image (true, false, false)

			create l_game_engine.make
			l_game_engine.run
			l_game_engine := void

			image_file_library.quit_library
			audio_library.quit_library
			game_library.quit_library
		end

end
