note
	description: "Summary description for {AUDIO_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUDIO_ENGINE

create
	make

feature {NONE}
	make
		do
			create sources_list.make (0)
		end

	sources_list: ARRAYED_LIST [AUDIO_SOURCE]

feature
	play_sources
		do
			across sources_list as source loop
				source.item.play
			end
		end

	add_source(source:AUDIO_SOURCE)
		do
			sources_list.extend (source)
		end

feature

end
