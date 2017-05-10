-- 2014-02-10 by xeXpanderx http://xexpanderx.deviantart.com/
-- 2017 modified by Thiago Fontes

require 'cairo'

------------------------- Configuration  ----------------------------------

-- Widget type select from 1 or 2
widget_type = 1

-- Your screen resolution
resolution_x = 1366
resolution_y = 768

-- x and y start position
x_start = 20
y_start = 20

-- Your battery number, if 0 is not working try 1 or check your /proc/acpi/battery/ directory.
battery_dev = "BAT0"

-- Transparency, from 0 to 1.
transp = 0.70



-- Internet Widget configuration
interface = "wlp3s0"	-- Run "ip addr" to see what is yout device
maxdown = 1200		-- Your max speed in kb/s
maxup = 300






------ Theme configuration end -----










--------------------------------------------------------------------------------------------------------------------------
-- Widgets are defined bellow modify if you know how to program --





















































------------------------- Heavy code --------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--                                                                 rgb_to_r_g_b
-- converts color in hexa to decimal
--
function rgb_to_r_g_b(colour, alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
--------------------------------------------------------------------------------------------------------------------------

function draw_widget(cr, x, y, str_conky, font_size, height)
	cairo_move_to (cr, x, y)
	local border_pat = cairo_pattern_create_linear(x, y - 10, x, y + 10)
	cairo_pattern_add_color_stop_rgba(border_pat, 0, 1, 1, 1, transp)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.3, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.5, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.7, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 1, 1, 1, 1, transp)
	cairo_set_source(cr, border_pat)
	cairo_arc(cr, x, y, 10, 0, 2 * math.pi)
	cairo_set_line_width(cr, 3)
	cairo_fill(cr)

	cairo_move_to (cr, x, y);
	cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05)
	cairo_rel_line_to (cr, 10, 27)
	cairo_rel_line_to (cr, 270, 0)
	cairo_rel_line_to (cr, 8, 8)
	cairo_rel_line_to (cr, 0, height)
	cairo_rel_line_to (cr, - 8, 8)
	cairo_rel_line_to (cr, - 270, 0)
	cairo_set_line_width (cr, 3);
	cairo_stroke (cr);

	cairo_move_to (cr, x + 15, y + 22)
	cairo_set_source_rgba(cr, 1, 1, 1, transp)
	cairo_set_font_size (cr, font_size);
	cairo_show_text (cr, str_conky)
end

function draw_widget_m(cr, x, y, str_conky, font_size, height)
	x = resolution_x - x
	local border_pat = cairo_pattern_create_linear(x, y - 10, x, y + 10)
	cairo_pattern_add_color_stop_rgba(border_pat, 0, 1, 1, 1, transp)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.3, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.5, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 0.7, 1, 1, 1, transp - 0.05)
	cairo_pattern_add_color_stop_rgba(border_pat, 1, 1, 1, 1, transp)
	cairo_set_source(cr, border_pat)
	cairo_arc(cr, x, y, 10, 0, 2 * math.pi)
	cairo_set_line_width(cr, 3)
	cairo_fill(cr)

	cairo_move_to (cr, x, y);
	cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05)
	cairo_rel_line_to (cr, - 10, 27)
	cairo_rel_line_to (cr, - 270, 0)
	cairo_rel_line_to (cr, - 8, 8)
	cairo_rel_line_to (cr, 0, height)
	cairo_rel_line_to (cr, 8, 8)
	cairo_rel_line_to (cr, 270, 0)
	cairo_set_line_width (cr, 3);
	cairo_stroke (cr);

	cairo_move_to (cr, x - 275, y + 22)
	cairo_set_source_rgba(cr, 1, 1, 1, transp)
	cairo_set_font_size (cr, font_size);
	cairo_show_text (cr, str_conky)
end

function draw_rectangles(cr, start_place, current_date, x_start, y_start, number_of_days)
	cairo_select_font_face (cr, "LCD", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
	cairo_set_font_size (cr, 8);
	cairo_set_source_rgba(cr, 1, 1, 1, transp)
	cairo_set_line_width (cr, 2);
	count_row = tonumber(start_place)
	count_column = 1

	for i = 1, number_of_days do
		cairo_rectangle(cr, x_start + 65 + 28 * (count_row - 1), y_start + 85 + 20 * (count_column - 1), 13, 13)
		cairo_close_path(cr)

		if i == tonumber(current_date) then
			cairo_stroke(cr)
		else
			cairo_fill(cr)
		end

		if i <= 9 then
			cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1), y_start + 95 + 20 * (count_column - 1))
		elseif i > 9 and i <= 11 then
			if string.len(tostring(i)) == 1 then
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1), y_start + 95 + 20 * (count_column - 1))
			else
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1) - 2, y_start + 95 + 20 * (count_column - 1))
			end
		elseif i == 12 then
			if string.len(tostring(i)) == 1 then
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1) + 1, y_start + 95 + 20 * (count_column - 1))
			else
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1) - 2, y_start + 95 + 20 * (count_column - 1))
			end
		elseif i > 12 and i <= 14 then
			if string.len(tostring(i)) == 1 then
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1), y_start + 95 + 20 * (count_column - 1))
			else
				cairo_move_to(cr, x_start + 69 + 28 * (count_row - 1) - 2, y_start + 95 + 20 * (count_column - 1))
			end
		else
			cairo_move_to(cr, x_start + 67 + 28 * (count_row - 1), y_start + 95 + 20 * (count_column - 1))
		end

		if i == tonumber(current_date) then
			cairo_show_text(cr, tostring(i));
		else
			cairo_set_operator (cr, CAIRO_OPERATOR_CLEAR);
			cairo_show_text(cr, tostring(i));
		end
		cairo_set_operator (cr, CAIRO_OPERATOR_OVER);


		if count_row == 7 then
			count_row = 1
			count_column = count_column + 1
		else
			count_row = count_row + 1
		end

	end
end

function construct_date_table (cr, first_day_on_week, number_of_days, current_date, x_start, y_start)
	draw_rectangles(cr, first_day_on_week, current_date, x_start, y_start, number_of_days)
end


function battery_state (cr, start_x, start_y, conky_battery)
	cairo_set_line_width (cr, 2);
	cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05)

	local percent_per_block = 100.0 / 13.0
	local step = 0
	local number_of_charged_blocks = math.floor((conky_battery / percent_per_block) + 0.5)

	for i = 1, 13 do
		cairo_rectangle (cr, start_x + step, start_y, 10, 20);
		cairo_close_path(cr)
		if i <= number_of_charged_blocks then
			cairo_fill(cr)
		else
			cairo_stroke(cr)
		end
		step = step + 20
	end
end


function cpu_state(cr, start_x, start_y, conky_cpu)
	cairo_set_line_width (cr, 2);
	cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05)

	local percent_per_block = 100.0 / 13.0
	local step = 0
	local number_of_charged_blocks = math.floor((conky_cpu / percent_per_block) + 0.5)

	for i = 1, 13 do
		cairo_rectangle (cr, resolution_x - (start_x + step), start_y, 10, 20);
		cairo_close_path(cr)
		if i <= number_of_charged_blocks then
			cairo_fill(cr)
		else
			cairo_stroke(cr)
		end
		step = step + 20
	end
end

function draw_circles(cr, x_start, y_start, radius, angle_1, angle_2, free_perc, angle_step)
	local number_of_circles = 360 / angle_step
	local angle_start = 90

	local percent_per_circle = 100.0 / number_of_circles
	local number_of_nonfree_circles = math.floor(((100.0 - tonumber(free_perc)) / percent_per_circle) + 0.5)

	for i = 1, number_of_circles do
		cairo_arc(cr, x_start + (radius * math.cos(angle_start * (math.pi / 180.0))), y_start - (radius + 5) + radius - (radius * math.sin(angle_start * (math.pi / 180.0))), 4, angle1, angle2)
		if i <= number_of_nonfree_circles then
			cairo_fill(cr)
		else
			cairo_stroke(cr)
		end
		angle_start = angle_start - angle_step
	end

end

function draw_function(cr)
	local w, h = conky_window.width, conky_window.height
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)
	cairo_select_font_face (cr, "Dejavu Sans Condensed", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);

	-- Calendar ----------------------------------------------------------------------------------------------------------
	str = conky_parse("Calendar")
	draw_widget(cr, x_start, y_start, str, 16, 170)
	cairo_move_to (cr, x_start + 110, y_start + 50)
	cairo_set_source_rgba(cr, 1, 1, 1, transp)
	cairo_set_font_size (cr, 12);
	calendar = conky_parse("${execi 60 date '+%B %Y'}")
	cairo_show_text (cr, calendar)
	cairo_move_to (cr, x_start + 60, y_start + 75)
	cairo_set_font_size (cr, 8);
	cairo_show_text(cr, " Mon       Tue       Wed      Thu       Fri        Sat        Sun")
	cairo_close_path (cr)
	cairo_set_font_size (cr, 12);

	current_date = conky_parse("${execi 60 date +%d}");
	current_date = tonumber(current_date);

	if "Jan" == conky_parse("${execi 60 date '+%_b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Jan'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Feb" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Feb'}");
		construct_date_table (cr, first_day_on_week, 28, current_date, x_start, y_start);
	elseif "Mar" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Mar'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Apr" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Apr'}");
		construct_date_table (cr, first_day_on_week, 30, current_date, x_start, y_start);
	elseif "May" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 May'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Jun" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Jun'}");
		construct_date_table (cr, first_day_on_week, 30, current_date, x_start, y_start);
	elseif "Jul" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Jul'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Aug" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Aug'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Sep" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Sep'}");
		construct_date_table (cr, first_day_on_week, 30, current_date, x_start, y_start);
	elseif "Oct" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Oct'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	elseif "Nov" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Now'}");
		construct_date_table (cr, first_day_on_week, 30, current_date, x_start, y_start);
	elseif "Dec" == conky_parse("${execi 60 date '+%b'}") then
		first_day_on_week = conky_parse("${execi 60 date +%u -d '1 Dec'}");
		construct_date_table (cr, first_day_on_week, 31, current_date, x_start, y_start);
	end

	cairo_select_font_face (cr, "Dejavu Sans Condensed", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);

	-- Battery ----------------------------------------------------------------------------------------------------------

str = conky_parse("Battery: ${battery_percent " .. battery_dev .. "}%")
draw_widget(cr, x_start, y_start + 230, str, 16, 20)
percentage = conky_parse("${battery_percent BAT0}")
battery_state (cr, x_start + 20, y_start + 265, percentage)

-- Disk ----------------------------------------------------------------------------------------------------------

str = "Free space"
draw_widget(cr, x_start, y_start + 310, str, 16, 155);
cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05);

cairo_new_path (cr);
cairo_set_line_width (cr, 2.0);
angle1 = 0.0 * (math.pi / 180.0);
angle2 = 360.0 * (math.pi / 180.0);

free_hd1 = conky_parse("${fs_free_perc /}")
free_hd2 = conky_parse("${fs_free_perc /home}")

draw_circles(cr, x_start + 80, y_start + 425, 50, angle_1, angle_2, free_hd1, 15)
draw_circles(cr, x_start + 210, y_start + 425, 50, angle_1, angle_2, free_hd2, 15)

cairo_set_source_rgba(cr, 1, 1, 1, transp);
cairo_move_to (cr, x_start + 55, y_start + 425);
cairo_show_text(cr, "/ " .. 100 - free_hd1 .. "%")
cairo_move_to (cr, x_start + 185, y_start + 425);
cairo_show_text(cr, "H: " .. 100 - free_hd2 .. "%")

-- Internet ----------------------------------------------------------------------------------------------------------
str = "Internet"

draw_widget_m(cr, x_start, y_start, str, 16, 155);
cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05);

cairo_new_path (cr);
cairo_set_line_width (cr, 2.0);
angle1 = 0.0 * (math.pi / 180.0);
angle2 = 360.0 * (math.pi / 180.0);

upspeed = conky_parse("${upspeedf ".. interface .."}")
downspeed = conky_parse("${downspeedf ".. interface .."}")

--	if downspeed ~= nil then
--		if downspeed > 1 then
--			maxdown = downspeed
--		end
--	end
--
--	if
--	if(upspeed > maxdow) then
--		maxup = upspeed;
--	end

p_downspeed = downspeed / maxdown * 100
p_downspeed = 100 - math.floor(p_downspeed * 10 + 0.5 ) / 10

p_upspeed = upspeed / maxup * 100
p_upspeed = 100 - math.floor(p_upspeed * 10 + 0.5 ) / 10

draw_circles(cr, resolution_x - (x_start + 80), y_start + 120, 50, angle_1, angle_2, p_upspeed, 15)
draw_circles(cr, resolution_x - (x_start + 210), y_start + 120, 50, angle_1, angle_2, p_downspeed, 15)

cairo_set_source_rgba(cr, 1, 1, 1, transp);
cairo_move_to (cr, resolution_x - (x_start + 115), y_start + 120, 50);
cairo_show_text(cr, "U " .. upspeed .. "Kb/s")
cairo_move_to (cr, resolution_x - (x_start + 245), y_start + 120, 50);
cairo_show_text(cr, "D " .. downspeed .. "Kb/s")


-- Processor  ----------------------------------------------------------------------------------------------------------
percentage = conky_parse("${cpu 1}")
str = conky_parse("CPU: ${cpu 1}% Ram: ${memperc}%")
draw_widget_m(cr, x_start, y_start + 220, str, 16, 50)
cpu_state (cr, x_start + 20, y_start + 255, percentage)
cpu_state (cr, x_start + 20, y_start + 285, conky_parse("${memperc}"))
cairo_set_source_rgba(cr, 1, 1, 1, transp - 0.05);

-- Programs --------------------------------------------------------------------------------------------------------------
str = "Top CPU users"
draw_widget_m(cr, x_start, y_start + 330, str, 16, 85)

program_info = conky_parse("${top name 1}CPU${top cpu 1}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 375, 50);
cairo_show_text(cr, program_info)

program_info = conky_parse("${top name 2}CPU${top cpu 2}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 390, 50);
cairo_show_text(cr, program_info)

program_info = conky_parse("${top name 3}CPU${top cpu 3}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 405, 50);
cairo_show_text(cr, program_info)

program_info = conky_parse("${top name 4}CPU${top cpu 4}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 420, 50);
cairo_show_text(cr, program_info)

program_info = conky_parse("${top name 5}CPU${top cpu 5}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 435, 50);
cairo_show_text(cr, program_info)

program_info = conky_parse("${top name 6}CPU${top cpu 6}%")
cairo_move_to (cr, resolution_x - (x_start + 275), y_start + 450, 50);
cairo_show_text(cr, program_info)

-- Kernel version ----------------------------------------------------------------------------------------------------------
--kernel_v = conky_parse("Kernel ${kernel}")
--cairo_move_to (cr, resolution_x / 2 - 130, y_start, 60);
--cairo_show_text(cr, kernel_v)
end

function conky_start_widgets()
-- Check that Conky has been running for at least 5s

if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)

local cr = cairo_create(cs)

local updates = conky_parse('${updates}')
update_num = tonumber(updates)

if update_num > 5 then
	draw_function(cr)
end

cairo_surface_destroy(cs)
cairo_destroy(cr)
end
