`timescale 1ns / 1ps

module RegisterFile_32_8(R_Addr, W_Addr, R_en, W_en,R_Data, W_Data, Clk, Rst);

   input [4:0] R_Addr, W_Addr;
   input R_en, W_en;
   output reg [7:0] R_Data;
   input [7:0] W_Data;
   input Clk, Rst;

   reg [7:0] RegFile [0:31];
   
   integer i;
   // Write procedure
   always @(posedge Clk) begin
      if (Rst==1) begin
         //test case 1: I made up these numbers
         for (i = 0; i < 32; i = i + 4) 
                RegFile[i] = 3*(i+1);
         for (i = 1; i < 32; i = i + 4) 
                RegFile[i] = 255-i;
         for (i = 2; i < 32; i = i + 4) 
                RegFile[i] = 10*i+2;
         for (i = 3; i < 32; i = i + 4) 
                RegFile[i] = 128 + i;                         
         //test case 2
//         for (i = 0; i < 32; i = i + 2) begin
//                RegFile[i] = 0;
//         end
//         for (i = 1; i < 32; i = i + 2) begin
//                RegFile[i] = 255;
//         end
      end
      else if (W_en==1) begin
         RegFile[W_Addr] <= W_Data;
      end
   end

   // Read procedure
   always @* begin
      if (R_en==1)
         R_Data <= RegFile[R_Addr];
      else
         R_Data <= 8'hZZ;
   end
endmodule

