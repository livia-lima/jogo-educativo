if (numero == 0 && point_distance(mouse_x, mouse_y, x, y) < 70) {
    obj_fase2_controle.contagem++;
    numero = obj_fase2_controle.contagem;
    escala = 1.3;
    if (numero <= 9) obj_fase2_controle.falar(obj_fase2_controle.numeros_som[numero - 1]);
}
escala = lerp(escala, 1, 0.1);