
function string_capitalize(str) {
    return string_upper(string_char_at(str, 1)) + string_copy(str, 2, string_length(str) - 1);
}

if (!directory_exists("relatorios"))
{
	directory_create("relatorios");
}

function ArraySaveConvert(array)
{
	len = array_length(array)
	endText = string(array[0])
	i = 1;
	for (i=1;i<len;i++)
	{
		endText = string_join(",",endText,array[i]);
	}
	return endText
}

function saveResultados()
{
	i = 1;
	if (file_exists("relatorios/"+global.nome_aluno+".txt"))
	{
		i++;
		canSave = false;
		while (not canSave)
		{
			if (file_exists("relatorios/"+global.nome_aluno+"-"+string(i)+".txt"))
				i++;
			else
				canSave = true;
		}
	}
	
	var _file;
	if (i == 1)
		_file = file_text_open_write("relatorios/"+global.nome_aluno+".txt");
	else
		_file = file_text_open_write("relatorios/"+global.nome_aluno+"-"+string(i)+".txt");
		
	file_text_write_string(_file,"nome: ");
	file_text_write_string(_file,global.nome_aluno + "\n");
	
	file_text_write_string(_file,"pontos: ");
	file_text_write_string(_file,string(global.pontuacao));
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Feita: ");
	 if (global.acertos_fase1 == global.acertosParaFimDeFase)
		 file_text_write_string(_file,string(1))
	 else
		 file_text_write_string(_file,string(0))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Acertos: ");
	file_text_write_string(_file,string(global.acertos_fase1))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Erros: ");
	file_text_write_string(_file,string(global.erros_fase1))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1TempoEntreR: ");
	arrayTempoR = ArraySaveConvert(global.tempoEntreAcertos_fase1);
	file_text_write_string(_file,arrayTempoR);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Tempo: ");
	file_text_write_string(_file,string(global.tempoGasto_fase1))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Tentativas: ");
	file_text_write_string(_file,string(global.tentativas_fase1))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2Feita: ");
	 if (global.acertos_fase2 == global.acertosParaFimDeFase)
		 file_text_write_string(_file,string(1))
	 else
		 file_text_write_string(_file,string(0))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2Acertos: ");
	file_text_write_string(_file,string(global.acertos_fase2))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2Erros: ");
	file_text_write_string(_file,string(global.erros_fase2))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2TempoEntreR: ");
	arrayTempoR = ArraySaveConvert(global.tempoEntreAcertos_fase2);
	file_text_write_string(_file,arrayTempoR);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2Tempo: ");
	file_text_write_string(_file,string(global.tempoGasto_fase2))
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase2Tentativas: ");
	file_text_write_string(_file,string(global.tentativas_fase2))
	 file_text_writeln(_file)
	 
	file_text_close(_file);
}

function obterRanking(){
	var rankingGrid = ds_grid_create(2,5)
	var _RANKING = file_text_open_read("ranking.txt")
	for (var i=0;i<5;i++)
	{
		if (file_text_eof(_RANKING)) return 0
		var streng = file_text_readln(_RANKING)
		var stringParts = string_split(streng," ")
		if (stringParts[0] == array_last(stringParts)) return 0
		rankingGrid[# 0,i] = stringParts[0]
		rankingGrid[# 1,i] = real(array_last(stringParts))
	}
	//show_debug_message(rankingGrid);
	return rankingGrid
}

function SaveGameConclude(){
	saveResultados()
	rankingPontos = obterRanking()
	var _RANKING = file_text_open_write("ranking.txt")
	var delay = 0;
	for (var i = 0; i < 5; i++){
		if (global.pontuacao > rankingPontos[# 1, i] and delay == 0){
			file_text_write_string(_RANKING,global.nome_aluno + " " + string(global.pontuacao) + "\n")
			delay++;
		}
		else file_text_write_string(_RANKING,rankingPontos[# 0,i-delay] + " " + string(rankingPontos[# 1,i-delay]) + "\n")
	}
	file_text_close(_RANKING)
	ds_grid_destroy(rankingPontos)
}


function gerarRanking(){
	var _file = file_text_open_write("ranking.txt")
	file_text_write_string(_file,"joão" + " " + string(350) + "\n");
	file_text_write_string(_file,"jussara" + " " + string(300) + "\n");
	file_text_write_string(_file,"marques" + " " + string(270) + "\n");
	file_text_write_string(_file,"jessica" + " " + string(240) + "\n");
	file_text_write_string(_file,"tobias_junior" + " " + string(100) + "\n");
	file_text_close(_file)
}
