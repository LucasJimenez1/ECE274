`timescale 1ns / 1ps

//Exam 3 written by Elmer Yahel Raygoza and Lucas Jimenez.

module Exam3(input Rst, input Clk, input go, output reg done, output reg [15:0] sum, output [7:0] R_Data, output reg [7:0] average, output reg [3:0] countodd);

reg[7:0] temp;
reg[7:0] temp1;
reg[7:0] prevtemp;
integer i = 0;


wire [3:0] R_Addr;
wire [7:0] W_Data;
reg R_en, W_en;

//State definititons
localparam
    S0 = 0,
    S1 = 1,
    S2 = 2,
    S3 = 3,
    S4 = 4,
    S5 = 5,
    S5A = 6,
    S6 = 7,
    S7 = 8;

reg [4:0] state = S0;
reg [4:0] next_state = S0;

(* mark_debug = "true" *) wire [7:0] debug_Reg0;
 (* mark_debug = "true" *) wire [7:0] debug_Reg1;
 (* mark_debug = "true" *) wire [7:0] debug_Reg2;
 (* mark_debug = "true" *) wire [7:0] debug_Reg3;
 (* mark_debug = "true" *) wire [7:0] debug_Reg4;
 (* mark_debug = "true" *) wire [7:0] debug_Reg5;
 (* mark_debug = "true" *) wire [7:0] debug_Reg6;
 (* mark_debug = "true" *) wire [7:0] debug_Reg7;
 (* mark_debug = "true" *) wire [7:0] debug_Reg8;
 (* mark_debug = "true" *) wire [7:0] debug_Reg9;
 (* mark_debug = "true" *) wire [7:0] debug_Reg10;
 (* mark_debug = "true" *) wire [7:0] debug_Reg11;
 (* mark_debug = "true" *) wire [7:0] debug_Reg12;
 (* mark_debug = "true" *) wire [7:0] debug_Reg13;
 (* mark_debug = "true" *) wire [7:0] debug_Reg14;
 (* mark_debug = "true" *) wire [7:0] debug_Reg15;

Register16_8 regFile(
    .R_Addr(i[3:0]),
    .W_Addr(i[3:0] - 1),
    .R_en(R_en),
    .W_en(W_en),
    .R_Data(R_Data),
    .W_Data(prevtemp),
    .Clk(Clk),
    .Rst(Rst),
    .debug_Reg0(debug_Reg0), 
    .debug_Reg1(debug_Reg1),
    .debug_Reg2(debug_Reg2), 
    .debug_Reg3(debug_Reg3), 
    .debug_Reg4(debug_Reg4), 
    .debug_Reg5(debug_Reg5), 
    .debug_Reg6(debug_Reg6), 
    .debug_Reg7(debug_Reg7), 
    .debug_Reg8(debug_Reg8), 
    .debug_Reg9(debug_Reg9), 
    .debug_Reg10(debug_Reg10), 
    .debug_Reg11(debug_Reg11), 
    .debug_Reg12(debug_Reg12), 
    .debug_Reg13(debug_Reg13), 
    .debug_Reg14(debug_Reg14), 
    .debug_Reg15(debug_Reg15)
    );
    
always @(posedge Clk) begin
    if (Rst) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S0: begin
            R_en <= 0;
            W_en <= 0;
            
            if(go)begin
                next_state <= S1;
                end
            else begin
                next_state <= S0;
            end
        end
        
        S1: begin
            //sum <= 0;
            //i <= 0;
            //done <= 0;
            //countodd <= 0;
            //average <= 0
                next_state <= S2;
                    end    
        
        S2: begin
            W_en <= 0;
            R_en <= 1;
            //prevtemp <= temp;
            //temp <= R_Data;
            //sum <= sum + temp;
              if((temp%2)==1)
                next_state <= S3;
            else
                next_state <= S4;    
        end
        
        S3: begin
            next_state <= S4;
        end
        
        S4: begin
          if (i > 0)
            next_state <= S5;
        else 
            next_state <= S6;  
        end
        
        S5: begin
            next_state <= S5A;
        end
        
        S5A: begin
            //R_en <= 0;
            W_en <= 1;
            next_state <= S6;
        end
        
        S6: begin
            //i <= i + 1;
            W_en <= 0;
            if(i<16)
                next_state <= S2;
            else
                next_state <= S7;
        end
        
        S7: begin
            next_state <= S0;
        end
    
    endcase
end

always @(posedge Clk)begin
    case (state)
    
    
        S0:
        begin
        //if(go)
        //    next_state <= S1;
        //else
        //    next_state <= S0;
            done <= 0;
        end
       
        S1:
        begin
            sum <= 0;
            countodd <= 0;
            average <= 0;
            //next_state <= S2;
        end
        
        S2:
        begin
            
            // if prev temp gives bugs initialize it
            // to 0 and if statement if(i>0) then prevtemp = temp
            prevtemp <= temp;
            
            temp <= R_Data;
         /*   
            if((temp%2)==1)
                next_state <= S3;
            else
                next_state <= S4;
                */
        end
        
        S3:
        begin
            countodd <= countodd + 1;
            //next_state <= S4;
        end
        
        S4:
        begin
        //if (i>0)
        //    next_state <= S5;
        //else 
        //    next_state <= S6;
        temp1 <= prevtemp;
        if(!(i== 16))
            sum <= sum + temp;
        end
        
        S5:
        begin
            if (!(i == 16))
                prevtemp <= (temp + temp1)/2;
            
            //next_state <= S6;
        end
        
        S6:
        begin
            i <= i + 1;
        end
        
        S7:
        begin
            average = sum/16;
            done <= 1;
            //next_state<= S0;
        end

    endcase
end

endmodule
