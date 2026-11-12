
// Script de pontuação.
/* --- Logica ---

+50 pontos por acerto
Uma resposta correta aumenta a pontuação do próximo acerto por +1x.
(1x, 2x, 3x, 4x, 5x, 6x, etc).
O multiplicador permanece no valor dado por 30 segundos. Após 30s, retorna à 1x.
Multiplicadores não passam de uma fase para outra.
Erro: -25 pontos e o multiplicador instantaneamente retorna para 1x.
Não é possível ter pontuação negativa.

// --- ---=--- -- */
// Como usar (as duas fases já fazem isso):
//   NovaPartida(nome)  -> ao confirmar o nome: zera todos os dados do jogador.
//   FaseTimeStart(fase) -> no início da fase (1 ou 2). Conta a tentativa.
//   Pontuou()           -> a cada acerto.
//   Errou()             -> a cada erro. Retorna true quando a tentativa chegou
//                          no limite de erros (global.errosParaFimDeFase); a fase
//                          decide quando ir para a tela de falha.
//   FaseConcluida(fase) -> ao terminar a fase: calcula o tempo gasto.
//   FimDeJogo()         -> na tela de parabéns: salva relatório e ranking.
//   Fechar o jogo no meio de uma partida salva só o relatório (obj_controller, Other_3).
//
// Relatório: os erros somam todas as tentativas; acertos, tempo entre acertos
// e tempo gasto são da última tentativa. Numa nova tentativa, a pontuação
// volta ao valor do início da fase (não dá para somar pontos repetindo a fase).

function resetaMult()
{
	global.mult = 1;
	//show_debug_message("RESET");
}

function _segundos_agora()
{
	return current_hour*3600 + current_minute*60 + current_second;
}

function NovaPartida(nome)
{
	global.nome_aluno = nome;
	global.partida_salva = false;
	global.pontuacao = 0;
	global.faseAtual = 0; // indicador de fase. (0 = nenhuma)
	global.mult = 1;
	global._Erros = 0;
	global._time = [0,0,0];
	global._faseStart1 = [0,0,0];
	global._faseStart2 = [0,0,0];

	global.acertos_fase1 = 0;
	global.erros_fase1 = 0;
	global.tempoEntreAcertos_fase1 = [];
	global.tempoGasto_fase1 = 0;
	global.tentativas_fase1 = 0;
	global.fase1_concluida = false;
	global._pontosAntesFase1 = 0;

	global.acertos_fase2 = 0;
	global.erros_fase2 = 0;
	global.tempoEntreAcertos_fase2 = [];
	global.tempoGasto_fase2 = 0;
	global.tentativas_fase2 = 0;
	global.fase2_concluida = false;
	global._pontosAntesFase2 = 0;
}

function FaseTimeStart(fase)
{
	global._time[0] = current_hour;
	global._time[1] = current_minute;
	global._time[2] = current_second;
	global.faseAtual = fase;

	if (fase == 1)
	{
		global._faseStart1 = [global._time[0], global._time[1], global._time[2]];
		if (global.tentativas_fase1 == 0) global._pontosAntesFase1 = global.pontuacao;
		else global.pontuacao = global._pontosAntesFase1;
		global.tentativas_fase1++;
		global.acertos_fase1 = 0;
		global.tempoEntreAcertos_fase1 = [];
	}
	else if (fase == 2)
	{
		global._faseStart2 = [global._time[0], global._time[1], global._time[2]];
		if (global.tentativas_fase2 == 0) global._pontosAntesFase2 = global.pontuacao;
		else global.pontuacao = global._pontosAntesFase2;
		global.tentativas_fase2++;
		global.acertos_fase2 = 0;
		global.tempoEntreAcertos_fase2 = [];
	}
	resetaMult();
	global._Erros = 0;
}

function Pontuou()
{
	global.pontuacao += 50*global.mult
	time_source_start(global._tempoMult)
	global.mult++;
	// cálculo de tempo entre respostas
	var newTime = [current_hour,current_minute,current_second];
	var timeDiff = (newTime[0]*3600 + newTime[1]*60 + newTime[2])-(global._time[0]*3600 + global._time[1]*60 + global._time[2])
	global._time = newTime; // novo time.
	if (global.faseAtual == 1)
	{
		global.tempoEntreAcertos_fase1[global.acertos_fase1] = timeDiff;
		global.acertos_fase1++;
	}
	else if (global.faseAtual == 2)
	{
		global.tempoEntreAcertos_fase2[global.acertos_fase2] = timeDiff;
		global.acertos_fase2++;
	}
}

function Errou()
{
	global._Erros++;
	if (global.faseAtual == 1)
		global.erros_fase1++;
	else
		global.erros_fase2++;
	// Perde pontos no erro, sem ficar negativo
	global.pontuacao = max(0, global.pontuacao - global.pontosPorErro);
	resetaMult()
	return global._Erros >= global.errosParaFimDeFase;
}

function FaseConcluida(fase)
{
	if (fase == 1)
	{
		global.tempoGasto_fase1 = _segundos_agora() - (global._faseStart1[0]*3600 + global._faseStart1[1]*60 + global._faseStart1[2]);
		global.fase1_concluida = true;
	}
	else if (fase == 2)
	{
		global.tempoGasto_fase2 = _segundos_agora() - (global._faseStart2[0]*3600 + global._faseStart2[1]*60 + global._faseStart2[2]);
		global.fase2_concluida = true;
	}
	global.faseAtual = 0;
	resetaMult();
}

function FimDeJogo()
{
	SaveGameConclude();
	global.partida_salva = true; // já salvou: fechar o jogo agora não salva de novo
}
