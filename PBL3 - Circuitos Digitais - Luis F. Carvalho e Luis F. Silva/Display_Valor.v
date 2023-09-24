module Display_Valor (
	input sinal_cancel,           //sinal de cancelamentro do sistema
	input [2:0] chaves_cedulas,   // Entrada de seleção das chaves ou cédulas
	input V_sense,                // Entrada para verificar a sensibilidade V
	input [2:0] select,           // Entrada de seleção
	output reg [3:0]  digitos,         // Saída para os dígitos
	output reg [6:0]  segmentos,       // Saída para os segmentos
	output reg Exibe_Valor            // Saída para exibir o valor
);

	wire [6:0] aux_segs;   //Segmentos auxiliares para exibir 1, 2 e 5 reais
	
	assign aux_segs = (V_sense == 0) ? (chaves_cedulas == 3'b001) ? 7'b1111001 :   //1 REAL
    (chaves_cedulas == 3'b010) ? 7'b0100100 :  //2 REAIS
    (chaves_cedulas == 3'b011) ? 7'b0010010 :  //5 REAIS
     7'b1111111 : 7'b1111111;
	
	//Multiplexaçao para exibir 10, 20, 50 e 100 reais no display de sete segmentos, a partir da variavel contadora de selecao

  always @(select) begin
	 if (select == 3'b000 && V_sense == 1'b0 && sinal_cancel == 1'b0  && (chaves_cedulas == 3'b100 || chaves_cedulas == 3'b101 || chaves_cedulas == 3'b110 || chaves_cedulas == 3'b111)) begin 
		digitos <= 4'b0111;
		segmentos <= 7'b1000000;  //Caso seja inserido 10, 20, 50 ou 100 reais o ultimo digito da CPLD sempre exibira o numero 0
		Exibe_Valor <= 1'b1;
	 end else if (select == 3'b001 && V_sense == 1'b0 && sinal_cancel == 1'b0   && chaves_cedulas == 3'b100) begin    
		digitos <= 4'b1011;
		segmentos <= 7'b1111001;   //Caso o usuario insira 10 reais o segundo digito da CPLD exibira o numero 1
		Exibe_Valor <= 1'b1;		
	 end else if (select == 3'b010 && V_sense == 1'b0 && sinal_cancel == 1'b0  && chaves_cedulas == 3'b101) begin    
		digitos <= 4'b1011;
		segmentos <= 7'b0100100;	//Caso o usuario insira 20 reais o segundo digito da CPLD exibira o numero 2
		Exibe_Valor <= 1'b1;
	 end else if (select == 3'b011 && V_sense == 1'b0  && sinal_cancel == 1'b0 && chaves_cedulas == 3'b110) begin
		digitos <= 4'b1011;
		segmentos <= 7'b0010010;  //Caso usuario insira 50 reais o segundo digito exibira o numero 5
		Exibe_Valor <= 1'b1;
	 end else if (select == 3'b100 && V_sense == 1'b0 && sinal_cancel == 1'b0) begin
		digitos <= 4'b0111;
		segmentos <= aux_segs;  //Caso nenhuma condiç~ao de valor com duas unidades seja inserida, o display exibira um dos valores unitarios definidos anteriomente
		Exibe_Valor <= 1'b1;
	 end else if (select == 3'b101 && V_sense == 1'b0 && sinal_cancel == 1'b0 && chaves_cedulas == 3'b111) begin
		digitos <= 4'b1011;
		segmentos <= 7'b1000000;  //Inserindo 100 reias o segundo digito exibira o numero 0
		Exibe_Valor <= 1'b1;
	 end else if (select == 3'b110 && V_sense == 1'b0 && sinal_cancel == 1'b0 && chaves_cedulas == 3'b111) begin
		digitos <= 4'b1101;
		segmentos <= 7'b1111001; //Inserindo 100 reais o terceito digito exibira o valor 1
		Exibe_Valor <= 1'b1;
	 end else  begin
		Exibe_Valor <= 1'b0;   //Em qualquer condiçao que um valor esteja sendo inserido o display e os segmentos exibirao esta informacao, em caso contrario a variavel que controla isso recebe nivel logico baixo
	 end 
	 
	end


endmodule
