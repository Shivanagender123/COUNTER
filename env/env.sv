class env;

virtual cif.DRV_MP drv_if;
virtual cif.WRMON_MP wrmon_if;
virtual cif.RDMON_MP rdmon_if;

mailbox #(trans) gen2drv=new();
mailbox #(trans) wrmon2rm=new();
mailbox #(trans) rdmon2sb=new();	
mailbox #(trans) rm2sb=new();

gen g;
drv d;
wrmon w;
rdmon rd;
rm r;
sb s;

	function new(virtual cif.DRV_MP drv_if,
	virtual cif.WRMON_MP wrmon_if,
	virtual cif.RDMON_MP rdmon_if
	);
		this.wrmon_if=wrmon_if;
		this.rdmon_if=rdmon_if;
		this.drv_if=drv_if;
	endfunction

	virtual task build;
		g=new(gen2drv);
		d=new(drv_if,gen2drv);
		w=new(wrmon_if,wrmon2rm);
		rd=new(rdmon_if,rdmon2sb);
		r=new(wrmon2rm,rm2sb);
		s=new(rdmon2sb,rm2sb);
	endtask

 	task start;
		g.start();
		d.start();
		w.start();
		rd.start();
		r.start();
		s.start();
	endtask : start

	task stop();
		wait(s.DONE.triggered);
	endtask : stop 

	task run();
	  	start();
		stop();
		s.report();
	endtask : run
endclass
