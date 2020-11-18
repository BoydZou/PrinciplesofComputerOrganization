`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 16:36:38
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(input [4:0] IDReg_Rd,IFReg_Rs,IFReg_Rt,EXReg_Rd,              //IDReg_Rd ָѡ����Ŀ���ַ
                  input ID_MemRead,ID_RegWrite,EX_RegWrite,PCSrc,Jump,EX_MemRead,Branch,
                  output reg PCWrite,IFflush,ctrflush,IFWrite,Branch_1
    );
    
               always@(*) begin
                 
                   if (PCSrc || (!Jump))
                             IFflush  = 1'b1; 
                             else  IFflush = 1'b0;      //beq��jump->flush                        
                               
                  PCWrite = 1'b1; ctrflush = 1'b0;IFWrite = 1'b1;Branch_1=1'b1;
               if(Branch)//beq ð��
                begin
                  if((ID_RegWrite && (IDReg_Rd == IFReg_Rs || IDReg_Rd == IFReg_Rt)) ||
                  (EX_MemRead && EX_RegWrite && (EXReg_Rd == IFReg_Rs || EXReg_Rd == IFReg_Rt)) )
                    begin
                    PCWrite = 1'b0;  IFWrite = 1'b0;   ctrflush =1'b1; Branch_1=1'b0;                
                    end
                end  
          
            if (ID_MemRead &&
                        ((IDReg_Rd == IFReg_Rs) || (IDReg_Rd == IFReg_Rt)))     begin PCWrite = 1'b0; ctrflush = 1'b1; IFWrite = 1'b0; end    //lw-use �࣬��bubble
   end
   endmodule
                   
                  /*if (ID_MemRead &&
                        ((IDReg_Rd == IFReg_Rs) || (IDReg_Rd == IFReg_Rt)))     begin PCWrite = 1'b0; ctrflush = 1'b1; IFWrite = 1'b0; end    //lw-use �࣬��bubble
                        
                  if ((!ID_MemRead) && ID_RegWrite && Branch 
                        && ((IDReg_Rd == IFReg_Rs) || (IDReg_Rd == IFReg_Rt)))  begin PCWrite = 1'b0; ctrflush = 1'b1; IFWrite = 1'b0; Branch_1 = 1'b0; end //aluָ��->beq��  bubble
                        
                  if (ID_MemRead && Branch &&
                        ((IFReg_Rs == IDReg_Rd) || (IFReg_Rt == IDReg_Rd)))     begin PCWrite = 1'b0; ctrflush = 1'b1; IFWrite = 1'b0; Branch_1 = 1'b0; end //lw->beq �� bubble
                         else if (EX_MemRead && Branch &&
                        ((IFReg_Rs == EXReg_Rd) || (IFReg_Rt == EXReg_Rd)))     begin PCWrite = 1'b0; ctrflush = 1'b1; IFWrite = 1'b0; Branch_1 = 1'b0; end  //lw->beq �� bubble
                     
               end    */ 

