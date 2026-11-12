// Verifica se a variável do outro objeto não está vazia
if (obj_input_nome.nome_digitado != "") {
    
    // Guarda o nome na sua base de dados global
    global.nome_aluno = obj_input_nome.nome_digitado;
    
    // Limpa o teclado e avança de sala
    keyboard_string = "";
    room_goto(rm_fase1_gameplay);
}