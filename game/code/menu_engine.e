note
	description: "Summary description for {MENU_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE}
	make(a_ressources_factory:RESSOURCES_FACTORY; a_render_engine:RENDER_ENGINE)
		local
			l_start_button:BUTTON
		do
			create l_start_button.make_resizable(a_render_engine.renderer, a_ressources_factory, 10, 10, 256, 64, 1)

			a_render_engine.add_render_list (l_start_button)
		end

end

