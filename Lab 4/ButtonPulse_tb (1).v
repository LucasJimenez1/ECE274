`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 08:50:42 PM
// Design Name: 
// Module Name: ButtonPulse_tb
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


module ButtonPulse_tb;
//inputs
reg a_tb, Clk_tb;
//outputs
wire o_tb;


Button_Pulse uut (
.Clk(Clk_tb),
.a(a_tb),
.o(o_tb)
);

  // Clock generation
  always begin
    Clk_tb <= 0;
    #10;
    Clk_tb <= 1;
    #10;
  end


initial begin
a_tb <= 0; // button not pressed / wait rise
@(posedge Clk_tb);

@(posedge Clk_tb);@(posedge Clk_tb);
a_tb <= 1; //button pressed / move to pulse
@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);
a_tb <= 0;// button not pressed / wait rise
@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);
a_tb <= 1; //button pressed / move to pulse
@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);
a_tb <= 1; //button pressed / move to waitFall
@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);@(posedge Clk_tb);
a_tb <= 0;// button not pressed / wait rise

end

    
    
    
endmodule
