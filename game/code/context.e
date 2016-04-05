note
	description: "This class is passed stores objects that are usually passed around."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	CONTEXT

create
	make

feature {NONE} -- Initialization
	make(a_renderer:GAME_RENDERER; a_window:GAME_WINDOW; a_ressources_factory:RESSOURCES_FACTORY)
		do
			renderer := a_renderer
			window := a_window
			ressources_factory := a_ressources_factory
		end

feature -- Access
	renderer:GAME_RENDERER

	window:GAME_WINDOW

	ressources_factory:RESSOURCES_FACTORY
end
