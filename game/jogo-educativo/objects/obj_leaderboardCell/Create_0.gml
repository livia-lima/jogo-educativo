Nome = noone
Pontos = noone
depth = -350

draw_rank = function(){
	draw_set_font(PixelifySansTitleRelatorio)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	if (self.ranking == 1) draw_set_colour(c_yellow)
	else if (self.ranking == 2) draw_set_colour(c_silver)
	else if (self.ranking == 3) draw_set_colour(c_orange)
	else draw_set_colour(c_white)
	draw_text(x+70,y+sprite_height/2,string(self.ranking))

	draw_text(room_width/2+100,y+sprite_height/2,Nome + " " + "(" + string(Pontos)+ ")")
}