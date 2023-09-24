module Flip_flop_D(
  input wire d, // Entrada de dados
  input wire clock, // Entrada do clock
  input wire reset, // Entrada de reset
  output reg q // Saída do flip-flop
);

  always @(posedge clock or posedge reset) begin
    if (reset) // Se o sinal de reset estiver ativo
      q <= 1'b0; // Define a saída como 0
    else // Caso contrário
      q <= d; // A saída acompanha o valor da entrada de dados
  end
	
endmodule
