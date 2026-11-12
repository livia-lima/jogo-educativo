#region menu data
cell_width = 196
cell_height = 64
/*cols = 2;
rows = 14;*/
inv_y = 0;
edge = 80
fix1 = 20
inv_y_max = self.rows*cell_height + edge*6 - room_height/3;

surface = noone
surf_w = 196*2 + edge*4 + 50
surf_h = 464
surf_x = room_width/2 -surf_w/2 + 10
surf_y = room_height/2 -surf_h/3 + 10

// strutura
#endregion

#region drawing

// desenho
draw_menu = function()
{
		// scroll
	if (mouse_wheel_down()) inv_y -= 32;
	if (mouse_wheel_up()) inv_y += 32;
	var buttonsDrawn = 0
	inv_y = clamp(inv_y,-inv_y_max,0)
	for (var i = 0; i<self.rows and buttonsDrawn < self.buttons; i++)
	{
		for (var j = 0; j<self.cols and buttonsDrawn < self.buttons;j++)
		{
			var _x1 = 4 + j * cell_width + edge*j*3
			var _y1 = inv_y + edge/4 + i * cell_height + edge*i/4
	
			var _x2 = _x1 + cell_width + edge*1.5 //2*fix1*j
			var _y2 = _y1 + cell_height 
			//draw_rectangle(_x1,_y1,_x2,_y2,true)
			
			var curArray = menu[# j,i]
			// checking if u can click button :)
			var _mouse_in_menu = point_in_rectangle(mouse_x,mouse_y,surf_x,surf_y,surf_x+surf_w,surf_y+surf_h)
			if (_mouse_in_menu){
				var _mouse_in_button = point_in_rectangle(mouse_x- surf_x,mouse_y - surf_y,_x1,_y1,_x2,_y2)
				if (_mouse_in_button and mouse_check_button_released(mb_left)){ // el button foi clicado!!!!
					global.alvoDeLeitura = curArray;
					room_goto(rm_submenu_relatorio)
				}
			}
			//show_debug_message(Name)
			draw_sprite_stretched(spr_botaoRelatorio,0,_x1-8,_y1-6,cell_width+150,cell_height+12)
			draw_set_font(PixelifySansRelatorio)
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_colour(c_yellow)
			draw_text(_x1+(cell_width+150)/2,_y1+cell_height/2,curArray[1])
			buttonsDrawn++;
		}
	}
}

// surface
draw_menu_surface = function()
{
	if (surface_exists(surface))
	{
	
		var _edge = 64
		// menu frame
		//draw_sprite_stretched(menuRelatorioSprite,0,surf_x-_edge*0.5,surf_y-_edge*2,surf_w+_edge*1,surf_h+_edge*2)
		surface_set_target(surface)
		//limpa
		draw_clear_alpha(c_black,0)

		//draw_rectangle_colour(0,0,surf_w,surf_h,c_white,c_white,c_white,c_white,false)
		draw_menu()
		
		surface_reset_target();
	
		draw_set_font(PixelifySansTitleRelatorio)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_colour(c_white)
		var _edge2 = 16
		draw_text( (surf_x) + surf_w/2, surf_y - _edge2*5 + 1,"Relatórios")
		draw_set_colour(c_black)
		draw_text( (surf_x) + surf_w/2, surf_y - _edge2*5,"Relatórios")
		
		draw_surface(surface,surf_x,surf_y)
		
	}
	else
	{
		surface = surface_create(surf_w,surf_h)
	}
}


#endregion
