`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 09:18:03 AM
// Design Name: 
// Module Name: mux8bits_2x1_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux8bits_2x1_tb();
//inputs
reg [7:0] I1_tb, I0_tb;
reg s_tb;
//output
wire [7:0] D_tb;

mux8bits_2x1 mux8bits_2x1_tb (s_tb, I1_tb, I0_tb, D_tb);

initial
begin

s_tb <= 1;
I1_tb <= 255;
I0_tb <= 100;

#100
//D = I1 = 255

#100
s_tb <= 0;
// D = I0 = 0

end
endmodule
