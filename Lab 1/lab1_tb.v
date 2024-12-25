`timescale 1ns / 1ps
module lab1_tb();
reg A_tb, B_tb, C_tb, D_tb;
wire I0_tb, I1_tb, I2_tb;

lab1 lab1_tb(A_tb, B_tb, C_tb, D_tb,I0_tb, I1_tb, I2_tb);
initial begin
A_tb = 0;
B_tb = 0;
C_tb = 0;
D_tb = 0;


#10 D_tb = 1;

#10 C_tb = 1;
#10 D_tb = 0;

#10 B_tb = 1; //0100
#10 C_tb = 0;
#10 D_tb = 0;

#10 D_tb = 1;//0101

#10 C_tb = 1;//0110
#10 D_tb = 0;

#10 D_tb = 0;//0111

#10 B_tb = 1; //1000
#10 B_tb = 0; 
#10 C_tb = 0;
#10 D_tb = 0;

#10 D_tb = 1; //1001

#10 C_tb = 1; //1010
#10 D_tb = 0;

#10 D_tb = 1; //1011

#10 B_tb = 1; //1100
#10 C_tb = 0; 
#10 D_tb = 0;

#10 D_tb = 1; //1101

#10 C_tb = 1; //1110
#10 D_tb = 0;

#10 D_tb = 1;//1111




end
endmodule
