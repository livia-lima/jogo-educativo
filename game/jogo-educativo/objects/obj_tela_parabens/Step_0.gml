/// @description Relógio, legendas/voz, placar, confetes e botões
var _dt = delta_time / 1000000;
tempo += delta_time / 1000;

// Voz sincronizada com as animações
var _i = legenda_indice(cues, tempo);
if (_i != cue_atual) {
	cue_atual = _i;
	if (_i != -1 && !cues[_i].tocada) {
		cues[_i].tocada = true;
		if (cues[_i].voz != "") {
			parar_voz();
			voz_atual = tocar_voz(cues[_i].voz);
		}
	}
}

// Placar contando de 0 até a pontuação final
pontos_mostrados = round(pontos_final * suavizar(progresso(tempo, t_contagem_ini, t_contagem_fim)));

// Confetes caindo (voltam para o topo)
for (var _c = 0; _c < array_length(confetes); _c++) {
	var _p = confetes[_c];
	_p.x += (_p.vx + sin((tempo / 1000) * 3 + _c) * 30) * _dt;
	_p.y += _p.vy * _dt;
	_p.ang += _p.va * _dt;
	if (_p.y > room_height + 20) {
		_p.y = -20;
		_p.x = random(room_width);
	}
}

// Botões: voz ao passar o mouse/dedo e clique para navegar
if (tempo >= t_botoes) {
	for (var _b = 0; _b < array_length(botoes); _b++) {
		var _bt = botoes[_b];
		var _w = sprite_get_width(_bt.spr) * escala_botao, _h = sprite_get_height(_bt.spr) * escala_botao;
		var _sobre = mouse_sobre(_bt.x, _bt.y, _w, _h);
		if (_sobre && !_bt.sobre) {
			parar_voz();
			voz_atual = tocar_voz(_bt.voz);
		}
		_bt.sobre = _sobre;
		if (_sobre && mouse_check_button_pressed(mb_left)) {
			ir_para(_bt.sala);
			exit;
		}
	}
	if (keyboard_check_pressed(vk_enter)) ir_para(rm_leaderboard);
	if (keyboard_check_pressed(vk_escape)) ir_para(rm_start_screen);
}
