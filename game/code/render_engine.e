note
	description: "An engine that renders everything in the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	RENDER_ENGINE

create
	make

feature {NONE} -- Initialization
	make(a_window:GAME_WINDOW_RENDERED)
		do
			renderer := a_window.renderer
			window := a_window
			create {LINKED_LIST [DRAWABLE]} render_list.make

		end

feature -- Access
	render_list: LIST [DRAWABLE]

	render
		do
			renderer.clear
			across render_list as drawable loop
				drawable.item.draw(renderer)
			end
			renderer.present
		end

	add_render_list(a_image:DRAWABLE)
		do
			render_list.extend (a_image)
		end

	renderer:GAME_RENDERER

	window:GAME_WINDOW_RENDERED
end
