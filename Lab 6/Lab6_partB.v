module Lab6_partB(
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

// Instantiate the Register File
RegFile16x8 reg_file (
    .R_Addr(i[3:0]),
    .W_Addr(i[3:0]),
    .R_en(R_en),
    .W_en(W_en),
    .R_Data(R_Data),
    .W_Data(temp-48),
    .Clk(Clk),
    .Rst(Rst)
);

// State definitions in decimal
localparam
    S0 = 0,
    S2 = 2,
    S2A = 3,
    S3 = 4,
    S4 = 5,
    S5 = 6,
    S_Done = 7,
    S_Wait = 8,
    S_Disp = 9,
    S_Wait2 = 10,
    S_Disp2 = 11,
    S_Disp_done = 12;

reg [3:0] state = S0;
reg [3:0] next_state = S0;


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
            
            
    S_Done: begin
    i <= 0;
    k <= 0;
    
    end        
            
    S_Wait: begin   
    k <= k + 1;
    end     
    
    S_Disp: begin
    k <= 0;
    end
    
    S_Wait2: begin
    k <= k + 1;
    end
    
    S_Disp2: begin
    i <= i + 1;
    k <= 0;
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
            done <= 0;
            next_state <= S_Wait; // Transition to wait state
        end
        

        S_Wait: begin
            // Wait state logic to be added here
            // For now, transition immediately to S_Disp
            done <= 0;
            
            if ( k < 10000) begin
            next_state <= S_Wait;
            end
            else if ( !(k < 10000)) begin
            next_state <= S_Disp;
            end
        end
        
        S_Disp: begin
            // Display sum logic to be added here
            // For now, transition immediately to S_Wait2
            done <= 1;
            R_en <= 1;
            next_state <= S_Wait2;
            
        end
        S_Wait2: begin
            // Second wait state logic
            
            done <= 1;
            R_en <= 1;
            
            if ( k < 10000) begin
            next_state <= S_Wait2;
            end
            
            else if ( !(k < 10000)) begin
            next_state <= S_Disp2;
            end           
            
        end
        
        S_Disp2: begin
        done <= 1;
        R_en <= 1;
        if ( i < 14) begin
        next_state <= S_Wait2;
        end    
        else if (!(i < 14)) begin
        next_state <= S_Disp_done;
        end
        
        end
        
        S_Disp_done: begin
            // Complete the display cycle
            done <= 1;
            R_en <= 1; 
            next_state <= S_Disp_done; // Go back to initial state
        end
        
        
       
    endcase
end

//assign R_Addr = i[3:0];
//assign W_Data = temp;

endmodule