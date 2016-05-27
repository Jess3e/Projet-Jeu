note
	description: "The main playable character of the game."
	author: "Jessee Lefebvre"
	date: "2016-04-04"
	revision: "1.0"

class
	PLAYER

inherit
	ANIMATED_BLOCK
		rename
			make as make_animated
		redefine
			draw,
			animation_end
		end

create
	make

feature {NONE} -- Initialization
	make(a_x, a_y, a_animation_lenght, a_animation_index, a_frame_delay:INTEGER_32; a_vertical_animation_texture, a_horizontal_animation_texture:GAME_TEXTURE)
			-- Initialization for `Current' using `a_texture' to make an image at the position (`a_x', `a_y')
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
		do
			make_animated(a_x, a_y, a_animation_lenght, a_animation_index, a_frame_delay, a_vertical_animation_texture)
			is_dead := false
			has_reached_goal := false
			next_x := a_x
			next_y := a_y
			spawn_x := a_x
			spawn_y := a_y
			key_count := 0
			is_animating := false
			is_moving := false
			vertical_animation_texture := a_vertical_animation_texture
			horizontal_animation_texture := a_horizontal_animation_texture
		end

feature -- Access
	draw(a_renderer:GAME_RENDERER)
			-- Draw `Current' with dimension (`width'x`height') on the `a_renderer' at position (`x', `y')
		local
			l_texture:GAME_TEXTURE
		do
			if is_visible then
				if use_horizontal_texture then
					l_texture := horizontal_animation_texture
				else
					l_texture := vertical_animation_texture
				end
				a_renderer.draw_sub_texture_with_scale_rotation_and_mirror (l_texture, sub_image_width * current_index, 0, sub_image_width, sub_image_height,
					 x, y, sub_image_width, sub_image_height, 0, 0, 0, vertical_mirror, horizontal_mirror)
			end
		end

	contact_action(a_player:PLAYER; a_direction:INTEGER_32):INTEGER_32
			-- The action to do when the `a_player' is contacting `Current' from `a_direction'.
			-- Returns a new direction for the player
		do
			Result := 0
		end

	reset
			-- The action to do when the room is reset.
		do
			has_reached_goal := false
			is_dead := false
			x := spawn_x
			y := spawn_y
			key_count := 0
			next_x := x
			next_y := y
			set_index (0)
			is_animating := false
			is_moving := false
			set_draw_options(false, false, false)
		end

	reach_goal
			-- Reaches the goal of `Current'
		do
			is_moving_in_goal := true
		end

	kill
			-- Kills `Current'
		do
			is_dead := true
		end

	set_key_count(a_new_key_count:INTEGER_32)
			-- Sets the `key_count' to `a_new_key_count'
		do
			key_count := a_new_key_count
		end

	move_to(a_new_x, a_new_y:INTEGER_32)
			-- Changes the players coordinates to (`a_new_x', `a_new_y')
		do
			x := a_new_x
			y := a_new_y
		end

	move_to_next_position
			-- Moves `Current' towards the next position for his size divided by the animation lenght and stops him when done
		local
			l_done_x:BOOLEAN
			l_done_y:BOOLEAN
		do
			l_done_x := false
			l_done_y := false
			if is_moving then
				if x < next_x then
					move_to(x + sub_image_width // lenght, y)
				elseif x > next_x then
					move_to(x - sub_image_width // lenght, y)
				else
					l_done_x := true
				end
				if y < next_y then
					move_to(x, y + sub_image_width // lenght)
				elseif y > next_y then
					move_to(x, y - sub_image_width // lenght)
				else
					l_done_y := true
				end
				if l_done_x and l_done_y then
					is_moving := false
					set_index (0)
					is_animating := false
				end
			end
		end

	start_moving_to(a_new_x, a_new_y:INTEGER_32)
			-- Sets the next moving location
		do
			if not is_dead and not has_reached_goal then
				next_x := a_new_x
				next_y := a_new_y
				is_moving := true
				is_animating := true
			end
		end

	set_draw_options(a_use_horizontal_texture, a_horizontal_mirror, a_vertical_mirror:BOOLEAN)
			-- Sets the mirrors and the texture to use for `Current'
		do
			if not is_dead and not has_reached_goal then
				use_horizontal_texture := a_use_horizontal_texture
				horizontal_mirror := a_horizontal_mirror
				vertical_mirror := a_vertical_mirror
			end
		end


	has_reached_goal:BOOLEAN
			-- If `Current' has reached the goal or not

	is_dead:BOOLEAN
			-- If `Current' is dead or not

	is_moving:BOOLEAN
			-- If `Current' is moving or not

	key_count:INTEGER_32
			-- The amount of keys the player has

feature {NONE} -- Implementation

	animation_end
			-- Action to do when the animation ends
		do
			if is_moving_in_goal then
				has_reached_goal := true
			end
		end

	spawn_x:INTEGER_32
			-- The x coordinate of the spawn position of `Current'

	spawn_y:INTEGER_32
			-- The y coordinate of the spawn position of `Current'

	next_x:INTEGER_32
			-- The x coordinate of the next location

	next_y:INTEGER_32
			-- The y coordinate of the next location

	is_moving_in_goal:BOOLEAN
			-- If `Current' is moving in the goal or not

	use_horizontal_texture:BOOLEAN
			-- If the texture of `Current' to use is the `horizontal_animation_texture' or the `vertical_animation_texture'

	horizontal_mirror:BOOLEAN
			-- If `Current' has a horizontal mirror or not

	vertical_mirror:BOOLEAN
			-- If `Current' has a vertical mirror or not

	vertical_animation_texture:GAME_TEXTURE
			-- The texture to use for the vertical animation

	horizontal_animation_texture:GAME_TEXTURE
			-- The texture to use for the horizontal animation

end
