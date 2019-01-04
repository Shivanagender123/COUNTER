class trans;

rand bit reset;
rand bit load;
rand bit ud;
rand bit [3:0]data_in;
logic [3:0]data_out;
static int trans_id;
static int no_of_trans;
static int no_of_load_trans;
static int no_of_count_trans;

constraint d {data_in inside{[0:15]};}
constraint r {reset inside {0};}
	function void display(input string message);
		$display("=============================================================");
		$display("%s",message);
		if(message=="\tRANDOMIZED DATA") begin
			$display("\t_______________________________");
			$display("\tTransaction No. %d",trans_id);
			$display("\tload Transaction No. %d", no_of_load_trans);
			$display("\tcount Transaction No. %d", no_of_count_trans);
			$display("\t_______________________________");
		end
		$display("\tReset=%d, load=%d",reset,load);
		$display("\tcount=%d, data_in=%d",ud, data_in);
		$display("\tData_out= %d",data_out);
		$display("=============================================================");
	endfunction: display
       function void post_randomize();
		if(this.reset)
			no_of_trans++;
	       else if(this.load)
                    begin
			no_of_trans++;
			no_of_load_trans++;
                    end
		else 
                    begin
			no_of_trans++;
                       	no_of_count_trans++;
                    end
		this.display("\tRANDOMIZED DATA");

	endfunction:post_randomize
endclass:trans





