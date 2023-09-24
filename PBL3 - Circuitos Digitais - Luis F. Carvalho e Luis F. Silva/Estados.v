module Estados(
    input clk3, Cancel, D_valor, V_sense, Temp_2, Temp_2_1, Temp_5, Temp_15,
	 output led_press, led_aquec, led_bebida_1, led_bebida_2, reset_Temp_2, reset_Temp_15, Devolver_dinheiro
);

    // Saídas intermediárias
	wire Working;
	wire [1:0]Estados, Estado_atual;

    // Flip-flops D para armazenar os estados atuais
	 Flip_flop_D Q0(Estados[0], clk3, 1'b0, Estado_atual[0]);
	 Flip_flop_D Q1(Estados[1], clk3, 1'b0, Estado_atual[1]);

    // Fios para as condições de transição entre os estados
    wire Mantem_Espera, Vai_para_Erro, Vai_para_Venda, Mantem_Erro, De_Erro_para_Espera;
    wire De_venda_para_Espera, Vai_para_Preparo, De_venda_para_Erro, De_Preparo_para_Erro, Cancela_venda;
    wire Mantem_Preparo_1, Mantem_Preparo_2, Mantem_Preparo_3, De_Preparo_para_Espera, Cancela_preparo;

    // Definição das condições de transição entre os estados usando portas lógicas

    // Estado atual: Espera / Próximo estado: Espera
    and(Mantem_Espera, !Estado_atual[0], Estado_atual[1], !V_sense, Cancel);
    // Estado atual: Espera / Próximo estado: Erro
    and(Vai_para_Erro, !Estado_atual[0], Estado_atual[1], V_sense);
    // Estado atual: Espera / Próximo estado: Venda
    and(Vai_para_Venda, !Estado_atual[0], Estado_atual[1], !V_sense, Working);
    // Estado atual: Venda / Próximo estado: Espera
    and(De_venda_para_Espera, Estado_atual[0], !Estado_atual[1], !V_sense, Temp_15);
    // Estado atual: Venda / Próximo estado: Espera (cancelamento da venda)
    and(Cancela_venda, Estado_atual[0], !Estado_atual[1], Cancel, !V_sense);
    // Estado atual: Venda / Próximo estado: Erro
    and(De_venda_para_Erro, Estado_atual[0], !Estado_atual[1], D_valor, V_sense);
    // Estado atual: Venda / Próximo estado: Preparo
    and(Vai_para_Preparo, Estado_atual[0], !Estado_atual[1], !D_valor, Working, !V_sense);
    // Estado atual: Erro / Próximo estado: Erro (mantém o estado)
    and(Mantem_Erro, !Estado_atual[0], !Estado_atual[1], V_sense);
    // Estado atual: Erro / Próximo estado: Espera
    and(De_Erro_para_Espera, !Estado_atual[0], !Estado_atual[1], !V_sense);
    // Estado atual: Preparo / Próximo estado: Erro
    and(De_Preparo_para_Erro, Estado_atual[0], Estado_atual[1], V_sense);
    // Estado atual: Preparo / Próximo estado: Preparo (mantém o estado)
    and(Mantem_Preparo_1, Estado_atual[0], Estado_atual[1], !V_sense, !Temp_2);
    and(Mantem_Preparo_2, Estado_atual[0], Estado_atual[1], !V_sense, !Temp_2_1);
    and(Mantem_Preparo_3, Estado_atual[0], Estado_atual[1], !V_sense, !Temp_5);
    // Estado atual: Preparo / Próximo estado: Espera
    and(De_Preparo_para_Espera, Estado_atual[0], Estado_atual[1], !V_sense, !Working, !Temp_5);
    // Estado atual: Preparo / Próximo estado: Espera (cancelamento do preparo)
    and(Cancela_preparo, Estado_atual[0], Estado_atual[1], !V_sense, Working, Cancel);
	 
    // Definição dos sinais dos flip-flops de acordo com as transições
    or(Estados[0], Vai_para_Venda, Vai_para_Preparo, Mantem_Preparo_1, Mantem_Preparo_2, Mantem_Preparo_3);
    or(Estados[1], Mantem_Espera, De_venda_para_Espera, Cancela_venda, Vai_para_Preparo, De_Erro_para_Espera, Mantem_Preparo_1, Mantem_Preparo_2, Mantem_Preparo_3, De_Preparo_para_Espera);

    //Saídas dos temporizadores
    // Saídas dos temporizadores
    and(reset_Temp_2, Estados[1], Estados[0]);
    and(reset_Temp_2_1, Temp_2);
    and(reset_Temp_5, Temp_2_1);
    and(reset_Temp_15, Estados[1], Estados[0]);

    // Saídas dos LEDsl
    assign Led_dinheiro_1 = Devolver_dinheiro;  // Sinal para acender o LED do dinheiro 1
    assign Led_dinheiro_2 = Devolver_dinheiro;  // Sinal para acender o LED do dinheiro 2
    
    // Estado de Preparo
    and(led_press, Temp_2, 1'b1);  // Sinal para acender o LED de pressurização
    and(led_aquec, Temp_2_1, 1'b1);  // Sinal para acender o LED de aquecimento
    and(led_bebida_1, Temp_5, 1'b1);  // Sinal para acender o LED do dispenser de bebida 1
    and(led_bebida_2, Temp_5, 1'b1);  // Sinal para acender o LED do dispenser de bebida 2
endmodule

