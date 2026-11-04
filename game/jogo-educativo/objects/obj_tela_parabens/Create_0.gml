/// @description Tela 12 — Parabéns (vitória)
// "Parabéns! Sua pontuação foi: …" + botões "Ver ranking" e "Voltar ao menu".
// Legendas, dublagem e animações seguem o mesmo relógio (tempo, em ms).

tempo = 0;
pontos_final     = variable_global_exists("pontuacao") ? global.pontuacao : 0;
pontos_mostrados = 0;
var _nome = (variable_global_exists("nome_aluno") && global.nome_aluno != "") ? global.nome_aluno : "";
titulo = (_nome != "") ? "Parabéns, " + _nome + "!" : "Parabéns!";

// Linha do tempo (ms): cada animação começa junto com a legenda correspondente
t_titulo         = 300;   // título entra pulando + voz "Parabéns"
t_contagem_ini   = 2600;  // placar sobe de 0 até a pontuação final
t_contagem_fim   = 4600;
t_botoes         = 6000;  // botões aparecem

cues = [
	legenda(t_titulo,       t_contagem_ini, titulo, "snd_voz_parabens"),
	legenda(t_contagem_ini, t_botoes,       "Sua pontuação foi: " + string(pontos_final) + " pontos!"),
	legenda(t_botoes,       t_botoes + 4000, "Toque em \"Ver ranking\" ou em \"Voltar ao menu\"."),
];
cue_atual = -1;
voz_atual = -1;

// Botões (sprites com origem no centro)
botoes = [
	{ spr: spr_botao_ver_ranking, x: room_width / 2 - 240, y: 400, voz: "snd_voz_ranking",     sala: rm_leaderboard,  sobre: false },
	{ spr: spr_botao_voltar_menu, x: room_width / 2 + 240, y: 400, voz: "snd_voz_voltar_menu", sala: rm_start_screen, sobre: false },
];

// Confetes
var _cores = [COR_VERDE, COR_AMARELO, COR_LARANJA, COR_VERMELHO, COR_VERDE_CLARO, c_white];
confetes = [];
for (var _i = 0; _i < 90; _i++) {
	array_push(confetes, {
		x:   random(room_width),
		y:   -random(room_height),
		vx:  random_range(-40, 40),
		vy:  random_range(90, 200),
		ang: random(360),
		va:  random_range(-240, 240),
		w:   random_range(8, 16),
		h:   random_range(5, 10),
		cor: _cores[irandom(array_length(_cores) - 1)],
	});
}

parar_voz = function() {
	if (voz_atual != -1 && audio_is_playing(voz_atual)) audio_stop_sound(voz_atual);
	voz_atual = -1;
};

ir_para = function(_sala) {
	parar_voz();
	room_goto(_sala);
};
