note
	description: "Summary description for {ROOM_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOM_FACTORY

create
	make

feature {NONE}
	make(a_ressources_factory:RESSOURCES_FACTORY)
		do
			ressources_factory := a_ressources_factory
			blocks_room_1 := create_blocks_room_1
		end

feature
	blocks_room_1:LIST[BLOCK]

feature {NONE}
	create_blocks_room_1:ARRAYED_LIST[BLOCK]
		local
			blocks:ARRAYED_LIST[BLOCK]
		do
			create blocks.make (10)
			blocks.extend (create {WALL}.make(16, 16, ressources_factory.wall_texture))
			blocks.extend (create {WALL}.make(48, 16, ressources_factory.wall_texture))
			blocks.extend (create {WALL}.make(16, 48, ressources_factory.wall_texture))
			Result := blocks
		end

feature {NONE}
	ressources_factory:RESSOURCES_FACTORY
end
