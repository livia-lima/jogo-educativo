// Ao entrar na sala, carregar os relatórios existentes, calcular
// numero de colunas e linhas, etc.

var files = 0;
var SEARCH = file_find_first("relatorios/*.txt",0);
// quantos arquivos existem no momento?
while SEARCH != ""
{
	files++;
	SEARCH = file_find_next()
}
file_find_close();

//show_debug_message("found: " + string(files));
self.buttons = files;
// quantos botões, linhas e colunas no total?
if (files > 1){
	self.cols = 2;
}
else if (files == 1){
	self.cols = 1;
}
else
	self.cols = 0;

self.rows = ceil(files/2)

menu = ds_grid_create(self.cols,self.rows);

load_menu_data = function()
{
	var SEARCH = file_find_first("relatorios/*.txt",0);
	var r = 0
	var c = 0
	// quantos arquivos existem no momento?
	while SEARCH != ""
	{
		var arrayToSave = array_create(2)
		arrayToSave[0] = SEARCH
		var string_parts = string_split(SEARCH,".")
		var nameFile = string_split(string_parts[0],"-");
		var nameSects = string_split(nameFile[0],"_")
		//show_debug_message(nameSects)
		var len = array_length(nameSects);
		var i = 0;
		var Name = noone
		for (i=0; i<len; i++){
			nameSects[i] = string_capitalize(nameSects[i])
			if (i > 0){
				Name = string_join(" ",Name,nameSects[i])
			}
			else{
				Name = nameSects[0];
			}
		}
		//show_debug_message(nameSects)
		if (nameFile[0] != array_last(nameFile)){
			// se este é um arquivo de um usuário com mais de 1 arquivo, salve o nome com o numero
			var numSTR = " ("+  array_last(nameFile) +")"
			Name = string_join(" ",Name,numSTR)
		}
		arrayToSave[1] = Name;
		menu[# c,r] = arrayToSave;
		c++;
		if (c > 1){
			r++;
			c = 0;
		}
		SEARCH = file_find_next()
	}
	file_find_close();
}

load_menu_data()

//show_debug_message( menu[# 0,0] + " " + menu[# 0,1] + " " + menu[# 1, 0])