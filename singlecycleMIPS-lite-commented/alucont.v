module alucont(aluop1,aluop0,f3,f2,f1,f0,gout,link_rt,reg31_rt,jmadd);//Figure 4.12 
input aluop1,aluop0,f3,f2,f1,f0;
output [2:0] gout;
output link_rt, reg31_rt,jmadd;
reg [2:0] gout;
always @(aluop1 or aluop0 or f3 or f2 or f1 or f0)
begin
if(aluop0&aluop1) gout=3'b001;
if(~(aluop1|aluop0))  gout=3'b010;
if(aluop0&(~aluop1))gout=3'b110;
if(aluop1&(~aluop0))//R-type
begin
	if (~(f3|f2|f1|f0))gout=3'b010; 	//function code=0000,ALU control=010 (add)
	if (f1&f3&(~f2)&(~f0))gout=3'b111;			//function code=1010,ALU control=111 (set on less than)
	if (f1&~(f3)&~(f2)&~(f0))gout=3'b110;		//function code=0010,ALU control=110 (sub)
	if (f2&f0&~(f3)&~(f1))gout=3'b001;			//function code=0101,ALU control=001 (or)
	if (f2&~(f0)&~(f1)&~(f3))gout=3'b000;		//function code=0100,ALU control=000 (and)
	if (~(f3)&~(f2)&f1&~(f0))gout=3'b011;	//function code=0010,ALU control=011 (srl)
	if (~(f3)&~(f2)&f0&~(f1))gout=3'b010;	//function code=0001,ALU control=010 (does add, but instruction=jmadd)
end
end
assign link_rt  =  ((aluop1)&(~aluop0)) & ( (~(f3)&~(f2)&f0&~(f1)) );
assign reg31_rt =  ((aluop1)&(~aluop0)) & ( (~(f3)&~(f2)&f0&~(f1)) );
assign jmadd    =  ((aluop1)&(~aluop0)) & (~(f3)&~(f2)&f0&~(f1)); 

endmodule
