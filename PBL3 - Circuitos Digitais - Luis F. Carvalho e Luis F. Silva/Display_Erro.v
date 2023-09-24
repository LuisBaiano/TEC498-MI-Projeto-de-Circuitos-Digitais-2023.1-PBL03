module Display_Erro(
  input clk0,                // Entrada de clock
  input V_sense,             // Entrada para verificar a sensibilidade V
  input D_valor,             // Entrada do valor D
  input [2:0] select,        // Entrada de seleção
  output reg [3:0] digitos,  // Saída para os dígitos (registrador)
  output reg [6:0] segmentos // Saída para os segmentos (registrador)
);

  wire [2:0] and_gates;  // Fios (wires) para as portas AND
  wire or_gate;          // Fio (wire) para a porta OR

  // Lógica para atribuir valores às portas AND
  assign and_gates[0] = select == 3'b000 & (V_sense | D_valor);
  assign and_gates[1] = select == 3'b001 & V_sense;
  assign and_gates[2] = select == 3'b010 & D_valor;
  
  // Lógica para atribuir valor à porta OR
  assign or_gate = and_gates[0] | and_gates[1] | and_gates[2];

  always @(posedge clk0) begin
    // Lógica para atribuir valores aos dígitos com base nas portas AND
    digitos <= (and_gates[0]) ? 4'b1110 : (and_gates[1] | and_gates[2]) ? 4'b1101 : digitos;
    
    // Lógica para atribuir valores aos segmentos com base nas portas AND
    segmentos <= (and_gates[0]) ? 7'b0000110 : (and_gates[1]) ? 7'b1000000 : (and_gates[2]) ? 7'b1111001 : segmentos;
  end

endmodule
