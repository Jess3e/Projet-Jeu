note
	description: "Summary description for {NETWORK_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NETWORK_ENGINE

create
	make

feature {NONE}
	make
		do
			create server.make
		end

feature
	server: SERVER

end
