class rdmon;

virtual cif.RDMON_MP rdmon_if;
mailbox #(trans) mon2sb;

trans data_r;

	function new(virtual cif.RDMON_MP rdmon_if,mailbox #(trans) mon2sb);
		this.rdmon_if=rdmon_if;
		this.mon2sb=mon2sb;
		this.data_r=new;
	endfunction

	virtual task monitor;
                @(rdmon_if.rdmon_cb);
		data_r.data_out=rdmon_if.rdmon_cb.data_out;
	      	endtask

	virtual task start;
		fork
			forever begin
			monitor;
			mon2sb.put(data_r); end
		join_none
	endtask
endclass

