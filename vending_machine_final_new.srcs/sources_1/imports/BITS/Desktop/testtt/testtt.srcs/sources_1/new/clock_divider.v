`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 04:56:07
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    output reg clk_out,
    input clk
    );
    reg[26:0] counter=27'd0;
    parameter divisor=27'd12500000;
    always@(posedge clk)
    begin
    counter<=counter+27'd1;
    if(counter>=(divisor-1))
    counter<=27'd0;
    clk_out<=(counter<divisor/2)?1:0;
    end
endmodule