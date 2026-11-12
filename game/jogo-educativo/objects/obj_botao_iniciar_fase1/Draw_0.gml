draw_self(); // Desenha a arte do botão verde

// Centraliza o texto no botão
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Ajuste o "1.5" para mais ou para menos consoante o tamanho desejado
var tamanho_fonte = 1.5 * global.escala_fonte; 

// x e y representam o centro exato do botão (se a origem do sprite for Middle Center)
draw_text_transformed_color(x, y, "Iniciar jogo!", tamanho_fonte, tamanho_fonte, 0, c_white, c_white, c_white, c_white, 1);

// Reseta o alinhamento
draw_set_halign(fa_left);
draw_set_valign(fa_top);