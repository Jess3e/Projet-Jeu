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
			-- Initialization of `Current' using `a_renderer', `a_window' and `a_ressources_factory' to store them
		require
			ressources_factory_valid: not a_ressources_factory.has_error
			renderer_valid: not a_renderer.has_error
			window_valid: not a_window.has_error
		do
			renderer := a_renderer
			window := a_window
			ressources_factory := a_ressources_factory
		ensure
			renderer_set: renderer = a_renderer
			window_set: window = a_window
			ressources_factory_set: ressources_factory = a_ressources_factory
		end

feature -- Access
	renderer:GAME_RENDERER
			-- What renders the `window'

	window:GAME_WINDOW
			-- The game window

	ressources_factory:RESSOURCES_FACTORY
			-- A factory that generates a variable from a ressource
end
