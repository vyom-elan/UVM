class environment extends uvm_env;
  `uvm_component_utils(environment)
  producer p;
  consumer c;    
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  virtual function void build();
    super.build;
    p =  producer::type_id::create("p",this);
    c = consumer::type_id::create("c",this);
  endfunction
  virtual function void connect();
    p.put_port.connect(c.put_export);
  endfunction
endclass
