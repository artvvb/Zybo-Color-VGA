`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2018 11:58:30 AM
// Design Name: 
// Module Name: vga_to_gpio_interface
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


module vga_to_gpio_interface #(
    parameter NUM_COLOR_BITS = 12
) (
    input wire clk,
    input wire eof_flag,
    
    input wire [11:0] n_pixel_x,
    input wire [11:0] n_pixel_y,
    input wire n_pixel_valid,
    
    output reg [NUM_COLOR_BITS-1:0] n_pixel_color = 0,
    
    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO TRI_O" *)
    input wire [NUM_COLOR_BITS-1:0] gpio_i
);
    reg [NUM_COLOR_BITS-1:0] color;
    always@(posedge clk)
        if (eof_flag == 1)
            color <= gpio_i;
    wire [11:0] temp = n_pixel_x - 448;
    always@(posedge clk)
        if (n_pixel_valid == 0)
            n_pixel_color = 0;
        else if (n_pixel_y >= 952 && n_pixel_x >= 448 && n_pixel_x < 1472)
            n_pixel_color = {{5{temp[9]}}, {6{temp[8]}}, {5{temp[7]}}};
        else if (n_pixel_y >= 951 && n_pixel_x >= 447 && n_pixel_x < 1473)
            n_pixel_color = 0;
        else if (n_pixel_y >= 950 && n_pixel_x >= 446 && n_pixel_x < 1474)
            n_pixel_color = 16'hFFFF;
        else
            n_pixel_color = color;
endmodule
