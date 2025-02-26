`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 15:39:38
// Design Name: 
// Module Name: counter_n
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


module counter_n
  
    (
    input clk,
    input rst,
    output tick,
    output [25 - 1 : 0] q
    );
     parameter BITS=25;
    // counter register
    reg [25 - 1 : 0] rCounter;
     
     
    // increment or reset the counter
    always @(posedge clk, posedge rst)
        if (rst)
            rCounter <= 0;
        else
            rCounter <= rCounter + 1;
 
    // connect counter register to the output wires
    assign q = rCounter;
    assign tick = (rCounter == 2 ** BITS - 1) ? 1'b1 : 1'b0;
         
endmodule
