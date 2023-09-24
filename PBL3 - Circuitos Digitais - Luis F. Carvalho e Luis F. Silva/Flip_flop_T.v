module Flip_flop_T(clk, t, q, ld);

	input clk, t, ld; // Entradas do clock, sinal de toggle e sinal de load
	output reg q; // Saída do flip-flop

	always @(posedge clk) begin 
		if (t) // Se o sinal de toggle estiver ativo
			q <= ~q; // Inverte o valor da saída
		else if (ld) // Se o sinal de load estiver ativo
			q <= 1'b0; // Define a saída como 0
		else
			q <= q; // Mantém o valor atual da saída
	end
endmodule
