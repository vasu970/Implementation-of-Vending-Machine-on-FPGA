`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 15:37:57
// Design Name: 
// Module Name: pmod_keypad
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


module pmod_keypad(
    input clk,
    input [3:0] row,
    output reg [3:0] col,
    output reg [3:0] key,
     output reg keychanged
    );
 
    // counter bits
    //localparam BITS = 20;
     
    // number of clk ticks for 1ms: 50Mhz / 1000
    localparam ONE_MS_TICKS = 50000000 / 5000;
     
    // settle time of 1 us = 100Mhz / 1000000
    localparam SETTLE_TIME = 50000000 / 500000;
     
    wire [25 - 1 : 0] key_counter;
    reg rst = 1'b0;
     
     
    // instantiate a 20-bit counter circuit
    counter_n counter(
        .clk(clk),
        .rst(rst),
        .q(key_counter)
    );
     
    // check on each clock
    always @ (posedge clk)
    begin
        case (key_counter)
            0: begin
                rst <= 1'b0;
                     keychanged<=0;
                     end
                 
            ONE_MS_TICKS:
                col <= 4'b0111;
 
            ONE_MS_TICKS + SETTLE_TIME:
            begin
                case (row)
                    4'b0111:
                              begin
                        key <= 4'b0001; // 1
                                keychanged<=1;
                                end
                    4'b1011:
                              begin
                        key <= 4'b0100; // 4
                                keychanged<=1;
                                end
                    4'b1101:
                        begin
                                key <= 4'b0111; // 7
                                keychanged<=1;
                                end
                    4'b1110:
                        begin
                                key <= 4'b0000; // 0
                                keychanged<=1;
                                end
                endcase
            end
             
            2 * ONE_MS_TICKS:
                col <= 4'b1011;
             
            2 * ONE_MS_TICKS + SETTLE_TIME:
            begin
                case (row)
                    4'b0111:
                        begin
                                key <= 4'b0010; // 2
                                keychanged<=1;
                                end
                    4'b1011:
                        begin
                                key <= 4'b0101; // 5
                                keychanged<=1;
                                end
                    4'b1101:
                        begin
                                key <= 4'b1000; // 8
                                keychanged<=1;
                                end
                    4'b1110:
                        begin
                                key <= 4'b1111; // F
                                keychanged<=1;
                                end
                endcase
            end
 
            // 3ms
            3 * ONE_MS_TICKS:
                col <= 4'b1101;
 
            3 * ONE_MS_TICKS + SETTLE_TIME:
            begin
                case (row)
                    4'b0111:
                        begin
                                key <= 4'b0011; // 3
                                keychanged<=1;
                                end
                    4'b1011:
                        begin
                                key <= 4'b0110; // 6
                                keychanged<=1;
                                end
                    4'b1101:
                        begin
                                key <= 4'b1001; // 9
                                keychanged<=1;
                                end
                    4'b1110:
                        begin
                                key <= 4'b1110; // E
                               keychanged<=1;
                                end
                endcase
            end
             
            // 4ms
            4 * ONE_MS_TICKS:
                col <= 4'b1110;
             
            4 * ONE_MS_TICKS + SETTLE_TIME:
            begin
                case (row)
                    4'b0111:
                        begin
                                key <= 4'b1010; // A
                                keychanged<=1;
                                end
                    4'b1011:
                        begin
                                key <= 4'b1011; // B
                                keychanged<=1;
                                end
                    4'b1101:
                        begin
                                key <= 4'b1100; // C
                                keychanged<=1;
                                end
                    4'b1110:
                        begin
                                key <= 4'b1101; // D
                                keychanged<=1;
                                end
                endcase
             end
                500 * ONE_MS_TICKS:// reset the counter                
                rst <= 1'b1;
                
        endcase
    end
     
endmodule 