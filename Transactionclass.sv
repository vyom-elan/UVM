class packet extends uvm_sequence_item;
	rand bit[3:0] sa,da;
  rand bit[7:0] payload[$];
  constraint valid{payload.size inside{[2:100]};}
	`uvm_object_utils_begin(packet)
		`uvm_field_int(sa, UVM_ALL_ON)	
		`uvm_field_int(da, UVM_ALL_ON)
		`uvm_field_queue_int(payload, UVM_ALL_ON)
	`uvm_object_utils_end
	function new(string name="packet");
		super.new(name);
	endfunction
endclass
