`timescale 1ns / 1ps


module Lab5(Clk, Rst, go, sum, done);
    input Clk, Rst, go;
    output [11:0] sum;
    output done;

////////////////////////////////////
    //declare all internal signals used in this code here
    //make sure that you use correct number of bits


            
/// Controller is already instantiated below with all control signals that you can use in your code.     
    wire muxsel, R_en, i_clr, i_ld;
    wire temp2_clr, temp2_ld;
    wire temp1_clr, temp1_ld;
    wire sum_clr, sum_ld;
    wire temp1_gt_temp2, i_lt_32;
    
    Controller c1(Clk, Rst, go, temp1_gt_temp2, i_lt_32, done, muxsel, R_en,
                  i_clr, i_ld, temp1_clr, temp1_ld, temp2_clr, temp2_ld, sum_clr, sum_ld);
////////////////////////////////////   
    
     //write your code here. Instantiate modules
     //and connect those modules together to implement
     //the digital system of lab 5
     
wire [7:0] D1;
wire [7:0]temp1;
wire [7:0]temp2;

wire [7:0] D2;

//module Subtractor_8bits(A,B,S);
wire [7:0] S;
Subtractor_8bits eight_bit_substractor(D1, D2, S);

//module Adder_12bits(A, B, Cin, S, Co);
wire [11:0] sAdd;
wire unusedCO;
Adder_12bits twelve_bit_adder (sum, {4'b0, S}, 1'b0, sAdd, unusedCO);

//module Register_12bits(Clk, Clr, Ld, I, Q);
Register_12bits twelve_bit_register(Clk, sum_clr, sum_ld, sAdd, sum);

//module Register_6bits(Clk, Clr, Ld, I, Q);
wire [5:0] sixRegisterOUT;
wire [5:0] sixAdderOUT;
Register_6bits six_bit_register(Clk, i_clr, i_ld, sixAdderOUT, sixRegisterOUT);

//module Adder_6bits(A, B, Cin, S, Co);
Adder_6bits six_bit_adder(sixRegisterOUT, 1, 1'b0, sixAdderOUT, unusedCO);

//module Comparator_6bits(A, B, AltB, AeqB, AgtB);
wire unusedvals;
Comparator_6bits six_bit_comparator(sixRegisterOUT, 32, i_lt_32, unusedvals, unusedvals);

//module RegisterFile_32_8(R_Addr, W_Addr, R_en, W_en,R_Data, W_Data, Clk, Rst);
wire [7:0] R_data;
RegisterFile_32_8 registerFile(sixRegisterOUT[4:0], 5'b0, R_en, 1'b0, R_data, 8'b0, Clk, Rst); //FIXME: sixRegisterOUT should be 5 bits? might cause errors

//module Register_8bits(Clk, Clr, Ld, I, Q);
Register_8bits eight_bit_register_one(Clk, temp2_clr, temp2_ld, R_data, temp2);

//module Register_8bits(Clk, Clr, Ld, I, Q);
Register_8bits eight_bit_register_two(Clk, temp1_clr, temp1_ld, R_data, temp1);

//module Comparator_8bits(A, B, AltB, AeqB, AgtB);
Comparator_8bits eight_bit_comparator(temp1, temp2, unusedvals, unusedvals, temp1_gt_temp2);

//module mux8bits_2x1(s, I1, I0, D);
mux8bits_2x1 eight_bit_mux1(muxsel, temp1, temp2, D1);

//module mux8bits_2x1(s, I1, I0, D);
mux8bits_2x1 eight_bit_mux2(muxsel, temp2, temp1, D2);

     



endmodule
