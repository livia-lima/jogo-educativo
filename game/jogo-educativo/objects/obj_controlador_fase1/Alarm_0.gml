
/// obj_controlador_frase1 - ALARM 0
/// Avanca a rodada ou inicia a Fase 2 automaticamente.

// =====================================
// 1. VERIFICAR CONCLUSAO
// =====================================

if (!rodada_concluida || fase_concluida) {
    exit;
}

// =====================================
// 2. AVANCAR A RODADA
// =====================================

// Se ainda existem rodadas, cria os novos
// cartoes normalmente.
//
// Se terminou a terceira rodada,
// avancar_rodada() marca fase_concluida = true.

avancar_rodada();

// =====================================
// 3. TRANSICAO PARA A FASE 2
// =====================================

if (fase_concluida) {

    show_debug_message(
        "Fase 1 concluida! Iniciando Fase 2..."
    );

    // Procura a proxima sala na ordem do jogo.
    var _proxima_sala = room_next(room);

    if (_proxima_sala != -1) {

        // Inicia automaticamente a proxima fase.
        room_goto(_proxima_sala);

    } else {

        show_debug_message(
            "AVISO: proxima sala nao encontrada."
        );
    }
}
