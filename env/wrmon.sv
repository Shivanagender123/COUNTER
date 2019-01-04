class wrmon;

virtual cif.WRMON_MP wrmon_if;
mailbox #(trans) mon2rm;

trans data;

	function new(virtual cif.WRMON_MP wrmon_if,mailbox #(trans) mon2rm);
		this.wrmon_if=wrmon_if;
		this.mon2rm=mon2rm;
		this.data=new;
	endfunction

	virtual task monitor;
                @(wrmon_if.wrmon_cb);
		data.reset=wrmon_if.wrmon_cb.reset;
		data.load=wrmon_if.wrmon_cb.load;
		data.ud=wrmon_if.wrmon_cb.ud;
		data.data_in=wrmon_if.wrmon_cb.data_in;
       	endtask

	virtual task start;
		fork
			forever begin
			monitor;
			mon2rm.put(data); end
		join_none
	endtask
endclass


