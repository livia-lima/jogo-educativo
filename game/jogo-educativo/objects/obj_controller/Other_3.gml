// coisas para fazer quando o jogo estiver sendo fechado.
// Saída no meio de uma partida (já começou a Fase 1 e ainda não salvou): salva o relatório.
if (global.nome_aluno != "" && global.tentativas_fase1 > 0 && !global.partida_salva)
	saveResultados()