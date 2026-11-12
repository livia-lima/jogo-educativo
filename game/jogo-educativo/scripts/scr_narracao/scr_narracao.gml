/// scr_narracao - narração das telas (voz ao passar o mouse)
///
/// Uma voz por vez: ao começar uma nova, a anterior para.
/// O volume segue o slider de som (audio_master_gain).

/// @function narrar(nome_do_som)
/// @desc Toca a voz pelo nome do recurso de som. Se o som não existir, não faz nada.
function narrar(_nome) {
	var _som = asset_get_index(_nome);
	if (_som == -1 || !audio_exists(_som)) return;

	if (!variable_global_exists("voz_narracao")) global.voz_narracao = -1;
	if (global.voz_narracao != -1) audio_stop_sound(global.voz_narracao);

	global.voz_narracao = audio_play_sound(_som, 1, false);
}

/// @function som_item_fase1(item_id)
/// @desc Nome do som que fala o item da Fase 1, ou "" se ainda não há gravação.
function som_item_fase1(_item_id) {
	switch (_item_id) {
		case "bicicleta":            return "bicicleta";
		case "carro":                return "carro";
		case "garrafa":              return "garrafapl_stica";
		case "garrafa_reutilizavel": return "garrafareutiliz_vel";
		case "sacola_plastica":      return "sacolapl_stica";
		case "ecobag":               return "sacolareutilizavel";
		case "arvore":               return "arvore";
		case "canudo_metalico":      return "canudometalico";
		case "canudo_plastico":      return "canudoplastico";
		case "lampada_led":          return "lampadaled";
		case "lixeira_reciclavel":   return "lixeirareciclavel";
		case "pilha_lixo":           return "lixo";
		case "predios":              return "predios";
		case "torneira_aberta":      return "torneiraaberta";
		case "torneira_fechada":     return "torneirafechada";
		default:                     return "";
	}
}
