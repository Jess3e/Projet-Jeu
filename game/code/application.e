note
	description : "test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
				--ajouter les autres librairies ici
			l_game_engine:detachable GAME_ENGINE
		do
			create l_game_engine.make

			l_game_engine.run

			l_game_engine:=void
				-- quitter les librairies
			game_library.quit_library
		end

end
