
// Script de pontuação.
/* --- Logica ---

+50 pontos por acerto
Uma resposta correta aumenta a pontuação do próximo acerto por +1x. 
(1x, 2x, 3x, 4x, 5x, 6x, etc).
O multiplicador permanece no valor dado por 30 segundos. Após 30s, retorna à 1x.
Multiplicadores não passam de uma fase para outra.
Erro: O multiplicador instantaneamente retorna para 1x. 
Não é possível ter pontuação negativa.

ASSOCIANDO PALAVRAS: associar 6 elementos.  +1050 pontos.
CONTANDO OBJETOS: contar 6 objetos. +1050 pontos.

Pontuação total com apenas 1x: 600
Pontuação total com mult máximo: 2100

// --- ---=--- -- */
// Utilize FaseTimeStart ao iniciar uma fase para iniciar o sistema. Informe qual fase (1 ou 2) como argumento.
// Pontuou para adicionar pontos por acerto, Errou para contabilizar um erro.
// 12 erros resultam em uma tela de falha.

// time source para cronometragem de tempo


function resetaMult()
{
	global.mult = 1;
	//show_debug_message("RESET");
}

function FaseTimeStart(fase)
{
	global._time[0] = current_hour;
	global._time[1] = current_minute;
	global._time[2] = current_second;
	if (fase == 1)
	{
		global._faseStart1 = global._time;
		global.faseAtual = fase
	}
	else if (fase == 2)
	{
		global.faseAtual = fase
		global._faseStart2 = global._time;
	}
	resetaMult();
	global._Erros = 0;
}

function Pontuou()
{
	global.pontuacao += 50*global.mult
	time_source_start(global._tempoMult)
	global.mult++;
	// cálculo de tempo entre respotas
	newTime = [current_hour,current_minute,current_second];
	timeDiff = (newTime[0]*3600 + newTime[1]*60 + newTime[2])-(global._time[0]*3600 + global._time[1]*60 + global._time[2])
	global._time = newTime; // novo time.
	//if (room = rm_fase1_gameplay)
	//{
		global.tempoEntreAcertos_fase1[global.acertos_fase1] = timeDiff;
		global.acertos_fase1++;
		
		if (global.acertos_fase1 >= 6)
		{
			global.tempoGasto_fase1 = newTime[0]*3600 + newTime[1]*60 + newTime[2] - (global._faseStart1[0]*3600 + global._faseStart1[1]*60 + global._faseStart1[2])
			game_end() // remover depois
		}
	//}
	//else if (room = rm_fase2_gameplay)
	//{
	//	global.tempoEntreAcertos_fase2[global.acertos_fase2] = timeDiff;
	//	global.acertos_fase2++;
	//}
	
}

function Errou()
{
	global._Erros++;
	if (global.faseAtual == 1)
		global.erros_fase1++;
	else
		global.erros_fase2++;
	resetaMult()
	/*
	if (global._Erros >= 12)
	{
		if (room = rm_fase1_gameplay)
		{
			room_goto(rm_fase1_falha);
		}
		else if (room = rm_fase2_gameplay)
		{
			room_goto(rm_fase2_falha);
		}
	}*/
}