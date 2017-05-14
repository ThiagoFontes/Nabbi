require 'cairo'

function draw_widget(cr, x, y, str_conky, font_size, height, width, transp)
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
	cairo_rel_line_to (cr, width, 0)
	cairo_rel_line_to (cr, 8, 8)
	cairo_rel_line_to (cr, 0, height)
	cairo_rel_line_to (cr, - 8, 8)
	cairo_rel_line_to (cr, - width, 0)
	cairo_set_line_width (cr, 3);
	cairo_stroke (cr);

	cairo_move_to (cr, x + 15, y + 22)
	cairo_set_source_rgba(cr, 1, 1, 1, transp)
	cairo_set_font_size (cr, font_size);
	cairo_show_text (cr, str_conky)
end


function conky_start_widgets()
	-- Check that Conky has been running for at least 5s

	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)

	local cr = cairo_create(cs)

	local updates = conky_parse('${updates}')
	update_num = tonumber(updates)

	if update_num > 5 then
		draw_widget(cr, 20, 550, "Module test", 16, 100, 270, 0.7)
	end

	cairo_surface_destroy(cs)
	cairo_destroy(cr)
end
