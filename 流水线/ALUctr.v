`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/03 16:26:51
// Design Name: 
// Module Name: ALUctr
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


module ALuctr(
    input [5:0] fun,
    input [2:0] ALUOp,
    output reg [3:0] ALUctr
    );
    always@(fun or ALUOp)
    begin
    if(ALUOp==3'b010)
    case(fun)
    6'b100000 : ALUctr <= 4'b0010;         //add
    6'b100010 : ALUctr <= 4'b0110;        //sub
    6'b100100 : ALUctr <= 4'b0000;        //and
    6'b100101 : ALUctr <= 4'b0001;        //or
    6'b101010 : ALUctr <= 4'b0111;        //slt
    6'b101011 : ALUctr <= 4'b0011;        //sltu
    endcase
    else 
    case(ALUOp)
    3'b000 : ALUctr <= 4'b0010;               //sw,lw
    3'b011 : ALUctr <= 4'b0010;               //addiu
    3'b100 : ALUctr <= 4'b0001;               //ori
    3'b101 : ALUctr <= 4'b0000;              //andi
    3'b110 : ALUctr <= 4'b0100;              //lui
    endcase
    end
endmodule
