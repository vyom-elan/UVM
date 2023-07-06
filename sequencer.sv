class packet_seq extends uvm_sequencer #(packet);
	`uvm_sequencer_utils(sequencer)
  function new(string name="name", uvm_component parent=null);
		super.new(name,parent);
		`uvm_update_sequence_lib_and_item(packet);
	endfunction
endclass
