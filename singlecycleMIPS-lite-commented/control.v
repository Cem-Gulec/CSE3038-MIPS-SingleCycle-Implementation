module control(in,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2, baln,link,reg31,jump,jpc);
input [5:0] in;
output regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,baln,link,reg31,jump,jpc;
wire rformat,lw,sw,beq,ori,srl,baln_inst,jpc_inst;

assign rformat=~|in;
assign lw=in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);
assign ori=(~in[5])&(~in[4])&in[3]&in[2]&(~in[1])&in[0];
assign srl=~|in;
assign baln_inst=(~in[5])&in[4]&in[3]&(~in[2])&in[1]&in[0];
assign jpc_inst=(~in[5])&in[4]&in[3]&in[2]&in[1]&(~in[0]);

assign regdest=rformat|srl;
assign alusrc=lw|sw|ori;
assign memtoreg=lw;
assign regwrite=rformat|lw|ori|srl|baln|jpc_inst;
assign memread=lw;
assign memwrite=sw;
assign branch=beq|baln|jpc_inst;
assign aluop1=rformat|ori|srl|jpc_inst;
assign aluop2=beq|ori|jpc_inst;
assign baln=baln_inst;
assign link=baln_inst|jpc_inst;
assign reg31=baln_inst;
assign jump=baln_inst|jpc_inst;
assign jpc=jpc_inst;
endmodule
