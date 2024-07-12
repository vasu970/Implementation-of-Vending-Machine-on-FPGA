`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2023 00:18:34
// Design Name: 
// Module Name: delayGen
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


module delayGen(
    input clock,
    input delayEn,
    output reg delayDone
    );
    
reg [17:0] counter;    

always @(posedge clock)
begin
    if(delayEn & counter!=200000)
        counter <= counter+1;
    else
        counter <= 0;
end

always @(posedge clock)
begin
    if(delayEn & counter==200000)
        delayDone <= 1'b1;
    else
        delayDone <= 1'b0;
end
    
endmodule
