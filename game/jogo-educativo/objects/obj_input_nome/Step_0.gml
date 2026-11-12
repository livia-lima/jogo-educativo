
/// INPUT DO NOME - STEP

if (selecionado) {

    // =====================================
    // 1. LIMITAR QUANTIDADE DE LETRAS
    // =====================================

    if (string_length(keyboard_string) > limite_letras) {
        keyboard_string = string_copy(
            keyboard_string,
            1,
            limite_letras
        );
    }

    // Atualiza o nome digitado
    nome_digitado = keyboard_string;

    // =====================================
    // 2. CURSOR PISCANDO
    // =====================================

    alarme_cursor -= 1;

    if (alarme_cursor <= 0) {
        cursor_pisca = !cursor_pisca;
        alarme_cursor = 30;
    }

    // =====================================
    // 3. CONFIRMACAO COM ENTER
    // =====================================

    if (keyboard_check_pressed(vk_enter)) {

        // Remove espacos no inicio e no fim
        var _nome_validado = string_trim(nome_digitado);

        // Somente avanca se houver um nome valido
        if (string_length(_nome_validado) > 0) {

            nome_digitado = _nome_validado;

            // Salva o nome do aluno
            global.nome_aluno = _nome_validado;

            // Avanca para a explicacao da Fase 1
            room_goto(rm_fase1_explicacao);
        }
    }
}
