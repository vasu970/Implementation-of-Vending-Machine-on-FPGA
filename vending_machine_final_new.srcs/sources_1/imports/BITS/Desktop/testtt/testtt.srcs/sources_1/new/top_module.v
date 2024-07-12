`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 05:19:04
// Design Name: 
// Module Name: top_module
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


module top_module(
    output [1:0] product,
    output [1:0] change,
    output [1:0] outofstock,
    input clk,
//    input [1:0] money, 
    input [1:0] select,
    input [1:0] load,
     inout [7:0] selrc,//select lines for row and coloumn 
     input enabl,
    //oled interface
      output [3:0] key,
     output keychanged,   
output oled_spi_clk,
output oled_spi_data,
output oled_vdd,
output oled_vbat,
output oled_reset_n,
output oled_dc_n
    );
    reg [3:0] s0=15;
    reg [3:0] s1=15;
//          reg [3:0] key;
//    wire [1:0] money_out;
    clock_divider m7(clk_out,clk);
//    push_button m4(money_out[0],money[0],clk);
    push_button m5(enabl_out,enabl,clk);

     vending_machine1 f7(product,change,outofstock,clk_out,enabl_out*key,select,load);
 reg [503:0] myString;
 localparam StringLen = 63;
 
 integer i, o_als,k1,k2,o1,o2;
 
 always@(posedge k1)
 s0=s0-1;
 always@(posedge k2)
 s1=s1-1;
// integer m1;
//  always @(* )
// begin
//   m1=load[0];
//   end
//  always@(posedge m1)
// s0=s0+7; 
//  always@(posedge load[1])
// s1=s1+7; 
always @(change==2'b01||change==2'b10 )
    o_als = change;
always @(outofstock==2'b01||outofstock==2'b10 )
begin
   o1 = outofstock[0];
        o2 = outofstock[1];
        end
 always @(* )
 begin
    k1 = product[0];
        k2 = product[1];
    end
    
// always @(product[1]==1 && select==2 )
//    i = 2;

//always @(*)
// begin
// if(k1==1)
// s0=s0-1;
// if(k2==1)
// s1=s1-1;
//end

reg [2:0] count_stock=0;

always @(*)
 begin
// if(o_als==1&& k1!=1 && k2!=1)
// myString = "change IS 5                                                    ";
// else
//if(k1==1
if(load==2'b01)
begin
myString = "Biscuits loaded                                                ";
//s0=s0+7;
end
else if(load==2'b10)
begin
myString = "Chocolates loaded                                              ";
//s1<=7;
end
else if(o1==1 && select==2'b01)
myString = "out of stock                                                   ";
else if(o2==1 && select==2'b10)
myString = "out of stock                                                   ";
 else if(k1==1 && o_als==0 && select==2'b01 )
 begin
 myString = "biscuit                                                        ";
// count_stock=count_stock+1;
//  if(count_stock==1)
//  s0=s0-1;
  end
  else if(k2==1 && o_als==0 && select==2'b10)
  begin
 myString = "Chocolate                                                      ";
// s1=s1-1;
 end
  else if(k1==1 && o_als==1 && select==2'b01)
  begin
 myString = "BISCUIT,            change 5                                   ";
//   s0=s0-1;
   end
    else if(k2==1 && o_als==1 && select==2'b10)
  begin
 myString = "CHOCOLATE,           change 5                                  ";
//s1=s1-1;
end
else if( select==2'b01)
begin
case(s0)
15:myString = "Stock 7                                                        ";
14:myString = "Stock 6                                                        ";
13:myString = "Stock 5                                                        ";
12:myString = "Stock 4                                                        "; 
11:myString = "Stock 3                                                        ";
10:myString = "Stock 2                                                        "; 
9:myString = "Stock 1                                                        ";
8:myString = "Stock 7                                                        ";
7:myString = "Stock 6                                                        ";
6:myString = "Stock 5                                                        ";
5:myString = "Stock 4                                                        "; 
4:myString = "Stock 3                                                        ";
3:myString = "Stock 2                                                        "; 
2:myString = "Stock 1                                                        ";
endcase
end
else if( select==2'b10)
begin
case(s1)
15:myString = "Stock 7                                                        ";
14:myString = "Stock 6                                                        ";
13:myString = "Stock 5                                                        ";
12:myString = "Stock 4                                                        "; 
11:myString = "Stock 3                                                        ";
10:myString = "Stock 2                                                        "; 
9:myString = "Stock 1                                                        ";
7:myString = "Stock 7                                                        ";
6:myString = "Stock 6                                                        ";
5:myString = "Stock 5                                                        ";
4:myString = "Stock 4                                                        "; 
3:myString = "Stock 3                                                        ";
2:myString = "Stock 2                                                        "; 
1:myString = "Stock 1                                                        ";
endcase
end
  else
 myString = "VENDING MACHINE                                                ";
  end
  reg [1:0] state;
 reg [7:0] sendData;
 reg sendDataValid;
 integer byteCounter;
 wire sendDone;
 
 localparam IDLE = 'd0,
            SEND = 'd1,
            DONE = 'd2;
 
  
  
 always @(posedge clk)
 begin
    if(reset)
    begin
        state <= IDLE;
        byteCounter <= StringLen;
        sendDataValid <= 1'b0;
    end
    else
    begin
        case(state)
            /*INTERMEDIATE:begin
                    if(myStringsm != myString)
                    begin
                    myStringsm <= myString;
                    state <= IDLE;
                    end
                    else
                    state <= INTERMEDIATE;
                    end*/
            IDLE:begin
                if(!sendDone)
                begin
                    sendData <= myString[(byteCounter*8-1)-:8];
                    sendDataValid <= 1'b1;
                    state <= SEND;
                end
            end
            SEND:begin
                if(sendDone)
                begin
                    sendDataValid <= 1'b0;
                    byteCounter <= byteCounter-1;
                    if(byteCounter != 1)
                        state <= IDLE;
                    else
                        state <= DONE;
                end
            end
            DONE:begin
                state <= IDLE;
            end
        endcase
    end
 end
 
       pmod_keypad keypad(
        .clk(clk), 
        .col(selrc[3:0]), 
        .row(selrc[7:4]), 
        .key(key),
          .keychanged(keychanged)
    ); 
    
oledControl OC(
    .clock(clk), //100MHz onboard clock
    .reset(reset),
    //oled interface
    .oled_spi_clk(oled_spi_clk),
    .oled_spi_data(oled_spi_data),
    .oled_vdd(oled_vdd),
    .oled_vbat(oled_vbat),
    .oled_reset_n(oled_reset_n),
    .oled_dc_n(oled_dc_n),
    //
    .sendData(sendData),
    .sendDataValid(sendDataValid),
    .sendDone(sendDone)
        );   
        endmodule
