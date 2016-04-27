note
	description: "Summary description for {TIMER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIMER

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization
	make(a_mutex:MUTEX)
		do
			make_thread
			mutex := a_mutex
			create room_enter_time.make_now
			create current_time.make_now
			create timer.make(0, 0, 0)
			stopping := false
			old_timer_seconds := -1
		end

feature -- Access
	execute
		do
			from
			until
				stopping
			loop
				create current_time.make_now
				calculate_timer
				show_timer
			end
		end

	stop_thread
		do
			io.put_string("Exit the room")
			io.put_new_line
			stopping := true
		end

	calculate_timer
		local
			l_difference:INTEGER_32
		do
			l_difference := current_time.seconds - room_enter_time.seconds
			mutex.lock
			create timer.make_by_seconds(l_difference)
			mutex.unlock
		end

	show_timer

		do
			mutex.lock
			if not (timer.seconds_count = old_timer_seconds) then
				io.put_integer(timer.seconds_count)
				old_timer_seconds := timer.seconds_count
				io.put_new_line
			end
			mutex.unlock
		end

	mutex:MUTEX

feature {NONE} -- Implementation
	room_enter_time:TIME

	current_time:TIME

	timer:TIME_DURATION

	stopping:BOOLEAN

	old_timer_seconds:INTEGER_32
end
