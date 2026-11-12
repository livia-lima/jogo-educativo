// HUD da Fase 1: mostra a pontuação (global.pontuacao, do ScoreScript)
// e o tempo da tentativa, contando a partir do início da fase.
pontos_exibidos = variable_global_exists("pontuacao") ? global.pontuacao : 0;
inicio_fase = current_time;
tempo_exibido = 0;
