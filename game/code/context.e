note
	description: "Summary description for {CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT

create
	make

feature {NONE}
	make(a_renderer:GAME_RENDERER; a_window:GAME_WINDOW; a_ressources_factory:RESSOURCES_FACTORY)
		do
			renderer := a_renderer
			window := a_window
			ressources_factory := a_ressources_factory
		end

feature
	renderer:GAME_RENDERER

	window:GAME_WINDOW

	ressources_factory:RESSOURCES_FACTORY
end
