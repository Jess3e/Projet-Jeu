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

feature -- Access
	blocks_room_1:LIST[BLOCK]

feature {NONE} -- Implementation
	create_blocks_room_1:ARRAYED_LIST[BLOCK]
		local
			l_blocks:ARRAYED_LIST[BLOCK]
			l_block_id_list:ARRAYED_LIST[INTEGER_32]
			l_room_file:PLAIN_TEXT_FILE
		do
			create l_blocks.make(230)
			create l_block_id_list.make(480)
			create l_room_file.make_with_name("room_1")
			load_room_from_file(l_room_file, l_block_id_list)
			l_blocks.append(load_blocks_from_block_list(l_block_id_list))
			Result := l_blocks
		end

	ressources_factory:RESSOURCES_FACTORY

	load_room_from_file(a_file:PLAIN_TEXT_FILE; a_block_id_list:LIST[INTEGER_32])
		local
			l_reading:BOOLEAN
		do
			if a_file.exists then
				if a_file.is_readable then
					a_file.open_read
					from
						l_reading := true
					until
						not l_reading
					loop
						if a_file.end_of_file then
							l_reading := false
						else
							a_file.read_integer_32
							a_block_id_list.extend(a_file.last_integer)
						end
					end
					a_file.close
				end
			end
		end

	load_blocks_from_block_list(a_block_id_list:LIST[INTEGER_32]):LIST[BLOCK]
		local
			l_block_list:LIST[BLOCK]
			l_block:detachable BLOCK
		do
			create {ARRAYED_LIST[BLOCK]} l_block_list.make(480)
			across a_block_id_list as la_block_id_list loop
				l_block := create_block_from_id(la_block_id_list.item, la_block_id_list.cursor_index)
				if attached l_block as la_block then
					l_block_list.extend(l_block)
				end
			end
			Result := l_block_list
		end

	create_block_from_id(a_block_id, a_position:INTEGER_32):detachable BLOCK
		local
			l_block:detachable BLOCK
		do
			inspect a_block_id
				when 1 then
					create {WALL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.wall_texture)
				when 2 then
					create {WEAK_WALL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.weak_wall_texture)
				when 3 then
					create {SPIKE} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.spike_texture)
				when 4 then
					create {KEY} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.key_texture)
				when 5 then
					create {LOCKED_BLOCK} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.locked_block_texture)
				--when 8 then
					--create {GOAL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.weak_wall_texture)
				when 9 then
					create {PLAYER} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.player_texture)
				-- 10, 11, 12, 13: Arrows
				else
					l_block := void
			end
			Result := l_block
		end
end
