note
	description: "A class that shows and manages a menu."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

deferred class
	MENU

inherit
	GAME_LIBRARY_SHARED

feature -- Access
	button_list:LIST[BUTTON]
			-- A list of all buttons in `Current'

	background:BACKGROUND
			-- The background of `Current'
			
	--actif:BOOLEAN ?
end
