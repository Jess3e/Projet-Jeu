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
	make(a_renderer:GAME_RENDERER; a_window:GAME_WINDOW; a_ressources_factory:RESSOURCES_FACTORY; a_render_engine:RENDER_ENGINE; a_physic_engine:PHYSIC_ENGINE)
			-- Initialization of `Current' using `a_renderer', `a_window' and `a_ressources_factory' to store them
		require
			ressources_factory_valid: not a_ressources_factory.has_error
			renderer_valid: not a_renderer.has_error
			window_valid: not a_window.has_error
			-- valid engines
		do
			renderer := a_renderer
			window := a_window
			ressources_factory := a_ressources_factory
			render_engine := a_render_engine
			physic_engine := a_physic_engine
		ensure
			renderer_set: renderer = a_renderer
			window_set: window = a_window
			ressources_factory_set: ressources_factory = a_ressources_factory
			render_engine_set: render_engine = a_render_engine
			physic_engine_set: physic_engine = a_physic_engine
		end

feature -- Access
	renderer:GAME_RENDERER
			-- What renders the `window'

	window:GAME_WINDOW
			-- The game window

	ressources_factory:RESSOURCES_FACTORY
			-- A factory that generates a variable from a ressource

	render_engine:RENDER_ENGINE
			-- The engine that manages the rendering of the game

	physic_engine:PHYSIC_ENGINE
			-- The engine that manages physics in the game
end
