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
	i = 0;
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
	if (i == 0)
		_file = file_text_open_write("relatorios/"+global.nome_aluno+".txt");
	else
		_file = file_text_open_write("relatorios/"+global.nome_aluno+"-"+string(i)+".txt");
		
	file_text_write_string(_file,"nome: ");
	file_text_write_string(_file,global.nome_aluno + "\n");
	
	file_text_write_string(_file,"pontos: ");
	file_text_write_real(_file,global.pontuacao);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Feita: ");
	 if (global.acertos_fase1 == 6)
		 file_text_write_real(_file,1);
	 else
		 file_text_write_real(_file,0);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Acertos: ");
	file_text_write_real(_file,global.acertos_fase1);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Erros: ");
	file_text_write_real(_file,global.erros_fase1);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1TempoEntreR: ");
	arrayTempoR = ArraySaveConvert(global.tempoEntreAcertos_fase1);
	file_text_write_string(_file,arrayTempoR);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Tempo: ");
	file_text_write_real(_file,global.tempoGasto_fase1);
	 file_text_writeln(_file)
	 
	file_text_write_string(_file,"fase1Tentativas: ");
	file_text_write_real(_file,global.tentativas_fase1);
	 file_text_writeln(_file)
	 
	file_text_close(_file);
}