
/*
    HUD DA FASE 1
    Responsabilidade: apenas desenhar os indicadores.
    Não altera pontuação nem cronômetro.
*/

// =====================================
// 1. DIMENSÕES DA INTERFACE
// =====================================

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// =====================================
// 2. ESCALA DE ACESSIBILIDADE
// =====================================

var escala_acessibilidade = 1;

if (variable_global_exists("escala_fonte")) {
    escala_acessibilidade = clamp(
        global.escala_fonte, 1, 2
    );
}

// =====================================
// 3. POSICIONAMENTO DO HUD
// =====================================

// Posições proporcionais ao protótipo
// Centro vertical dos botões Voltar e Dicas
var y_hud = gui_h * 0.10;

// Centro vertical dos textos
var texto_y = y_hud;

var x_pontos = gui_w * 0.25;
var x_tempo  = gui_w * 0.60;

// Tamanho visual dos ícones
var tamanho_icone = gui_h * 0.075;

// Escalas dos sprites
var escala_moeda = tamanho_icone / max(
    sprite_get_width(spr_moeda),
    sprite_get_height(spr_moeda)
);

var escala_timer = tamanho_icone / max(
    sprite_get_width(spr_timer),
    sprite_get_height(spr_timer)
);

// =====================================
// 4. DESENHAR OS ÍCONES
// =====================================

draw_sprite_ext(
    spr_moeda,
    0,
    x_pontos,
    y_hud,
    escala_moeda,
    escala_moeda,
    0,
    c_white,
    1
);

draw_sprite_ext(
    spr_timer,
    0,
    x_tempo,
    y_hud,
    escala_timer,
    escala_timer,
    0,
    c_white,
    1
);

// =====================================
// 5. PREPARAR OS TEXTOS
// =====================================

// Preserva configurações de desenho
var fonte_anterior = draw_get_font();
var cor_anterior = draw_get_color();
var halign_anterior = draw_get_halign();
var valign_anterior = draw_get_valign();

// Fonte padrão (não exige novo recurso)
draw_set_font(-1);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

// Pontuação: somente leitura
var texto_pontos = string(pontos_exibidos);

// Cronômetro: formato M:SS
var tempo_total = max(0, ceil(tempo_exibido));

var minutos = tempo_total div 60;
var segundos = tempo_total mod 60;

var texto_segundos = string(segundos);

if (segundos < 10) {
    texto_segundos = "0" + texto_segundos;
}

var texto_tempo = string(minutos)
    + ":" + texto_segundos;

// =====================================
// 6. TAMANHO E POSIÇÃO DOS TEXTOS
// =====================================

// Altura visual desejada para os números
var altura_texto = gui_h * 0.085;

var escala_base = altura_texto / max(
    1, string_height("0")
);

var escala_desejada = escala_base
    * escala_acessibilidade;

// Posiciona o texto após cada ícone
var espaco = tamanho_icone * 0.85;

var texto_pontos_x = x_pontos + espaco;
var texto_tempo_x  = x_tempo + espaco;

// Limites para evitar sobreposição
var limite_pontos = max(
    1,
    x_tempo - texto_pontos_x - tamanho_icone
);

var limite_tempo = max(
    1,
    gui_w * 0.90 - texto_tempo_x
);

// Ajusta a escala se faltar espaço
var escala_pontos = min(
    escala_desejada,
    limite_pontos / max(1, string_width(texto_pontos))
);

var escala_tempo = min(
    escala_desejada,
    limite_tempo / max(1, string_width(texto_tempo))
);

// Espessura do contorno
var contorno = max(1, gui_h * 0.004);

// =====================================
// 7. DESENHAR PONTUAÇÃO
// =====================================

// Contorno escuro
draw_set_color(c_black);

draw_text_transformed(
    texto_pontos_x - contorno,
    y_hud,
    texto_pontos,
    escala_pontos, escala_pontos, 0
);

draw_text_transformed(
    texto_pontos_x + contorno,
    y_hud,
    texto_pontos,
    escala_pontos, escala_pontos, 0
);

draw_text_transformed(
    texto_pontos_x,
    texto_y - contorno,
    texto_pontos,
    escala_pontos, escala_pontos, 0
);

draw_text_transformed(
    texto_pontos_x,
    texto_y + contorno,
    texto_pontos,
    escala_pontos, escala_pontos, 0
);

// Texto principal
draw_set_color(c_white);

draw_text_transformed(
    texto_pontos_x,
    y_hud,
    texto_pontos,
    escala_pontos, escala_pontos, 0
);

// =====================================
// 8. DESENHAR CRONÔMETRO
// =====================================

// Contorno escuro
draw_set_color(c_black);

draw_text_transformed(
    texto_tempo_x - contorno,
    y_hud,
    texto_tempo,
    escala_tempo, escala_tempo, 0
);

draw_text_transformed(
    texto_tempo_x + contorno,
    y_hud,
    texto_tempo,
    escala_tempo, escala_tempo, 0
);

draw_text_transformed(
    texto_tempo_x,
    y_hud - contorno,
    texto_tempo,
    escala_tempo, escala_tempo, 0
);

draw_text_transformed(
    texto_tempo_x,
    y_hud + contorno,
    texto_tempo,
    escala_tempo, escala_tempo, 0
);

// Texto principal
draw_set_color(c_white);

draw_text_transformed(
    texto_tempo_x,
    y_hud,
    texto_tempo,
    escala_tempo, escala_tempo, 0
);

// =====================================
// 9. RESTAURAR CONFIGURAÇÕES
// =====================================

draw_set_font(fonte_anterior);
draw_set_color(cor_anterior);
draw_set_halign(halign_anterior);
draw_set_valign(valign_anterior);
