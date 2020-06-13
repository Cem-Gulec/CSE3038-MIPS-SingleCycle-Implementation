module mult2_to_1_3(out, i0,i1,s0);
output [2:0] out;
input [2:0]i0,i1;
input s0;
assign out = s0 ? i1:i0;
endmodule
