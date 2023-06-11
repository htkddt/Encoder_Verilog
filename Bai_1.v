module Bai_1 (clk, encA, encB, rst, mode, D, x1, x2, x4);
input clk, encA, encB, rst;
input [2:0] mode;
output x1, x2, x4;
output reg [15:0] D=16'h8000;
reg pre_encA=0, pre_encB=0, x1, x2, x4;
always @(posedge clk)
begin
pre_encA <= encA;
pre_encB <= encB;
case (mode)
	1: 
	begin
		if(rst == 1)
			D = 16'h8000;
		else if({pre_encA, encA} == 2'b01)
		begin
			x1 = 1;
			begin 
				if(encB == 0)
					D = D + 1;
				else
					D = D - 1;
			end
		end
		else 
			x1 = 0;
	end
	2:
	begin
		if(rst == 1)
			D = 16'h8000;
		else if(pre_encA != encA)
		begin
			x2 = 1;
			begin
				if({pre_encA, encA, encB} == 3'b010 || {pre_encA, encA, encB} == 3'b101)
					D = D + 1;
				else if({pre_encA, encA, encB} == 3'b011 || {pre_encA, encA, encB} == 3'b100)
					D = D - 1;
			end
		end
		else
			x2 = 0;
	end
	4:
	begin
		if(rst == 1)
			D = 16'h8000;
		else
			case ({pre_encA, encA, pre_encB, encB})
				4'b0100, 4'b1011, 4'b1101, 4'b0010: 
					begin
						D = D + 1;
						x4 = 1;
					end
				4'b0111, 4'b1000, 4'b1110, 4'b0001: 
					begin
						D = D - 1;
						x4 = 1;
					end
				default: x4 = 0;
			endcase
	end
	default: D = 16'h8000;
endcase
end
endmodule
	