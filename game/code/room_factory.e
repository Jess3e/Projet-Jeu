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
			-- Initialization of current with `a_ressources_factory' to get the textures of the blocks that are created
		do
			ressources_factory := a_ressources_factory
			create room_1.make (create_blocks_room_1)
			create room_2.make (create_blocks_room_2)
			create room_3.make (create_blocks_room_3)
			create room_4.make (create_blocks_room_4)
		end

feature -- Access
	room_1:ROOM
			-- The first room of the game

	room_2:ROOM
			-- The second room of the game

	room_3:ROOM
			-- The third room of the game

	room_4:ROOM
			-- The fourth room of the game

feature {NONE} -- Implementation
	create_blocks_room_1:LIST[BLOCK]
			-- Creates the block list of the first room from a file
		local
			l_block_id_list:LIST[INTEGER_32]
			l_room_file:PLAIN_TEXT_FILE
			l_block_list:LIST[BLOCK]
		do
			create {ARRAYED_LIST[BLOCK]} l_block_list.make(231)
			create {ARRAYED_LIST[INTEGER_32]} l_block_id_list.make(480)
			create l_room_file.make_with_name("room_1")
			load_room_from_file(l_room_file, l_block_id_list)
			l_block_list.append(load_blocks_from_block_list(l_block_id_list))
			Result := l_block_list
		end


	create_blocks_room_2:LIST[BLOCK]
			-- Creates the block list of the second room from a file
		local
			l_block_id_list:LIST[INTEGER_32]
			l_room_file:PLAIN_TEXT_FILE
			l_block_list:LIST[BLOCK]
		do
			create {ARRAYED_LIST[BLOCK]} l_block_list.make(147)
			create {ARRAYED_LIST[INTEGER_32]} l_block_id_list.make(480)
			create l_room_file.make_with_name("room_2")
			load_room_from_file(l_room_file, l_block_id_list)
			l_block_list.append(load_blocks_from_block_list(l_block_id_list))
			Result := l_block_list
		end

	create_blocks_room_3:LIST[BLOCK]
			-- Creates the block list of the third room from a file
		local
			l_block_id_list:LIST[INTEGER_32]
			l_room_file:PLAIN_TEXT_FILE
			l_block_list:LIST[BLOCK]
		do
			create {ARRAYED_LIST[BLOCK]} l_block_list.make(119)
			create {ARRAYED_LIST[INTEGER_32]} l_block_id_list.make(480)
			create l_room_file.make_with_name("room_3")
			load_room_from_file(l_room_file, l_block_id_list)
			l_block_list.append(load_blocks_from_block_list(l_block_id_list))
			Result := l_block_list
		end

	create_blocks_room_4:LIST[BLOCK]
			-- Creates the block list of the third room from a file
		local
			l_block_id_list:LIST[INTEGER_32]
			l_room_file:PLAIN_TEXT_FILE
			l_block_list:LIST[BLOCK]
		do
			create {ARRAYED_LIST[BLOCK]} l_block_list.make(200)
			create {ARRAYED_LIST[INTEGER_32]} l_block_id_list.make(480)
			create l_room_file.make_with_name("room_4")
			load_room_from_file(l_room_file, l_block_id_list)
			l_block_list.append(load_blocks_from_block_list(l_block_id_list))
			Result := l_block_list
		end

	ressources_factory:RESSOURCES_FACTORY
			-- The factory that creates the ressources of the game

	load_room_from_file(a_file:PLAIN_TEXT_FILE; a_block_id_list:LIST[INTEGER_32])
			-- Loads a room from `a_file' and stores it in `a_block_id_list'
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
			-- Loads blocks from `a_block_id_list' and returns the list of blocks
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
			-- Creates a block from `a_block_id', `a_position', and returns it
		local
			l_block:detachable BLOCK
		do
			inspect a_block_id
				when 1 then
					create {WALL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.wall_texture)
				when 2 then
					create {WEAK_WALL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), 9, 0, 1, ressources_factory.weak_wall_animation_texture)
				when 3 then
					create {TNT} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), 5, 0, 5, ressources_factory.tnt_animation_texture)
				when 4 then
					create {KEY} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.key_texture)
				when 5 then
					create {LOCKED_BLOCK} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), ressources_factory.locked_block_texture)
				when 8 then
					create {GOAL} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), 8, 0, 3, ressources_factory.goal_animation_texture)
				when 9 then
					create {PLAYER} l_block.make(32 * (1 + ((a_position - 1) \\ 30)), 32 * (1 + ((a_position - 1) // 30)), 8, 0, 0, ressources_factory.vertical_animation_texture, ressources_factory.horizontal_animation_texture)
				else
					l_block := void
			end
			Result := l_block
		end

end
