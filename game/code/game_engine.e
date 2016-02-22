note
	description: "Summary description for {GAME_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
			a: ARROW
			b: DRAWABLE
			c: ROOM
			d: BACKGROUND
			e: PLAYER
			f: WALL
			g: GOAL
			h: KEY
			i: WEAK_WALL
			j: LOCKED_BLOCK
			k: UNLOCKED_BLOCK
			l: BUTTON
			m: SPIKE

			-- Initialization for `Current'.
		do
			create graphics.make
			create physics.make
			create audio.make
			create network.make
		end

	on_quit(a_timestamp: NATURAL_32)
	do
		game_library.stop
	end

feature
	run
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
		do
			game_library.enable_video
			game_library.quit_signal_actions.extend (agent on_quit)
			create l_window_builder
			l_window_builder.set_title ("Game Project")
			l_window_builder.set_dimension (1024, 768)
			l_window_builder.set_is_position_centered (True)
			l_window := l_window_builder.generate_window
			game_library.launch
		end
	--allo:KEY
	--	attribute
	--		create Result
	--	end

	--run:INTEGER
	--	do
	--		Result := 0
	--	end

	--coucou
	--	local
	--		bonjour:INTEGER
	--	do
	--		bonjour := run
	--	end

	graphics: GRAPHIC_ENGINE
	physics: PHYSIC_ENGINE
	audio: AUDIO_ENGINE
	network: NETWORK_ENGINE

	run2
		do
			graphics.render
		end
end
