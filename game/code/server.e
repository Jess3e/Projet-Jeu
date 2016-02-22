note
	description: "Summary description for {SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SERVER

create
	make

feature {NONE}
	make
		do
			create ranking.make
		end

feature
	ranking: RANKING
	
end
