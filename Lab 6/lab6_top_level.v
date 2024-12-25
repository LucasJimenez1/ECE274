module Lab6_toplevel(
    input CLK100MHZ,
    input BTNU,  // Reset
    output [0:0] LED,  // LED output
    output CA, CB, CC, CD, CE, CF, CG,  // 7-segment display outputs
    output [7:0] AN  // Digit enable
);

    // Instantiate ClkDiv
    wire Clk10kHz;
    ClkDiv clk_divider(.Clk(CLK100MHZ),.Rst(0), .ClkOut(Clk10kHz));

    // Instantiate Lab6_PartA
    wire [7:0] sum;
    wire [7:0] R_Data;
    wire [7:0] D;
    //wire done;
    Lab6_partB part_b(.Rst(BTNU), .Clk(Clk10kHz), .go(1), .done(LED[0]), .sum(sum), .R_Data(R_Data));
    
    //module mux(s, I1, I0, D);
    mux mux2x1(LED[0], R_Data, sum, D);  

    // Connect the sum to the display
    // Assume TwoDigitDisplay and SevenSegment are modules that you will add
    
    //module TwoDigitDisplay(CLK100MHZ, SW, CA,CB,CC,CD,CE,CF,CG,AN);
    TwoDigitDisplay two_digit(CLK100MHZ, D, CA, CB, CC, CD, CE, CF, CG, AN);
    // Connect the done signal to the LED
    //assign LED[0] = done;

endmodule

