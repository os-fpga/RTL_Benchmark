#!/usr/bin/perl -w

package ProNOC;


#add home dir in perl 5.6
use FindBin;
use lib $FindBin::Bin;


use Glib qw/TRUE FALSE/;


use Gtk2;
use strict;
use warnings;

use Getopt::Long;


use lib 'lib/perl';
require "widget.pl"; 
require "interface_gen.pl";
require "ip_gen.pl";
require "soc_gen.pl";
require "mpsoc_gen.pl";
require "emulator.pl";
require "simulator.pl";
require "trace_gen.pl";
#require "network_maker.pl";

use File::Basename;


our $VERSION = '1.9.1'; 
our $END_YEAR= "2019";


sub main{
	# check if envirement variables are defined
	my $project_dir	  = get_project_dir(); #mpsoc dir addr
	my $paths_file= "$project_dir/mpsoc/perl_gui/lib/Paths";

	if (-f 	$paths_file){#} && defined $ENV{PRONOC_WORK} ) {
		my $paths= do $paths_file;
		main_window();
		
	}
	else{
		setting(1);
	}
	
}

sub set_path_env{
	my $project_dir	  = get_project_dir(); #mpsoc dir addr
	my $paths_file= "$project_dir/mpsoc/perl_gui/lib/Paths";
	my $paths= do $paths_file;

	my $pronoc_work = $paths->object_get_attribute("PATH","PRONOC_WORK");	
	my $quartus = $paths->object_get_attribute("PATH","QUARTUS_BIN");
	my $modelsim = $paths->object_get_attribute("PATH","MODELSIM_BIN");

	$ENV{'PRONOC_WORK'}= $pronoc_work if( defined $pronoc_work);
	$ENV{'QUARTUS_BIN'}= $quartus if( defined $quartus);
	$ENV{'MODELSIM_BIN'}= $modelsim if( defined $modelsim);	
	
	if( defined $pronoc_work){if(-d $pronoc_work ){
			mkpath("$pronoc_work/emulate",1,01777) unless -d "$pronoc_work/emulate";
			mkpath("$pronoc_work/simulate",1,01777) unless -d "$pronoc_work/simulate";	
			mkpath("$pronoc_work/tmp",1,01777) unless -d "$pronoc_work/tmp";			
	}}
	
	
	
	#add quartus_bin to PATH linux envirement if it does not exist in PATH
	if( defined $quartus){
		my @q =split  (/:/,$ENV{'PATH'});
		my $p=get_scolar_pos ($quartus,@q);
		$ENV{'PATH'}= $ENV{'PATH'}.":$quartus" unless ( defined $p); 
		print "$quartus has been added to linux PATH envirement.\n";
	}
}



sub main_window{
	
	set_path_env();

	my($width,$hight)=max_win_size();
	set_defualt_font_size();
	
	if ( !defined $ENV{PRONOC_WORK} ) {
	my $message;
	if ( !defined $ENV{PRONOC_WORK}) {
		my $dir = Cwd::getcwd();
		my $project_dir	  = abs_path("$dir/../../mpsoc_work");
		$ENV{'PRONOC_WORK'}= $project_dir;
		$message= "\n\nWarning: PRONOC_WORK envirement varibale has not been set. The PRONOC_WORK is autumatically set to $ENV{'PRONOC_WORK'}.\n";
    
	}


  	
	#$message= $message."Warning: QUARTUS_BIN environment variable has not been set. It is required only for working with NoC emulator." if(!defined $ENV{QUARTUS_BIN});
	
	#$message= $message."\n\nPlease add aformentioned variables to ~\.bashrc file e.g: export PRONOC_WORK=[path_to]/mpsoc_work.";
    	message_dialog("$message");
    
}

	my $table = def_table(1,3,FALSE);
	
			
	#________
	#radio btn "Generator"	
	my $rbtn_generator = Gtk2::RadioToolButton->new (undef);		
			
	my ($notebook,$noteref) = generate_main_notebook('Generator');
	my $window = def_win_size($width-100,$hight-100,"ProNoC");
	my $navIco = Gtk2::Gdk::Pixbuf->new_from_file("./icons/ProNoC.png");         # advance1.png");  
	$window->set_default_icon($navIco); 


 my @menu_items = (
  [ "/_File",            undef,        undef,          0, "<Branch>" ],
  [ "/File/_Setting",       "<control>O", sub { setting(0); },  0,  undef ],
  [ "/File/_Quit",       "<control>Q", sub { Gtk2->main_quit },  0, "<StockItem>", 'gtk-quit' ],
  [ "/_View",                  undef, undef,         0, "<Branch>" ],
  [ "/_View/_ProNoC System Generator",  "<control>1", 	sub{ open_page($notebook,$noteref,$table,'Generator'); } ,	0,	undef ],
  [ "/_View/_ProNoC Simulator",  "<control>2", 	sub{ open_page($notebook,$noteref,$table,'Simulator'); } ,	0,	undef ],
 


  [ "/_Help", 		undef,		undef,          0, 	"<Branch>" ],
  [ "/_Help/_About",  	"F1", 		\&about ,	0,	undef ],
  [ "/_Help/_ProNoC System Overview",  	"F2", 		\&overview ,	0,	undef ],  
  [ "/_Help/_ProNoC User Manual",  "F3",		\&user_help, 	0,	undef ],
 
);
	
    my $accel_group = Gtk2::AccelGroup->new;
    $window->add_accel_group ($accel_group);      
    my $item_factory = Gtk2::ItemFactory->new ("Gtk2::MenuBar", "<main>",$accel_group);

    # Set up item factory to go away with the window
    $window->{'<main>'} = $item_factory;

    # create menu items
    $item_factory->create_items ($window, @menu_items);
	$table->attach ($item_factory->get_widget ("<main>"),0, 1, 0,1,,'fill','fill',0,0); #,'expand','shrink',2,2);
    my $tt = Gtk2::Tooltips->new();


	#====================================
	#The handle box helps in creating a detachable toolbar 
	my $hb = Gtk2::HandleBox->new;
	#create a toolbar, and do some initial settings
	my $toolbar = Gtk2::Toolbar->new;
	$toolbar->set_icon_size ('small-toolbar');	
	$toolbar->set_show_arrow (FALSE);		
	$rbtn_generator->set_label ('Generator');
	$rbtn_generator->set_icon_widget (def_icon('icons/hardware.png'));
	set_tip($rbtn_generator, "ProNoC System Generator");
	$toolbar->insert($rbtn_generator,-1);	
	#________
	#radio btn "Simulator"
	my $rbtn_simulator = Gtk2::RadioToolButton->new_from_widget($rbtn_generator);
	$rbtn_simulator->set_label ('Simulator');
	$rbtn_simulator->set_icon_widget (def_icon('icons/simulator.png')) ;	
	set_tip($rbtn_simulator, "ProNoC Simulator");
	$toolbar->insert($rbtn_simulator,-1);	
	#________
	#radio btn "Networkgen"
	#my $rbtn_networkgen = Gtk2::RadioToolButton->new_from_widget($rbtn_generator);
	#$rbtn_networkgen->set_label ('Network Generator');
	#$rbtn_networkgen->set_icon_widget (def_icon('icons/trace.png')) ;	
	#set_tip($rbtn_networkgen, "ProNoC Network Generator");
	#$toolbar->insert($rbtn_networkgen,-1);			
	#====================================
	$hb->add($toolbar);
	$rbtn_generator->signal_connect('toggled', sub{
		open_page($notebook,$noteref,$table,'Generator');				
	});
	
	$rbtn_simulator->signal_connect('toggled', sub{
		open_page($notebook,$noteref,$table,'Simulator');		
	});
	
	#$rbtn_networkgen->signal_connect('toggled', sub{
	#	open_page($notebook,$noteref,$table,'Networkgen');		
	#});	
 
   $table->attach ($hb,1, 2, 0,1,'fill','fill',0,0);
   $table->attach_defaults( $notebook, 0, 2, 1,2);

	$window->add($table);
	$window->set_resizable (1);
	$window->show_all();		
}			


sub open_page{
	my ( $notebook,$noteref,$table,$page_name)=@_;
	$notebook->destroy;
	($notebook,$noteref) = generate_main_notebook($page_name);
	$table->attach_defaults( $notebook, 0, 2, 1,2);	
	$table->show_all;

}


sub about {
    my $about = Gtk2::AboutDialog->new;
    $about->set_authors("Alireza Monemi\n Email: alirezamonemi\@opencores.org");
    $about->set_version( $VERSION );
    $about->set_website('http://opencores.org/project,an-fpga-implementation-of-low-latency-noc-based-mpsoc');
    $about->set_comments('NoC based MPSoC generator.');
    $about->set_program_name('ProNoC');

    $about->set_license(
                 "This program is free software; you can redistribute it\n"
                . "and/or modify it under the terms of the GNU General \n"
		. "Public License as published by the Free Software \n"
		. "Foundation; either version 1, or (at your option)\n"
		. "any later version.\n\n"
                 
        );
	# Add the Hide action to the 'Close' button in the AboutDialog():
    $about->signal_connect('response' => sub { $about->hide; });


    $about->run;
    $about->destroy;
    return;
}



sub user_help{ 
    my $dir = Cwd::getcwd();
    my $help="$dir/../../doc/ProNoC_User_manual.pdf";	
    system qq (xdg-open $help);
    return;
}

sub overview{
    my $dir = Cwd::getcwd();
    my $help="$dir/../../doc/ProNoC_System_Overview.pdf";	
    system qq (xdg-open $help);
    return;
}

sub setting{
	my $reset=shift;
	my $project_dir	  = get_project_dir(); #mpsoc dir addr
	my $paths_file= "$project_dir/mpsoc/perl_gui/lib/Paths";

	__PACKAGE__->mk_accessors(qw{
	PRONOC_WORK
	});
	my $self;
	if (-f 	$paths_file ){
		$self= do $paths_file;
	}else{
		$self = __PACKAGE__->new();
		
	}
	
	
	my $table=def_table(10,10,FALSE);	
	my $set_win=def_popwin_size(40,80,"Configuration setting",'percent');
	my $scrolled_win = new Gtk2::ScrolledWindow (undef, undef);
	$scrolled_win->set_policy( "automatic", "automatic" );
	$scrolled_win->add_with_viewport($table);
	my $row=0; my $col=0;
	
	#title		
	my $title=gen_label_in_center("setting");
	$table->attach ($title , 0, 10,  $row, $row+1,'expand','shrink',2,2); $row++;
	my $separator = Gtk2::HSeparator->new;	
	$table->attach ($separator , 0, 10 , $row, $row+1,'fill','fill',2,2);	$row++;

	my @paths = (
	{ label=>"PRONOC_WORK", param_name=>"PRONOC_WORK", type=>"DIR_path", default_val=>"$project_dir/mpsoc_work", content=>undef, info=>"Define the working directory where the projects' files will be created", param_parent=>'PATH',ref_delay=>undef },
	{ label=>"QUARTUS_BIN", param_name=>"QUARTUS_BIN", type=>"DIR_path", default_val=>undef, content=>undef, info=>"Define the path to QuartusII compiler bin directory.  Setting of this variable is optional and is needed if you are going to use Altera FPGAs for implementation or emulation", param_parent=>'PATH',ref_delay=>undef },
	{ label=>"MODELSIM_BIN", param_name=>"MODELSIM_BIN", type=>"DIR_path", default_val=>undef, content=>undef, info=>"Define the path to Modelsim simulator bin directory.  Setting of this variable is optional and is needed if you have installed Modelsim simulator and you want ProNoC to auto-generate the
simulation models using Modelsim software", param_parent=>'PATH',ref_delay=>undef },
		);	


	foreach my $d (@paths) {
		#$mpsoc,$name,$param, $default,$type,$content,$info, $table,$row,$column,$show,$attribut1,$ref_delay,$new_status,$loc
		($row,$col)=add_param_widget ($self, $d->{label}, $d->{param_name}, $d->{default_val}, $d->{type}, $d->{content}, $d->{info}, $table,$row,$col,1, $d->{param_parent}, $d->{ref_delay},undef,"vertical");
	}



	#title		
	my $title2=gen_label_in_center("Toolchain");
	$table->attach ($title2 , 0, 10,  $row, $row+1,'expand','shrink',2,2); $row++;
	my $separator2 = Gtk2::HSeparator->new;	
	$table->attach ($separator2 , 0, 10 , $row, $row+1,'fill','fill',2,2);	$row++;

	#check which toolchain is available in the system
	$table->attach (check_toolchains($self) , 0, 10 , $row, $row+1,'fill','fill',2,2);	$row++;
	
	
	
	



	my $ok = def_image_button('icons/select.png','OK');
	my $mtable = def_table(10, 1, TRUE);

	$mtable->attach_defaults($scrolled_win,0,1,0,9);
	$mtable-> attach ($ok , 0, 1,  9, 10,'expand','shrink',2,2); 
	
	$set_win->add ($mtable);
	$set_win->show_all();
	
	my $old_pronoc_work = $self->object_get_attribute("PATH","PRONOC_WORK");
	my $old_quartus = $self->object_get_attribute("PATH","QUARTUS_BIN");
	my $old_modelsim = $self->object_get_attribute("PATH","MODELSIM_BIN");
	
	$ok->signal_connect("clicked"=> sub{
		#save setting
		open(FILE,  ">$paths_file") || die "Can not open: $!";
		print FILE perl_file_header("Paths");
		print FILE Data::Dumper->Dump([\%$self],['setting']);
		close(FILE) || die "Error closing file: $!";
		my $pronoc_work = $self->object_get_attribute("PATH","PRONOC_WORK");
		my $quartus = $self->object_get_attribute("PATH","QUARTUS_BIN");
		my $modelsim = $self->object_get_attribute("PATH","MODELSIM_BIN");
		make_undef_as_string(\$old_pronoc_work,\$old_quartus,\$old_modelsim,\$pronoc_work,\$quartus,\$modelsim);
			
		if(($old_pronoc_work ne $pronoc_work) || !defined $ENV{PRONOC_WORK}){
			append_text_to_file ("$ENV{HOME}/.bashrc", "\nexport PRONOC_WORK=$pronoc_work\n"); 
			mkpath("$pronoc_work/emulate",1,01777) unless -d "$pronoc_work/emulate";
			mkpath("$pronoc_work/simulate",1,01777) unless -d "$pronoc_work/simulate";	
			mkpath("$pronoc_work/tmp",1,01777) unless -d "$pronoc_work/tmp";			
		}
		
		append_text_to_file ("$ENV{HOME}/.bashrc", "export QUARTUS_BIN=$quartus\n") if($old_quartus ne $quartus) ;
		append_text_to_file ("$ENV{HOME}/.bashrc", "export MODELSIM_BIN=$modelsim\n") if($old_modelsim ne $modelsim) ;
		set_path_env();
		if(($old_pronoc_work ne $pronoc_work) || $old_quartus ne $quartus ||$old_modelsim ne $modelsim){
			
			

	}

	my  ($file_path,$text)=@_;
		$set_win->destroy;
		main_window() if($reset);

	});
	
}

sub check_toolchains{
	my $self=shift;
	my $table = def_table(10, 1, TRUE);
	
	my @f1=("/bin/mb-g++","/bin/mb-objcopy");
	my @f2=("/bin/lm32-elf-gcc","/bin/lm32-elf-ld","/bin/lm32-elf-objcopy","/bin/lm32-elf-objdump","/lm32-elf/lib","/lib/gcc/lm32-elf/4.5.3");
	my @f3=("/bin/or1k-elf-gcc","/bin/or1k-elf-ld","/bin/or1k-elf-objcopy","/bin/or1k-elf-objdump","/lib/gcc/or1k-elf/5.2.0");
	
	my @tool = (
	{ label=>"aeMB", tooldir=>"aemb", files=>\@f1 },
	{ label=>"lm32", tooldir=>"lm32", files=>\@f2 },
	{ label=>"or1k-elf", tooldir=>"or1k-elf", files=>\@f3 },
	);
	
	my $row =0;
	foreach my $d (@tool) {
		
		my $exist=1;
		my $miss="";
		my $pronoc_work = $self->object_get_attribute("PATH","PRONOC_WORK");
		my $tooldir=$d->{tooldir};
		my @files=@{$d->{files}};
		my $tool_path="$pronoc_work/toolchain/$tooldir";
		unless (-d $tool_path){
			$exist=0;
			$miss=$miss." $tool_path is missing\n";
		}else{
			foreach my $f (@files){
				
				my $file_path= "$tool_path/$f";
				unless ( -f $file_path || -d $file_path){
					$exist=0;
					$miss=$miss." $file_path file is missing\n";
				}
			}
		}
		if ($exist==0){
			my $w=def_image_button("icons/warning.png",$d->{label});
			$w->signal_connect("clicked" => sub {message_dialog($miss);});	
			$table->attach ($w , 0, 1,  $row, $row+1,'shrink','shrink',2,2); $row++;
		}else{
			my $w=def_image_label("icons/button_ok.png",$d->{label});
			$table->attach ($w , 0, 1,  $row, $row+1,'shrink','shrink',2,2); $row++;			
		}
			
	}			
	return $table;	
}


sub generate_main_notebook {
	my $mode =shift;
	
	my $notebook = Gtk2::Notebook->new;
	$notebook->show_all;
	if($mode eq 'Generator'){
		my $intfc_gen=  intfc_main();
		my $lable1=def_image_label("icons/intfc.png"," Interface generator ");
		$notebook->append_page ($intfc_gen,$lable1);#Gtk2::Label->new_with_mnemonic ("  _Interface generator  "));
		$lable1->show_all;

		my $ipgen=ipgen_main();
		my $lable2=def_image_label("icons/ip.png"," IP generator ");
		$notebook->append_page ($ipgen,$lable2);#Gtk2::Label->new_with_mnemonic ("  _IP generator  "));
		$lable2->show_all;

		my $socgen=socgen_main();
		my $lable3=def_image_label("icons/tile.png"," Processing tile generator ");			
		$notebook->append_page ($socgen,$lable3 );#,Gtk2::Label->new_with_mnemonic ("  _Processing tile generator  "));
		$lable3->show_all;		

		my $mpsocgen =mpsocgen_main();
		my $lable4=def_image_label("icons/noc.png"," NoC based MPSoC generator ");	
		$notebook->append_page ($mpsocgen,$lable4);#Gtk2::Label->new_with_mnemonic ("  _NoC based MPSoC generator  "));	
		$lable4->show_all;	
		
		
	
	} elsif($mode eq 'Networkgen'){
	
		my $networkgen = network_maker_main();
		my $lable5=def_image_label("icons/trace.png"," Network Maker ");	
		$notebook->append_page ($networkgen,$lable5);#Gtk2::Label->new_with_mnemonic ("  _NoC based MPSoC generator  "));	
		$lable5->show_all;	
	
	
	}else{
		
		
		
		my $trace_gen= trace_gen_main();
		my $lable1=def_image_label("icons/trace.png"," _Trace generator ",1);
		#my $lb=Gtk2::Label->new_with_mnemonic (" _Trace generator   ");
		set_tip($lable1, "Generate trace file from application task graph");
		
		$notebook->append_page ($trace_gen,$lable1);		
		$lable1->show_all;
		$trace_gen->show_all;
		
		my $simulator =simulator_main();
		my $lable2=def_image_label("icons/sim.png"," _NoC simulator ",1);
		
		
		$notebook->append_page ($simulator,$lable2);#Gtk2::Label->new_with_mnemonic (" _NoC simulator   "));		
		$lable2->show_all;
		$simulator->show_all;		

		my $emulator =emulator_main();
		my $lable3=def_image_label("icons/emul.png"," _NoC emulator ",1);
		$notebook->append_page ($emulator,$lable3);#Gtk2::Label->new_with_mnemonic (" _NoC emulator"));				
		$lable3->show_all;
		$emulator->show_all;

		

	}		
			
		my $scrolled_win = new Gtk2::ScrolledWindow (undef, undef);
		$scrolled_win->set_policy( "automatic", "automatic" );
		$scrolled_win->add_with_viewport($notebook);	
		$scrolled_win->show_all;	

		return ($scrolled_win,$notebook);	
}






Gtk2->init;
main;
Gtk2->main();
