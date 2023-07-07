class seq extends uvm_sequence;
	`uvm_object_utils (seq)
    function new (string name = "sequence");
    	super.new (name);
    endfunction	
endclass
