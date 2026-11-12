draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 1. Variáveis e Escala (afeta tanto o título como o nome)
var centro_x = x; 
var centro_y = y; 
var tamanho_texto = 3 * global.escala_fonte; // Tamanho para o que é digitado
var tamanho_titulo = 3.5 * global.escala_fonte; // Título ligeiramente maior

// 2. Desenhar o Título "Digite seu nome"
var altura_titulo = centro_y - (180 * global.escala_fonte); // Sobe 90 píxeis (ajuste se precisar)

// Efeito de sombra preta para o título ficar legível contra as nuvens
draw_text_transformed_color(centro_x + 2, altura_titulo + 2, "Digite seu nome", tamanho_titulo, tamanho_titulo, 0, c_black, c_black, c_black, c_black, 1);
// Título principal em branco
draw_text_transformed_color(centro_x, altura_titulo, "Digite seu nome", tamanho_titulo, tamanho_titulo, 0, c_black, c_black, c_black, c_black, 1);


// 3. Desenhar o Nome Digitado e o Cursor
var texto_final = nome_digitado;
if (selecionado && cursor_pisca) {
    texto_final += "|";
}

draw_text_transformed_color(centro_x, centro_y, texto_final, tamanho_texto, tamanho_texto, 0, c_white, c_white, c_white, c_white, 1);

// 4. Resetar o alinhamento
draw_set_halign(fa_left);
draw_set_valign(fa_top);