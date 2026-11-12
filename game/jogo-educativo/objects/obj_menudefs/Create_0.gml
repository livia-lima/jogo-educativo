#region info
cell_width = 196
cell_height = 96
cols = 2;
rows = 14;
inv_y = 0;
edge = 30
inv_y_max = rows*cell_height + edge*rows + edge - room_height;

surface = noone
surf_w = cell_width*cols + edge*cols + edge
surf_h = 544
surf_x = room_width/2-surf_w/2
surf_y = 200

// strutura

menu = ds_grid_create(cols,rows);

ds_grid_clear(menu,0)

#endregion

#region draw

// desenho
draw_menu = function()
{
		// scroll
	if (mouse_wheel_down()) inv_y -= 32;
	if (mouse_wheel_up()) inv_y += 32;

	inv_y = clamp(inv_y,-inv_y_max,0)
	for (var i = 0; i<rows; i++)
	{
		for (var j = 0; j<cols;j++)
		{
			var _x1 = edge + j * cell_width + edge*j
			var _y1 = inv_y + edge + i * cell_height + edge*i
			var _x2 = _x1 + cell_width
			var _y2 = _y1 + cell_height
			draw_rectangle(_x1,_y1,_x2,_y2,true)
		}
	}
}

// surface
draw_menu_surface = function()
{
	if (surface_exists(surface))
	{
		surface_set_target(surface)
		//limpa
		draw_clear_alpha(c_black,0)
		draw_menu()
		
		surface_reset_target();
		
		draw_surface(surface,surf_x,surf_y)
	}
	else
	{
		surface = surface_create(surf_w,surf_h)
	}
}


#endregion
