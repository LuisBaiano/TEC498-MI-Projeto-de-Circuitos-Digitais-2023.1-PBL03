//Modulo utilizado para exibir no display a bebida escolhida pelo usuario

module Display_Bebida(
	input sinal_cancel,  //Sinal de cancelamento 
	input [3:0] botoes,  //Botoes para compra da bebida
	input [2:0] chaves_cedulas,  //Chaves para informar o valor inserido pelo usuario
	input V_sense,   //Variavel de verificaçao dos sensores
	input D_valor,   //Variavel de verificacao de compra
	output [3:0] digits,   //Digitos e segmentos do display
	output [6:0] segments,
	output View_bebida  //Variavel que define que a beida deve ser exibida pelos digitos e segmentos do display
);

	assign digits = 4'b1110;   //Definiçao do digito que devera exibir a bebida na CPLD

	assign segments = (V_sense == 0 && D_valor == 0 && sinal_cancel == 1'b0) ? (chaves_cedulas == 3'b100 && botoes[0]) ? 7'b0011001 :  //CAPPUCCINO
    (chaves_cedulas == 3'b010 && botoes[1]) ? 7'b0100100 :     //CAFE COM LEITE
    (chaves_cedulas == 3'b011 && botoes[2]) ? 7'b0110000 : 		//CHA DE CAMOMILA
    (chaves_cedulas == 3'b001 && botoes[3]) ? 7'b1111001 : 7'b1111111 : 7'b1111111;  //CAFE EXPRESSO

	assign View_bebida = (V_sense == 0 && D_valor == 0 && sinal_cancel == 1'b0) ? (botoes[0]) ? 1'b1 :
    (botoes[1]) ? 1'b1 :   
    (botoes[2]) ? 1'b1 :                            //DEFINICAO DA VARIAVEL QUE ENVIARA PARA CONTROLA DISPLAY A CONFIRMAÇAO DE QUE A BEBIDA DEVE SER EXIBIDA PELO DISPLAY
    (botoes[3]) ? 1'b1 : 1'b0 : 1'b0;

endmodule
