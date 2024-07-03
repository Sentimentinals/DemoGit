module comparator2bit(a, b, a_lt_b, a_eq_b, a_gt_b);
 input [1:0]a;
 input [1:0]b;
 output a_lt_b, a_eq_b, a_gt_b;
 wire net1,net2,net3,net4,net5,net6;

 //a=b
xor inst1(net1,a[0],b[0]);
xor inst2(net2,a[1].b[1]);
and inst9(a_eq_b,net1,net2);

//a<b
and inst3(net3,~a[1],b[1]);
and inst4(net4,~a[0],b[1],b[0]);
and inst5(net5,~a[1],~a[0],b[0]);

//output
or inst7(a_lt_b,net3,net4,net5);

//a>b
or inst6(net6,a_lt_b,a_eq_b);
not inst8(a_gt_b,net6);

endmodule

module comparator4bit(a, b, a_lt_b, a_eq_b, a_gt_b);
 input [3:0]a;
 input [3:0]b;
 output a_lt_b, a_eq_b, a_gt_b;
 wire c_high_gt,c_high_lt,c_high_eq;
 wire c_low_gt,c_low_lt,c_low_eq;
 wire net1,net2,net3,net4;
comparator2bit high(.a([3:2]a),.b([3:2]b),.a_lt_b(c_high_lt), .a_eq_b(c_high_eq), .a_gt_b(c_high_gt));
comparator2bit high(.a([1:0]a),.b([1:0]b),.a_lt_b(c_low_lt), .a_eq_b(c_low_eq), .a_gt_b(c_low_gt));

and inst1 (net1, c_high_eq, c_low_gt );//a>b
or inst3 (a_gt_b, net1, c_high_gt);

and inst2 (net2, c_high_eq, c_low_lt );//a<b
or inst4 (a_gt_b, net1, c_high_lt);

and inst5 (c_high_eq,c_low_eq);		//a=b
endmodule
