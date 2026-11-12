// HUD da Fase 2 (as imagens ficam na camada tela_fase2 da room)
var _s = (fonte_f2 != -1) ? 1 : 2;   // fonte padrão é pequena, então aumenta
if (fonte_f2 != -1) draw_set_font(fonte_f2);

draw_set_valign(fa_middle);
draw_set_halign(fa_left);

// Moedas (ao lado da sprite_moeda)
var _t = floor((current_time - inicio_rodada) / 1000);
draw_set_colour(c_black);
draw_text_transformed(362, 45, string(global.pontuacao), _s * 1.5, _s * 1.5, 0);
draw_set_colour(c_white);
draw_text_transformed(360, 43, string(global.pontuacao), _s * 1.5, _s * 1.5, 0);

// Tempo (ao lado da sprite_timer)
var _txt_t = string(_t div 60) + ":" + string_replace_all(string_format(_t mod 60, 2, 0), " ", "0");
draw_set_colour(c_black);
draw_text_transformed(812, 45, _txt_t, _s * 1.5, _s * 1.5, 0);
draw_set_colour(c_white);
draw_text_transformed(810, 43, _txt_t, _s * 1.5, _s * 1.5, 0);

// Multiplicador e rodada
draw_set_halign(fa_right);
draw_set_colour(c_yellow);
draw_text_transformed(1270, 43, "x" + string(multiplicador) + "  " + string(global.rodada_rounds_fase2) + "/" + string(global.total_rounds_fase2), _s, _s, 0);

// Pergunta (dentro do quadro, em cima)
draw_set_halign(fa_center);
draw_set_colour(c_white);
draw_text_transformed(560, 150, objeto_atual.pergunta, _s, _s, 0);

// Feedback
if (feedback_texto != "") {
    draw_set_colour(feedback_cor);
    draw_text_transformed(560, 690, feedback_texto, _s * 1.2, _s * 1.2, 0);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
