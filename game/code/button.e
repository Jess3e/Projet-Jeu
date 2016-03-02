note
	description: "Summary description for {BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON

inherit
	DRAWABLE
		redefine
			create_image, make, make_resizable
		end
	SOUND

create
	make, make_resizable

feature {NONE}
	make(a_renderer:GAME_RENDERER; a_ressources_factory:RESSOURCES_FACTORY; a_x, a_y, a_type:INTEGER_32)
		do
			Precursor(a_renderer, a_ressources_factory, a_x, a_y, a_type)
			sound := ressources_factory.button_sound
			handle_sound
		end

	make_resizable(a_renderer:GAME_RENDERER; a_ressources_factory:RESSOURCES_FACTORY; a_x, a_y , a_width, a_height, a_type:INTEGER_32)
		do
			Precursor(a_renderer, a_ressources_factory, a_x, a_y , a_width, a_height, a_type)
			sound := ressources_factory.button_sound
			handle_sound
		end

	create_image
		do
			inspect
				type
				when 1 then
					image := ressources_factory.start_button_image
				else

			end
		end

feature
	on_click
		do
			sound_source.queue_sound(sound)
			agent_play_sound.call(sound_source)
			inspect
				type
			when 1 then

			else

			end
		end
end
