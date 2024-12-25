`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 11:06:55 AM
// Design Name: 
// Module Name: Button_Pulse
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


module Button_Pulse(input Clk,
input a, input BTNU, //BTNU refers to reset
output reg o
 );
  localparam [2:0]
        s0 = 0, // 
        s1 = 1, // 
        s2 = 2; //
        
 reg [2:0] state, next_state;
 
    always @(posedge Clk or posedge BTNU) begin
        if (BTNU==1)
            state <= s0;
        else
            state <= next_state;
    end
 
 
 
 always @(*) begin
 case (state)
    s0:
    begin
    o <= 0;
    
    if (~a)
    next_state <= s0;
    else if (a)
    next_state <= s1;
    end
    
    s1:
    begin
    o <= 1;
    if (~a)
    next_state <= s0;
    else if (a)
    next_state <= s2;     
    end
    
    s2:
    begin
    o <= 0;
     if (a)
    next_state <= s2;
    else if (~a)
    next_state <= s0;   
    end
    
 endcase
 end
 
endmodule
