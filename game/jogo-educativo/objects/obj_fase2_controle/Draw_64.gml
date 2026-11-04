draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_white);

// Botão sair (provisório)
draw_rectangle(10, 10, 80, 80, true);
draw_text(22, 36, "Sair");

var _t = floor((current_time - inicio_rodada) / 1000);
draw_text_transformed(120, 25, "Moedas: " + string(global.pontuacao), 2, 2, 0);
draw_text_transformed(480, 25, "Tempo: " + string(_t) + "s", 2, 2, 0);
draw_text_transformed(740, 25, "x" + string(multiplicador), 2, 2, 0);
draw_text_transformed(900, 25, "Rodada " + string(global.rodada_rounds_fase2) + "/" + string(global.total_rounds_fase2), 2, 2, 0);

// Pergunta
draw_set_halign(fa_center);
draw_text_transformed(570, 85, "Quantas bicicletas tem na tela?", 2, 2, 0);

// Molduras provisórias
draw_rectangle(area_x1, area_y1, area_x2, area_y2, true);
draw_rectangle(1130, 120, 1330, 740, true);

// Feedback
if (feedback_texto != "") {
    draw_set_colour(feedback_cor);
    draw_text_transformed(570, 700, feedback_texto, 2.5, 2.5, 0);
}
draw_set_colour(c_white);
draw_set_halign(fa_left);