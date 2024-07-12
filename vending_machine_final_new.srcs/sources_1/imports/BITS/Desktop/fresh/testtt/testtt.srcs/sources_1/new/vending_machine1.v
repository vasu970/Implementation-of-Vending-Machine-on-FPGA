`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 14:12:33
// Design Name: 
// Module Name: vending_machine1
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


module vending_machine1(
    output reg [1:0] product,
    output reg [1:0] change,
    output reg [1:0] outofstock,
//     output reg [2:0] stock0,
    input clk,
    input [3:0] money, //money[0]=5/-,money[1]=10/-
    input [1:0] select,
    input [1:0] load
    );
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
    reg [1:0] state; 
//    initial
  reg [2:0] stock0=7; //biscuit=15/-
    reg [2:0] stock1=7; //chips=20/-
    
    always@(posedge clk)
    begin    
    if(select==2'b01 && stock0>=1)
    begin 
    product[1]<=0;
    case(state)
    s0:if(money==5)
       begin
       change<=0;
       product[0]<=0;
       state<=s1;       
       end
       else if(money==10)
       begin
       change<=0;
       product[0]<=0;
       state<=s2;       
       end
     s1:if(money==5)
       begin
       change<=0;
       product[0]<=0;
       state<=s2;       
       end
       else if(money==10)
       begin
       change<=0;
       product[0]<=1;
       stock0<=stock0-1;
       state<=s0;       
       end
      s2:if(money==5)
       begin
       change<=0;
       product[0]<=1;
       stock0<=stock0-1;
       state<=s0;       
       end
       else if(money==10)
       begin
       change<=2'b01;
       product[0]<=1;
       stock0<=stock0-1;
       state<=s0;       
       end
      default:begin
              change<=0;
              state<=0; 
              end
       
     endcase   
     end
     
    if(select==2'b10 && stock1>=1)
    begin 
    product[0]<=0;
    case(state)
    s0:if(money==5)
       begin
       change<=0;
       product[1]<=0;
       state<=s1;       
       end
       else if(money==10)
       begin
       change<=0;
       product[1]<=0;
       state<=s2;       
       end
     s1:if(money==5)
       begin
       change<=0;
       product[1]<=0;
       state<=s2;       
       end
       else if(money==10)
       begin
       change<=0;
       product[1]<=0;
       state<=s3;       
       end
      s2:if(money==5)
       begin
       change<=0;
       product[1]<=0;
       state<=s3;       
       end
       else if(money==10)
       begin
       change<=0;
       product[1]<=1;
       stock1<=stock1-1;
       state<=s0;       
       end
      s3:if(money==5)
       begin
       change<=0;
       product[1]<=1;
       stock1<=stock1-1;
       state<=s0;       
       end
       else if(money==10)
       begin
       change<=2'b01;
       product[1]<=1;
       stock1<=stock1-1;
       state<=s0;       
       end
      default:begin
              change<=0;
              state<=0; 
              end
     endcase
    end
    if(stock0==0)
    begin
    outofstock[0]<=1;
    product[0]<=0;
    end
    else
    outofstock[0]<=0;
    
    if(stock1==0)
    begin
    outofstock[1]<=1;
    product[1]<=0;
    end
    else
    outofstock[1]<=0; 
    
    case(load)
    2'b01:stock0<=7;
    2'b10:stock1<=7;    
    endcase
    
    end    
endmodule
