
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
        "Fase 1 concluida! Indo para a explicacao da Fase 2..."
    );

    // Vai direto para a explicacao da Fase 2. Nao usar room_next():
    // ele segue a ordem das rooms do projeto, que nao e a ordem do jogo
    // (a sala seguinte a rm_fase1_gameplay era rm_relatorio).
    room_goto(rm_fase2_explicacao);
}
