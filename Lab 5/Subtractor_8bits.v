`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 10:36:29 AM
// Design Name: 
// Module Name: Subtractor_8bits
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


module Subtractor_8bits(A,B,S);
    input [7:0] A,B;
    output [7:0] S;
    assign S = A-B;
    
endmodule
