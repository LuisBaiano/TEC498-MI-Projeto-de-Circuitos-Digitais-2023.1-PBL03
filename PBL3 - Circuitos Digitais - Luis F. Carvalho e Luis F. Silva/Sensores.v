module Sensores(chaves_sensores, V_sense, led7, led8, led9);

	//CH6 - SP, CH5 - SR e CH4 - SN
	input [2:0] chaves_sensores; //CH6 = chaves_sensores[2], CH5 = chaves_sensores[1], CH4 = chaves_sensores[0]
	output V_sense, led7, led8, led9;
	
	buf(led9, chaves_sensores[2]); //acende led para indicar funcionamento do sensor SP
	buf(led8, chaves_sensores[1]); //acende led para indicar funcionamento do sensor SR
	buf(led7, chaves_sensores[0]); //acende led para indicar funcionamento do sensor SN

	//combinações dos sensores
   nand(V_sense, chaves_sensores[0], chaves_sensores[1], chaves_sensores[2]);
	//Se pelo menos um dos sensores estiver desativado, a saída erro_sensor recebe nivel lógico alto


endmodule
