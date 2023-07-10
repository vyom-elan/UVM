class Packet extends uvm_object;
  rand bit [3:0] m_addr;
  rand bit 		 m_wr;
  
  `uvm_object_utils_begin(Packet)
  	`uvm_field_int(m_addr, 	UVM_DEFAULT)
  	`uvm_field_int(m_wr,		UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "Packet");
    super.new(name);
  endfunction
endclass

class pack_test extends uvm_test;
  `uvm_component_utils(pack_test)
  function new(string name = "pack_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  bit m_bits[];//arrays to store packed data output from different pack functions
  byte unsigned		m_bytes[];
  int  unsigned		m_ints[];
  
  virtual function void build_phase(uvm_phase phase);
    Packet m_pkt = Packet::type_id::create("Packet");
    m_pkt.randomize();
    m_pkt.print();
    m_pkt.pack(m_bits);
    m_pkt.pack_bytes(m_bytes);
    m_pkt.pack_ints(m_ints); 
    `uvm_info(get_type_name(), $sformatf("m_bits=%p", m_bits), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("m_bytes=%p", m_bytes), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("m_ints=%p", m_ints), UVM_LOW)
  endfunction
endclass

module tb;
	initial begin
		run_test("pack_test");
	end
endmodule
