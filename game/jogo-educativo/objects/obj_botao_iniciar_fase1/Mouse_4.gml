// Verifica se a variável do outro objeto não está vazia
if (obj_input_nome.nome_digitado != "") {
    
    // Nova partida: zera os dados do jogador anterior e salva o nome
    NovaPartida(string_trim(obj_input_nome.nome_digitado));
    
    // Limpa o teclado e avança de sala
    keyboard_string = "";
    room_goto(rm_fase1_explicacao);
}