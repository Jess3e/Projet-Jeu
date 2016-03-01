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
			create_image
		end

create
	make, make_resizable

feature {NONE}
	create_image
		do
			inspect
				type
				when 1 then
					image := ressources_factory.start_button_image
				else

			end
		end

end
