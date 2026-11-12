#region menu data
depth = -10
page = 0;
cell_width = 128
cell_height = 64
cols = 1;
rows = 12;
menu_y = 0;
edge = 20
menu_y_max = rows*cell_height + edge*5 - room_height/2;


surface = noone
surf_w = cell_width*5 + edge*6
surf_h = cell_height*7.5
surf_x = room_width/2-surf_w/2
surf_y = 240

surf2_w = 196*2 + 80*4
surf2_h = 544
surf2_x = room_width/2-surf2_w*0.50
surf2_y = 200

// strutura

#endregion

#region drawing

// desenho
draw_menu = function()
{
	for (var i = 0; i<6 ; i++)
	{
		var _x1 = edge*1.5
		var _y1 = menu_y + edge*1.5 + i * cell_height + edge*i/2
		var _x2 = _x1 + cell_width/2
		var _y2 = _y1 + cell_height
		//draw_rectangle(_x1,_y1,_x2,_y2,true)
		draw_set_font(PixelifySansRelatorio)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_left)
		draw_set_colour(c_black)
		draw_text(_x1,_y1+cell_height/3 +3,menu[# 0, i+2+page*6])
		draw_set_colour(c_yellow)
		draw_text(_x1,_y1+cell_height/3,menu[# 0, i+2+page*6])
	}
}

// surface
draw_menu_surface = function()
{
	if (surface_exists(surface))
	{	
		draw_set_font(PixelifySansTitleRelatorio)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_colour(c_white)
		var _edge = 16
		draw_text( (surf_x) + surf_w/2+_edge*0.5, surf_y - _edge*6 + 1,global.alvoDeLeitura[1])
		draw_set_colour(c_black)
		draw_text( (surf_x) + surf_w/2+_edge*0.5, surf_y - _edge*6,global.alvoDeLeitura[1])
		//draw_sprite_stretched(relatorioFrame,0,surf2_x-_edge,surf2_y-_edge,surf2_w+_edge*2,surf2_h+_edge*3)

		// menu frame
		//draw_sprite_stretched(menuRelatorioSprite,0,surf2_x-_edge*0.5,surf2_y-_edge*2,surf2_w+_edge*1,surf2_h+_edge*2)
		surface_set_target(surface)
		//limpa
		draw_clear_alpha(c_black,0)
		//draw_rectangle_colour(0,0,surf_w,surf_h,c_white,c_white,c_white,c_white,false)
		draw_menu()
		
		surface_reset_target();
		
		draw_surface(surface,surf_x,surf_y)
		
		// inner menu frame
		//draw_sprite_stretched(relatorioFrame,0,surf_x-_edge,surf_y-_edge,surf_w+_edge*2,surf_h+_edge*2)
	}
	else
	{
		surface = surface_create(surf_w,surf_h)
		//bigSurface = surface_create(surf2_w,surf2_h)
	}
}


#endregion
