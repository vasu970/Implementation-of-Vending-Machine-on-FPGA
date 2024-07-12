`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 05:09:21
// Design Name: 
// Module Name: push_button
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


module push_button(
    output pb_out,
    input pb_in,
    input clk
    );
    wire q1,q2,q2bar;
    clock_divider m1(clk_out,clk);
    d_flipflop m2(q1,pb_in,clk_out);
    d_flipflop m3(q2,q1,clk_out);
    assign q2bar=~q2;
    assign pb_out=q1&q2bar;
endmodule
