note
	description: "An engine that manages physics in the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	PHYSIC_ENGINE

create
	make

feature {NONE} -- Initialization
	make(a_room_width, a_room_height:INTEGER_32)
			-- Initialization of `Current'
		do
			room_width := a_room_width
			room_height := a_room_height
			direction := 0
		end

feature -- Access

	move_player_up
			-- Changes the direction of the player to up
		do
			if direction = 0 then
				direction := 1
			end
		end

	move_player_down
			-- Changes the direction of the player to down
		do
			if direction = 0 then
				direction := 2
			end
		end

	move_player_left
			-- Changes the direction of the player to left
		do
			if direction = 0 then
				direction := 3
			end
		end

	move_player_right
			-- Changes the direction of the player to right
		do
			if direction = 0 then
				direction := 4
			end
		end

	handle_physics(a_room:ROOM)
			-- Moves the player of the `a_room' in the current direction
		do
			if direction /= 0 then
				move_player_once(a_room.block_list)
			end
		end

	reset_room(a_room:ROOM)
			-- Resets every block in the `a_room'
		do
			across a_room.block_list as la_block_list loop
				la_block_list.item.reset
			end
			direction := 0
		end

	move_player_once(a_block_list:LIST[BLOCK])
			-- Moves the player towards the current direction the lenght of its size
		local
			l_player:detachable PLAYER
			l_contact_block:detachable BLOCK
			l_collison_position:TUPLE[x, y:INTEGER_32]
			l_position:TUPLE[x, y:INTEGER_32]
			l_new_position:TUPLE[x, y:INTEGER_32]
		do
			l_player := find_player_in_block_list(a_block_list)
			if attached l_player as la_player then
				if not la_player.is_moving then
					l_collison_position := change_position_with_move_lenght (la_player.x, la_player.y, la_player.sub_image_width, la_player.sub_image_height)
					l_contact_block := check_collision_new_position (l_collison_position.x, l_collison_position.y, a_block_list)
					if attached l_contact_block as la_contact_block then
						direction := la_contact_block.contact_action(la_player, direction)
					end
					l_position := change_position_with_move_lenght (la_player.x, la_player.y, la_player.sub_image_width, la_player.sub_image_height)
					l_new_position := move_other_side(l_position.x, l_position.y, la_player.sub_image_width, la_player.sub_image_height)
					if not l_new_position.is_equal (l_position) then
						la_player.move_to (l_new_position.x, l_new_position.y)
					else
						la_player.start_moving_to (l_position.x, l_position.y)
						change_player_draw_options(la_player)
					end
				end
				la_player.move_to_next_position
			end
		end

	find_player_in_block_list(a_block_list:LIST[BLOCK]):detachable PLAYER
			-- Find the player in `a_block_list' and returns it
		local
			l_player:detachable PLAYER
		do
			across a_block_list as la_block_list loop
				if attached {PLAYER} la_block_list.item as la_player then
					l_player := la_player
				end
			end
			Result := l_player
		end

	check_collision_new_position(a_new_x, a_new_y:INTEGER_32; a_block_list:LIST[BLOCK]):detachable BLOCK
			-- Check if the position (`a_new_x', `a_new_y') is the position of a block
			-- Returns the block if there is one
		local
			l_block:detachable BLOCK
		do
			l_block := void
			across a_block_list as la_block_list loop
				if la_block_list.item.x = a_new_x and la_block_list.item.y = a_new_y then
					l_block := la_block_list.item
				end
			end
			Result := l_block
		end

	change_player_draw_options(a_player:PLAYER)
			-- Sets the mirror and the texture of `a_player'
		local
			l_use_horizontal_texture:BOOLEAN
			l_horizontal_mirror:BOOLEAN
			l_vertical_mirror:BOOLEAN
		do
			l_use_horizontal_texture := false
			l_horizontal_mirror := false
			l_vertical_mirror := false
			inspect direction
			when 1 then
				l_vertical_mirror := true
			when 3 then
				l_use_horizontal_texture := true
				l_horizontal_mirror := true
			when 4 then
				l_use_horizontal_texture := true
			else
			end
			a_player.set_draw_options(l_use_horizontal_texture, l_horizontal_mirror, l_vertical_mirror)
		end

	change_position_with_move_lenght(a_initial_x, a_initial_y, a_horizontal_move_lenght, a_vertical_move_lenght:INTEGER_32):TUPLE[INTEGER_32, INTEGER_32]
			-- Moves the player towards the direction from its inital position (`a_initial_x', `a_initial_y') with the right move lenght
		local
			l_new_x:INTEGER_32
			l_new_y:INTEGER_32
		do
			l_new_x := a_initial_x
			l_new_y := a_initial_y
			inspect direction
			when 1 then
				l_new_y := l_new_y - a_vertical_move_lenght
			when 2 then
				l_new_y := l_new_y + a_vertical_move_lenght
			when 3 then
				l_new_x := l_new_x - a_horizontal_move_lenght
			when 4 then
				l_new_x := l_new_x + a_horizontal_move_lenght
			else
			end
			Result := [l_new_x, l_new_y]
		end

	move_other_side(a_player_x, a_player_y, a_player_width, a_player_height:INTEGER_32):TUPLE[INTEGER_32, INTEGER_32]
			-- Moves the player on the other side if he is outside the room
		local
			l_new_x:INTEGER_32
			l_new_y:INTEGER_32
		do
			l_new_x := a_player_x
			l_new_y := a_player_y
			if l_new_x < 0 then
				l_new_x := l_new_x + a_player_width * (room_width + 1)
			end
			if l_new_x > a_player_width * room_width then
				l_new_x := l_new_x - a_player_width * room_width
			end
			if l_new_y < 0 then
				l_new_y := l_new_y + a_player_height * (room_height + 1)
			end
			if l_new_y > a_player_height * room_height then
				l_new_y := l_new_y - a_player_height * room_height
			end
			Result := [l_new_x, l_new_y]
		end

feature {NONE} -- Implementation

	direction:INTEGER_32
			-- The direction that the player is moving in

	room_width:INTEGER_32
			-- The width of the room (in number of blocks)

	room_height:INTEGER_32
			-- The height of the room (in number of blocks)
	
end
