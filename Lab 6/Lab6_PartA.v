

/////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
module Lab6_PartA(
    input Rst,
    input Clk,
    input go,
    output reg done,
    output reg [7:0] sum,
    output [7:0] R_Data
);
reg [7:0] temp;
integer i = 0;
reg [13:0] k;

// Register file interface wires
wire [3:0] R_Addr;
wire [7:0] W_Data;
reg R_en, W_en;



// State definitions in decimal
localparam
    S0 = 0,
    S2 = 2,
    S2A = 3,
    S3 = 4,
    S4 = 5,
    S5 = 6,
    S_Done = 7;

reg [3:0] state = S0;
reg [3:0] next_state = S0;

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
 
 // Instantiate the Register File
RegFile16x8 reg_file (
    .R_Addr(i[3:0]),
    .W_Addr(i[3:0]),
    .R_en(R_en),
    .W_en(W_en),
    .R_Data(R_Data),
    .W_Data(temp-48),
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

always @(posedge Clk) begin
    case (state)
        S0: begin
            sum <= 0;
            i <= 0;
        
        end
        S2A: begin
            temp <= R_Data;
        end
        S4: begin
            //if ((temp > 47) && (temp < 58)) begin
                
                sum <= sum + (temp - 48);
            //end
        end
        S5: begin
            i <= i + 1;
            end
            
      
      
    endcase
end

always @(*) begin
    R_en <= 0;
    W_en <= 0;
    case (state)
        S0: begin
            done <= 0;
            if (go) next_state <= S2;
            else next_state <= S0;
        end
        S2: begin
            if (i < 16) next_state <= S2A;
            else next_state <= S_Done;
        end
        S2A: begin
            R_en <= 1;
            next_state <= S3;
        end
        S3: begin
            if((temp > 47) && (temp < 58)) next_state <= S4;
            else next_state <= S5;
        end
        S4: begin
        if ((temp > 47) && (temp < 58)) begin
            W_en <= 1; // Write back if temp was a digit
            end
            next_state <= S5;
            
        end
        S5: begin
            //i <= i + 1;
            next_state <= S2;
        end
        
        S_Done: begin
            done <= 1;
            next_state <= S0;
	end
        
       
    endcase
end

//assign R_Addr = i[3:0];
//assign W_Data = temp;

endmodule

    
    
    










