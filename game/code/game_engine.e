note
	description: "Summary description for {GAME_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED
	AUDIO_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local

			l_ressources_factory:RESSOURCES_FACTORY

			-- Initialization for `Current'.

			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
		do
			create l_window_builder
			l_window_builder.set_title ("Game Project")
			l_window_builder.set_dimension (1024, 768)
			l_window_builder.set_is_position_centered (True)
			l_window := l_window_builder.generate_window

			create render_engine.make(l_window)

			create l_ressources_factory.make(l_window.renderer, l_window.pixel_format)
			create physics.make
			create audio.make
			create network.make
			create menu.make(l_ressources_factory, render_engine)

			music := l_ressources_factory.menu_music

			audio_library.sources_add
			music_source:=audio_library.last_source_added
			music_source.queue_sound_infinite_loop (music)
			music_source.play
			
			game_library.iteration_actions.extend (agent on_iteration)
			game_library.quit_signal_actions.extend (agent on_quit)

		end

	on_quit(a_timestamp: NATURAL_32)
	do
		game_library.stop
	end

	on_iteration(a_timestamp: NATURAL_32)
		do
			--audio.play_sources
			audio_library.update
		end

feature
	run
		do
			render_engine.render

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

	render_engine: RENDER_ENGINE
	physics: PHYSIC_ENGINE
	audio: AUDIO_ENGINE
	network: NETWORK_ENGINE
	menu: MENU_ENGINE

	music_source: AUDIO_SOURCE
	music: AUDIO_SOUND_FILE
end
