note
	description: "Summary description for {GRAPHIC_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHIC_ENGINE

create
	make

feature {NONE}
	make
		do
			create render_list.make
		end

feature
	render_list: LINKED_LIST[DRAWABLE]

	render
		do

		end


end
