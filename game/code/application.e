note
	description : "test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	GAME_LIBRARY_SHARED
	AUDIO_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
			l_game_engine:detachable GAME_ENGINE
		do
			game_library.enable_video
			audio_library.enable_sound
			create l_game_engine.make
			
			l_game_engine.run

			l_game_engine:=void
			audio_library.quit_library
			game_library.quit_library
		end

end
