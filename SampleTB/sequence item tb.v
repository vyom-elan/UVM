//Sequence item

class seqitem extends uvm_sequence_item
	rand bit[`addwidth-1:0] addr;
	rand bit[`datawidth-1:0] wdata;
	rand bit wr;
	bit[`datawidth-1:0] rdata;
	`uvm_objects_utils_begin(reg_item)
		`uvm_field_int(addr, UVM_DEFAULT)
		`uvm_field_int(wdata, UVM_DEFAULT)
		`uvm_field_int(rdata, UVM_DEFAULT)
		`uvm_field_int(wr, UVM_DEFAULT)
	`uvm_objct_utils_end
	virtual function string convert2str();
		return $sformatf("addr=0x%0h wr=0x%0h wdata=0x%0h rdata=0x%0h", addr, wr, wdata, rdata);
	endfunction
	function new(string name = "sequence item");
		super.new(name);
	endfunction
endclass