class env extends uvm_env;
    `uvm_component_utils (env)
    function new (string name = "environment", uvm_component parent = null);
      super.new (name, parent);
    endfunction
endclass
