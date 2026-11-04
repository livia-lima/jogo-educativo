if (global.erros_fase2 >= max_erros) {
    room_goto(rm_fase2_falha);
} else {
    feedback_texto = "";
    inicio_rodada = current_time;
    bloqueado = false;
}