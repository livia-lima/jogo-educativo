/// Atualiza pontuação e cronômetro da Fase 1

if (variable_global_exists("pontuacao")) {
    pontos_exibidos = global.pontuacao;
}

// O relógio para quando a fase termina (ou quando vai para a tela de falha)
var _parado = instance_exists(obj_controlador_fase1)
    && (obj_controlador_fase1.fase_concluida || obj_controlador_fase1.indo_para_falha);

if (!_parado) {
    tempo_exibido = (current_time - inicio_fase) / 1000;
}
