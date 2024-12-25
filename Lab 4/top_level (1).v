`timescale 1ns / 1ps


module top_design(CLK100MHZ, BTNU, BTNL, BTNC, BTNR, LED, CA, CB, CC, CD, CE, CF, CG, AN);
input CLK100MHZ;
input BTNU; //BTNU is Reset
input BTNL, BTNC, BTNR; //BTNL is Nickel, BTNC is Dime, BTNR is Quarter
output [0:0] LED; //LED[0] is Candy
output CA, CB, CC, CD, CE, CF, CG; //segment a, b, ... g
output [7:0] AN; //enable each digit of the 8 digits


wire ClkOut;
wire [6:0] Number;
wire s1; //nickel
wire s2; //dime
wire s3; //quarter




//write your code to connect the modules as shown in Figure 1
    ClkDiv clock_divider (.Clk(CLK100MHZ), .Rst(0), .ClkOut(ClkOut));
    
    /*
    module Button_Pulse(input Clk,
input a, input BTNU, //BTNU refers to reset
output reg o
 );
    */
   Button_Pulse nickle(ClkOut, BTNL, BNTU, s1);
   Button_Pulse dime(ClkOut, BTNC, BNTU, s2);    
   Button_Pulse quarter(ClkOut, BTNR, BNTU, s3);

/*   
module VendingMachine(
//inputs
input Clk,
input Rst,
input N,
input D,
input Q,

//outputs
output reg [6:0] Number, //Number to display
output reg Candy //candy LED for when 25c is inserted
);
*/
    VendingMachine vending_machine(ClkOut, BTNU, s1, s2, s3, Number, LED);

    //module TwoDigitDisplay(CLK100MHZ, SW, CA,CB,CC,CD,CE,CF,CG,AN);
    TwoDigitDisplay two_digit(CLK100MHZ, Number, CA, CB, CC, CD, CE, CF, CG, AN);

endmodule