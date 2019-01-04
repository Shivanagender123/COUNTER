class sb;

event DONE;
int data_verified;
string sa;

trans rm_data;
trans mon_data;
trans cov_data;

mailbox #(trans) mon2sb;
mailbox #(trans) rm2sb;

	covergroup cov;
	option.per_instance=1;
	DA: coverpoint cov_data.data_in; 
	LO: coverpoint cov_data.load {bins b={1};}
        CI: coverpoint cov_data.ud; 
        CR: cross DA,LO,CI ;
        endgroup:cov

	function new(mailbox #(trans) mon2sb,
	mailbox #(trans) rm2sb
	);
		this.cov=new;
		this.mon2sb=mon2sb;
		this.rm2sb=rm2sb;
	endfunction

	virtual task check(output string s);
		if(rm_data.data_out!=mon_data.data_out)
			begin
			s="WRONG OUTPUT";
			$display(s);
			$finish;
			end
		else
			s="SUCESSFULLY COMPARED";
                cov_data=rm_data;
		cov.sample;
	endtask
	
	virtual task start;
		fork
			forever begin
			mon2sb.get(mon_data);
			rm2sb.get(rm_data);
			check (sa);
			$display(sa);
      			data_verified++;
			if(data_verified==(number_of_transactions+2))
				->DONE;
       			end
		join_none
	endtask	
	function void report();
		$display(" ------------------------ SCOREBOARD REPORT ----------------------- \n ");
		$display("  %0d Read Data Verified \n",
               	data_verified);
		$display(" ------------------------------------------------------------------ \n ");
	endfunction: report


endclass	
