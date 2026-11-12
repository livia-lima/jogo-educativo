
/// obj_carta_palavra - STEP
/// Arrastar palavras e validar associacoes.

// =====================================
// 1. FEEDBACK VISUAL
// =====================================

if (instance_exists(obj_popup_dicas_fase1)) {
    exit;
}

if (acerto_frames > 0) {
    acerto_frames--;

    if (acerto_frames == 0) {
        visible = false;
    }
}

if (erro_frames > 0) {
    erro_frames--;
}

if (associada) {
    exit;
}

// =====================================
// 2. DETECTAR CLIQUE
// =====================================

var _largura = room_width * 0.39;
var _altura = room_height * 0.105;

if (!arrastando && mouse_check_button_pressed(mb_left)) {

    var _dentro = point_in_rectangle(
        mouse_x,
        mouse_y,
        x - _largura / 2,
        y - _altura / 2,
        x + _largura / 2,
        y + _altura / 2
    );

    if (_dentro) {

        arrastando = true;
        erro_frames = 0;

        deslocamento_x = x - mouse_x;
        deslocamento_y = y - mouse_y;
    }
}

if (!arrastando) {
    exit;
}

// =====================================
// 3. MOVIMENTAR
// =====================================

if (mouse_check_button(mb_left)) {

    x = mouse_x + deslocamento_x;
    y = mouse_y + deslocamento_y;

    exit;
}

// =====================================
// 4. SOLTAR PALAVRA
// =====================================

arrastando = false;

var _alvo = noone;
var _menor_distancia = 1000000;

var _limite_x = room_width * 0.10;
var _limite_y = room_height * 0.08;

var _quantidade = instance_number(obj_carta_imagem);

for (var i = 0; i < _quantidade; i++) {

    var _img = instance_find(obj_carta_imagem, i);

    if (!instance_exists(_img)) {
        continue;
    }

    if (_img.associada) {
        continue;
    }

    var _dx = abs(mouse_x - _img.x);
    var _dy = abs(mouse_y - _img.y);

    if (_dx <= _limite_x && _dy <= _limite_y) {

        var _distancia = point_distance(
            mouse_x,
            mouse_y,
            _img.x,
            _img.y
        );

        if (_distancia < _menor_distancia) {
            _menor_distancia = _distancia;
            _alvo = _img;
        }
    }
}

// =====================================
// 5. VALIDAR
// =====================================

if (
    instance_exists(_alvo)
    && instance_exists(controlador)
) {

    var _correto = controlador.validar_associacao(
        _alvo.item_id,
        item_id
    );

    if (_correto) {

        associada = true;
        _alvo.associada = true;

        acerto_frames = 30;
        _alvo.acerto_frames = 30;

        x = posicao_inicial_x;
        y = posicao_inicial_y;

        show_debug_message(
            "ACERTO COM PALAVRA: " + texto
        );

        if (controlador.rodada_concluida) {

            with (controlador) {
                alarm[0] = 48;
            }
        }

    } else {

        erro_frames = 22;
        _alvo.erro_frames = 22;

        // =================================
        // TODO: INTEGRACAO COM PONTUACAO
        // =================================

        // Registrar tentativa incorreta
        // quando o sistema estiver integrado:
        //
        // Errou();
        //
        // Antes, verificar com a equipe
        // a regra de limite de erros.

        show_debug_message(
            "ASSOCIACAO INCORRETA: " + texto
        );
    }
}

// =====================================
// 6. RETORNAR AO LUGAR
// =====================================

if (!associada) {

    x = posicao_inicial_x;
    y = posicao_inicial_y;
}
