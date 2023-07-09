class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  scoreboard	sb0; 	
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb0 = scoreboard::type_id::create("sb0", this);
  endfunction  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
endclass
