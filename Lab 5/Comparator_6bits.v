`timescale 1ns / 1ps

//if A > B, AgtB = 1, AltB = 0, AeqB = 0
//if A < B, AgtB = 0, AltB = 1, AeqB = 0
//if A == B, AgtB = 0, AltB = 0, AeqB = 1

module Comparator_6bits(A, B, AltB, AeqB, AgtB);
    input [5:0] A, B;
    output AltB, AeqB, AgtB;
    reg AltB, AeqB, AgtB;
        
    //write your code here
    
    always @(A, B) begin
    
    
    if (A>B) begin 
    AgtB <= 1;
    AltB <= 0;
    AeqB <= 0;
    
    end else if (A < B) begin
    AgtB <= 0;
    AltB <= 1;
    AeqB <= 0;
    
    end else begin // A == B
    AgtB <= 0;
    AltB <= 0;
    AeqB <= 1;
    
    
    end
    
    
    end
    
endmodule
