/// @description Fase 2 - Contagem (Yasmin)

// --- Segurança: se rodar a fase sozinha pra testar, cria as globais ---
if (!variable_global_exists("total_rounds_fase2")) global.total_rounds_fase2 = 3;

// --- Pontuação, tempo e erros da tentativa (ScoreScript, regra do Vitor) ---
// Acerto: +50 x multiplicador (global.mult). Erro: multiplicador volta pra 1x.
// Limite de erros para a tela de falha: global.errosParaFimDeFase.
FaseTimeStart(2);

// --- Estado da fase ---
global.rodada_rounds_fase2 = 1;
global.tempos_reacao_fase2 = [];   // segundos de cada resposta

resposta = 0;        // quantos objetos tem na tela
contagem = 0;        // quantos o aluno já "contou" passando o mouse
bloqueado = false;   // trava cliques durante o feedback
chegou_no_limite = false; // Errou() avisa quando a tentativa chegou no limite de erros
feedback_texto = "";
feedback_cor = c_white;
inicio_rodada = current_time;

// Área onde os objetos aparecem (dentro do quadro grande)
area_x1 = 144; area_y1 = 238;
area_x2 = 1006; area_y2 = 687;

// Centro das 4 casinhas da coluna da direita (botao_frame_answer)
botao_x = 1167;
botao_y = [242, 377, 509, 647];

// Fonte pixel (PressStart2P, dos Included Files). Se não achar, usa a padrão.
if (!variable_global_exists("fonte_pixel")) {
    global.fonte_pixel = -1;
    var _arq = "fonts/PressStart2P.ttf";
    if (file_exists(_arq)) global.fonte_pixel = font_add(_arq, 16, false, false, 32, 255);
}
fonte_f2 = global.fonte_pixel;

// --- Objetos que podem aparecer (sprite + pergunta) ---
objetos = [
    { spr: "sprite_bicicleta",            som: "bicicleta",           pergunta: "Quantas bicicletas tem na tela?" },
    { spr: "sprite_carro",                som: "carro",               pergunta: "Quantos carros tem na tela?" },
    { spr: "sprite_ecobag",               som: "sacolareutilizavel",  pergunta: "Quantas sacolas reutilizáveis tem na tela?" },
    { spr: "sprite_garrafa",              som: "garrafapl_stica",     pergunta: "Quantas garrafas plásticas tem na tela?" },
    { spr: "sprite_garrafa_reutilizavel", som: "garrafareutiliz_vel", pergunta: "Quantas garrafas reutilizáveis tem na tela?" },
    { spr: "sprite_moeda",                som: "",                    pergunta: "Quantas moedas tem na tela?" },
    { spr: "sprite_sacola",               som: "sacolapl_stica",      pergunta: "Quantas sacolas tem na tela?" }
];
objeto_atual = objetos[0];

// --- Áudios de voz (tocam quando o mouse passa em cima) ---
numeros_som = ["um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove"];
voz_atual = -1;
hover_pergunta = false;
hover_dica = false;
hover_voltar = false;

// Fala um áudio, parando a fala anterior pra não embolar
falar = function(_nome) {
    var _s = asset_get_index(_nome);
    if (_s == -1 || !audio_exists(_s)) return;
    if (voz_atual != -1) audio_stop_sound(voz_atual);
    voz_atual = audio_play_sound(_s, 1, false);
};

// --- Toca um som só se ele existir no projeto ---
tocar_som = function(_nome) {
    var _s = asset_get_index(_nome);
    if (_s != -1 && audio_exists(_s)) audio_play_sound(_s, 1, false);
};

// --- Monta uma rodada nova ---
nova_rodada = function() {
    with (obj_fase2_item)  instance_destroy();
    with (obj_fase2_botao) instance_destroy();

    // Sorteia a quantidade
    resposta = irandom_range(1, 9);
    contagem = 0;
    feedback_texto = "";

    // Sorteia o objeto (diferente do anterior)
    var _anterior = objeto_atual;
    do {
        objeto_atual = objetos[irandom(array_length(objetos) - 1)];
    } until (objeto_atual != _anterior);
    var _spr = asset_get_index(objeto_atual.spr);

    // Objetos sem ficar um em cima do outro
    var _pos = [];
    var _dist    = (resposta > 5) ? 125 : 150;   // de 6 a 9: objetos menores
    var _tamanho = (resposta > 5) ? 105 : 140;
    for (var i = 0; i < resposta; i++) {
        var _x, _y, _ok, _tent = 0;
        do {
            _x = irandom_range(area_x1 + _tamanho/2 + 5, area_x2 - _tamanho/2 - 5);
            _y = irandom_range(area_y1 + _tamanho/2 + 5, area_y2 - _tamanho/2 - 5);
            _ok = true;
            for (var j = 0; j < array_length(_pos); j++) {
                if (point_distance(_x, _y, _pos[j][0], _pos[j][1]) < _dist) { _ok = false; break; }
            }
            _tent++;
        } until (_ok || _tent > 300);
        array_push(_pos, [_x, _y]);
        var _item = instance_create_layer(_x, _y, "Instances", obj_fase2_item);
        if (_spr != -1) {
            _item.sprite_index = _spr;
            _item.escala_base = _tamanho / max(sprite_get_width(_spr), sprite_get_height(_spr));
        }
    }

    // 4 botões: o número certo + 3 errados, embaralhados
    var _opcoes = [resposta];
    while (array_length(_opcoes) < 4) {
        var _n = irandom_range(1, 9);
        if (!array_contains(_opcoes, _n)) array_push(_opcoes, _n);
    }
    _opcoes = array_shuffle(_opcoes);
    for (var k = 0; k < 4; k++) {
        var _b = instance_create_layer(botao_x, botao_y[k], "Instances", obj_fase2_botao);
        _b.valor = _opcoes[k];
    }

    inicio_rodada = current_time;
    bloqueado = false;
};

// --- Chamado quando o aluno clica num número ---
verificar = function(_valor) {
    if (bloqueado) return;
    bloqueado = true;

    var _tempo = (current_time - inicio_rodada) / 1000;
    array_push(global.tempos_reacao_fase2, _tempo);

    var _fps = game_get_speed(gamespeed_fps);

    if (_valor == resposta) {
        Pontuou();
        feedback_texto = "Muito bem! São " + string(resposta) + "!";
        feedback_cor = c_lime;
        falar("snd_voz_acertou");
        alarm[0] = _fps * 1.5;   // próxima rodada
    } else {
        chegou_no_limite = Errou();
        falar("snd_voz_errou");
        feedback_texto = "Quase! Vamos contar de novo.";
        feedback_cor = c_orange;
        alarm[1] = _fps * 1.5;   // tenta de novo ou vai pra falha
    }
};

nova_rodada();
