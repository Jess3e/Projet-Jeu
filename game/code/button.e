note
	description: "Summary description for {BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON

inherit
	DRAWABLE
		rename
			make as make_drawable,
			make_resizable as make_resizable_drawable
		end

	SOUND
		rename
			make as make_sound
		end

create
	make, make_resizable

feature {NONE}
	make(a_x, a_y:INTEGER_32; a_texture:GAME_TEXTURE; a_audio_file:AUDIO_SOUND_FILE)
		do
			make_drawable(a_x, a_y, a_texture)
			audio_file := a_audio_file
			make_sound
			create agent_click_button
		end

	make_resizable(a_x, a_y , a_width, a_height:INTEGER_32; a_texture:GAME_TEXTURE; a_audio_file:AUDIO_SOUND_FILE)
		do
			make_resizable_drawable(a_x, a_y , a_width, a_height, a_texture)
			audio_file := a_audio_file
			make_sound
			create agent_click_button
		end

feature
	on_click(a_timestamp: NATURAL_32)
		do
			audio_source.queue_sound(audio_file)
			agent_play_sound.call(audio_source)
			agent_click_button.call (a_timestamp)
		end

	agent_click_button:ACTION_SEQUENCE [detachable TUPLE [timestamp: NATURAL_32]]
end
