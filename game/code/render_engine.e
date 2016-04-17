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
			-- Initialization of `Current' with the game window `a_window'
		require
			valid_window: not a_window.has_error
		do
			renderer := a_window.renderer
			window := a_window
			create {LINKED_LIST [DRAWABLE]} render_list.make
		ensure
			renderer_set: renderer = a_window.renderer
			window_set: window = a_window
		end

feature -- Access
	render_list: LIST [DRAWABLE]
			-- The list of drawables to draw on screen

	render
			-- Draw every objects in the render_list
		do
			across render_list as la_drawable loop
				la_drawable.item.draw(renderer)
			end
			renderer.present
		end

	clear
			-- Clear the renderer
		do
			renderer.clear
		end

	update
			-- Update the renderer
		do
			clear
			render(render_list)
		end

	renderer:GAME_RENDERER
			-- The renderer of the game window

	window:GAME_WINDOW_RENDERED
			-- The main game window
end
