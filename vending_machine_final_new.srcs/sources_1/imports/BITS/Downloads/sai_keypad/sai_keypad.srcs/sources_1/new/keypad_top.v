`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 15:40:28
// Design Name: 
// Module Name: keypad_top
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


module keypad_top(
    input clk,
    inout [7:0] selrc,//select lines for row and coloumn 
    //output [6:0] seg
    output [3:0] key,
     output keychanged,     
     output [1:0] product,
    output [1:0] change,
    //output reg [1:0] outofstock,
     //money[0]=5/-,money[1]=10/-
    input [1:0] select,
    input [1:0] load,
    input rst
    );
    clock_divider c1(clk_out,clk);
 
    // interconnect wiring
    //wire [3:0] key;
     
    // only using 1 digit of sseg display
    // assign an = 4'b1110;
         
    // instantiate the keypad circuit
    pmod_keypad keypad(
        .clk(clk), 
        .col(selrc[3:0]), 
        .row(selrc[7:4]), 
        .key(key),
          .keychanged(keychanged)
    );
    //push_button p1(key_out,key,clk_out);
    
     vending m1(product,change,clk_out,key,select,load,rst);  
       
endmodule
     
     
     

