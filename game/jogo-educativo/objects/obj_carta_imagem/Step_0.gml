
/// obj_carta_imagem - STEP
/// Arrastar imagens e validar associacoes.

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

if (!arrastando && mouse_check_button_pressed(mb_left)) {

    var _area_w = room_width * 0.17;
    var _area_h = room_height * 0.15;

    var _dentro = point_in_rectangle(
        mouse_x,
        mouse_y,
        x - _area_w / 2,
        y - _area_h / 2,
        x + _area_w / 2,
        y + _area_h / 2
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
// 4. SOLTAR IMAGEM
// =====================================

arrastando = false;

var _alvo = noone;
var _menor_distancia = 1000000;

var _quantidade = instance_number(obj_carta_palavra);

for (var i = 0; i < _quantidade; i++) {

    var _palavra = instance_find(obj_carta_palavra, i);

    if (!instance_exists(_palavra)) {
        continue;
    }

    if (_palavra.associada) {
        continue;
    }

    var _w = room_width * 0.39;
    var _h = room_height * 0.105;

    var _dentro_palavra = point_in_rectangle(
        mouse_x,
        mouse_y,
        _palavra.x - _w / 2,
        _palavra.y - _h / 2,
        _palavra.x + _w / 2,
        _palavra.y + _h / 2
    );

    if (_dentro_palavra) {

        var _distancia = point_distance(
            mouse_x,
            mouse_y,
            _palavra.x,
            _palavra.y
        );

        if (_distancia < _menor_distancia) {

            _menor_distancia = _distancia;
            _alvo = _palavra;
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
        item_id,
        _alvo.item_id
    );

    if (_correto) {

        associada = true;
        _alvo.associada = true;

        acerto_frames = 30;
        _alvo.acerto_frames = 30;

        x = posicao_inicial_x;
        y = posicao_inicial_y;

        show_debug_message(
            "ACERTO COM IMAGEM: " + item_id
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
            "ASSOCIACAO INCORRETA: " + item_id
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
