// Ao entrar na sala, carregar os relatórios existentes, calcular
// numero de colunas e linhas, etc.
readTarget = global.alvoDeLeitura
//show_debug_message("Search: " + readTarget[0])
_FILE = file_text_open_read("relatorios/" + readTarget[0])
if (_FILE == -1){
	show_debug_message("Erro, arquivo inexistente.")
	room_goto(rm_relatorio)
}

menu = ds_grid_create(2,14);

var i = 0
file_text_readln(_FILE)
menu[# 1, 0] = readTarget[1]
menu[# 0, 0] = "Nome: "
menu[# 0, 1] = "Pontos: "

//menu[# 0, 0] = "Conseguiu associar todos os objetos com seus nomes: "
menu[# 0, 2] = "Completou fase 1: "
menu[# 0, 3] = "Qtd de acertos (1a fase): "
menu[# 0, 4] = "Qtd de erros (1a fase): "
menu[# 0, 5] = "Tempo entre acertos (1a fase): "
menu[# 0, 6] = "Tempo gasto (1a fase): "
menu[# 0, 7] = "Tentativas (1a fase): "
//menu[# 0, 5] = "Conseguiu associar os objetos com suas quantidades: "
menu[# 0, 8] = "Completou fase 2: "
menu[# 0, 9] = "Qtd de acertos (2a fase): "
menu[# 0, 10] = "Qtd de erros (2a fase): "
menu[# 0, 11] = "Tempo entre acertos (2a fase): "
menu[# 0, 12] = "Tempo gasto (2a fase): "
menu[# 0, 13] = "Tentativas (2a fase): "

for (i=1;i<14;i++){
	if (file_text_eof(_FILE)) {
		// arquivo corrompido ou fora do padrão? retornar.
		room_goto(rm_relatorio)
	}
	var newStr = file_text_readln(_FILE)
	var StrParts = string_split(newStr," ",true,1)
	if (StrParts[0] = array_last(StrParts)) room_goto(rm_relatorio)
	var finalStr = string_split(array_last(StrParts),"\n")
	menu[# 1,i] = finalStr[0]
	if (i == 2 or i == 8){
		var result = noone
		if (real(finalStr[0]) == 1){
			result = "Sim"
		}
		else{ 
			result = "Não"
		}
		menu[# 0,i] = string_join(" ",menu[# 0,i],result)
	}
	else menu[# 0,i] = string_join(" ",menu[# 0,i],finalStr[0])
}

