global.rodada_rounds_fase2++;
if (global.rodada_rounds_fase2 > global.total_rounds_fase2) {
    room_goto(rm_parabens);
} else {
    nova_rodada();
}