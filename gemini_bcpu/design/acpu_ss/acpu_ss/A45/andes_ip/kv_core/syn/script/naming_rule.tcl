#------------------------------------------------------------------------------#
#                ( NOTE 2 - How to Apply Name Rule in Scripts)
#
# Apply rules as follows (Current Design must be top module).
#                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# 1. Core naming rule should be applied to all blocks down the hierarchy.
#
# 2. Top naming rule should only apply to the "chip-level" top module.
#                                              ^^^^^^^^^^
# 3. core naming rule 2 should only apply for 2003.12 and later version.
#                                             ^^^^^^^^^^^^^^^^^
# current_design <top_module_name>
# change_names -rules verilog -hierarchy
# change_names -rules nds_core_rule -hierarchy
# change_names -rules nds_core_rule_2 -hierarchy    ;#<== for 2003.12 & later
# set bus_naming_style {%s[%d]}
# current_design <top_module_name>
# change_names -rules nds_top_rule                  ;#<== for chip-level only
# write -f verilog -h -o <top_module_name>_g.v
#------------------------------------------------------------------------------#

if {[regexp {2002|2001|2003\.06|2003\.03} $sh_product_version] == 1} { ;# version prior to 2003.12
    # ================================================= #
    #      Andes Top block naming rules                 #
    # ================================================= #
    
    define_name_rules nds_top_rule \
    -allowed {a-z A-Z 0-9 _ } \
    -max_length 16 \
    -first_restricted {0-9_} \
    -last_restricted {_} \
    -target_bus_naming_style {%s[%d]} \
    -map {{{"_$", ""}, {"^_", ""}, {"__", "_"}}} \
    -type port \
    -reserved_words [list {always} {assign} {begin} {case} \
    {casex} {casez} {deassign} {default} {defparam} {disable} \
    {edge} {else} {end} {endcase} {endfunction} {endmodule} \
    {endprimitive} {endspecify} {endtable} {endtask} {event} \
    {for} {force} {forever} {fork} {function} {highz0} {highz1} \
    {if} {initial} {inout} {input} {integer} {join} {large} \
    {macromodule} {medium} {module} {negedge} {output} {parameter} \
    {posedge} {primitive} {pull0} {pull1} {reg} {release} {repeat} \
    {scalared} {small} {specify} {specparam} {strong0} {strong1} \
    {supply0} {supply1} {table} {task} {time} {tri} {tri0} {tri1} \
    {triand} {trior} {trireg} {vectored} {wait} {wand} {weak0} \
    {weak1} {while} {wire} {wor} {ALIAS} {BIDIRECT} {CEND} \
    {COMPSEGMENT} {END} {ENDC} {ENDCOMPS} {ENDIMPLS} {ENDMACRO} \
    {ENDNETS} {END_OF_FILE} {EQUIVALENCE} {EXT} {EXTCONNECTOR} \
    {FROM} {IMPLSEGMENT} {INPUTS} {LEVEL} {MACRO} {NETSEGMENT} \
    {NULL} {OUTPUTS} {PURPOSE} {TO} {TYPES} {USER} {USERNAME} \
    {abs} {access} {after} {alias} {all} {and} {architecture} \
    {array} {assert} {attribute} {begin} {block} {body} \
    {buffer} {bus} {case} {component} {configuration} {constant} \
    {disconnect} {downto} {else} {elsif} {end} {entity} {exit} \
    {file} {for} {function} {generate} {generic} {guarded} {if} \
    {in} {inout} {is} {label} {library} {linkage} {loop} {map} \
    {mod} {nand} {new} {next} {nor} {not} {null} {of} {on} \
    {open} {or} {others} {out} {package} {port} {procedure} \
    {process} {range} {record} {register} {rem} {report} \
    {return} {select} {severity} {signal} {subtype} {then} \
    {to} {transport} {type} {units} {until} {use} {variable} \
    {wait} {when} {while} {with} {xor}]
    
    define_name_rules nds_top_rule \
    -type net \
    -target_bus_naming_style {%s_%d}
    
    # ===================================== #
    #      Andes Core cell naming rules     #
    # ===================================== #
    
    define_name_rules nds_core_rule \
    -allowed {a-z A-Z 0-9 _ } \
    -max_length 256 \
    -first_restricted {0-9_} \
    -last_restricted {_} \
    -target_bus_naming_style {%s[%d]} \
    -map {{{"_$", ""}, {"^_", ""}, {"__", "_"}}} \
    -reserved_words [list {always} {assign} {begin} {case} \
    {casex} {casez} {deassign} {default} {defparam} {disable} \
    {edge} {else} {end} {endcase} {endfunction} {endmodule} \
    {endprimitive} {endspecify} {endtable} {endtask} {event} \
    {for} {force} {forever} {fork} {function} {highz0} {highz1} \
    {if} {initial} {inout} {input} {integer} {join} {large} \
    {macromodule} {medium} {module} {negedge} {output} {parameter} \
    {posedge} {primitive} {pull0} {pull1} {reg} {release} {repeat} \
    {scalared} {small} {specify} {specparam} {strong0} {strong1} \
    {supply0} {supply1} {table} {task} {time} {tri} {tri0} {tri1} \
    {triand} {trior} {trireg} {vectored} {wait} {wand} {weak0} \
    {weak1} {while} {wire} {wor} {ALIAS} {BIDIRECT} {CEND} \
    {COMPSEGMENT} {END} {ENDC} {ENDCOMPS} {ENDIMPLS} {ENDMACRO} \
    {ENDNETS} {END_OF_FILE} {EQUIVALENCE} {EXT} {EXTCONNECTOR} \
    {FROM} {IMPLSEGMENT} {INPUTS} {LEVEL} {MACRO} {NETSEGMENT} \
    {NULL} {OUTPUTS} {PURPOSE} {TO} {TYPES} {USER} {USERNAME} \
    {abs} {access} {after} {alias} {all} {and} {architecture} \
    {array} {assert} {attribute} {begin} {block} {body} {buffer} \
    {bus} {case} {component} {configuration} {constant} {disconnect} \
    {downto} {else} {elsif} {end} {entity} {exit} {file} {for} \
    {function} {generate} {generic} {guarded} {if} {in} {inout} \
    {is} {label} {library} {linkage} {loop} {map} {mod} {nand} \
    {new} {next} {nor} {not} {null} {of} {on} {open} {or} {others} \
    {out} {package} {port} {procedure} {process} {range} {record} \
    {register} {rem} {report} {return} {select} {severity} {signal} \
    {subtype} {then} {to} {transport} {type} {units} {until} {use} \
    {variable} {wait} {when} {while} {with} {xor}]
    
    define_name_rules nds_core_rule \
    -type net \
    -target_bus_naming_style {%s_%d}
    
} else {               ;# version 2003.12 or later

    # ================================================= #
    #      Andes Top block naming rules                 #
    # ================================================= #
    
    define_name_rules nds_top_rule \
    -allowed {a-z A-Z 0-9 _ } \
    -max_length 256 \
    -first_restricted {0-9_} \
    -last_restricted {_} \
    -target_bus_naming_style {%s[%d]} \
    -map {{{"_$", ""}, {"^_", ""}, {"__", "_"}}} \
    -type port \
    -reserved_words [list {always} {assign} {begin} {case} \
    {casex} {casez} {deassign} {default} {defparam} {disable} \
    {edge} {else} {end} {endcase} {endfunction} {endmodule} \
    {endprimitive} {endspecify} {endtable} {endtask} {event} \
    {for} {force} {forever} {fork} {function} {highz0} {highz1} \
    {if} {initial} {inout} {input} {integer} {join} {large} \
    {macromodule} {medium} {module} {negedge} {output} {parameter} \
    {posedge} {primitive} {pull0} {pull1} {reg} {release} {repeat} \
    {scalared} {small} {specify} {specparam} {strong0} {strong1} \
    {supply0} {supply1} {table} {task} {time} {tri} {tri0} {tri1} \
    {triand} {trior} {trireg} {vectored} {wait} {wand} {weak0} \
    {weak1} {while} {wire} {wor} {ALIAS} {BIDIRECT} {CEND} \
    {COMPSEGMENT} {END} {ENDC} {ENDCOMPS} {ENDIMPLS} {ENDMACRO} \
    {ENDNETS} {END_OF_FILE} {EQUIVALENCE} {EXT} {EXTCONNECTOR} \
    {FROM} {IMPLSEGMENT} {INPUTS} {LEVEL} {MACRO} {NETSEGMENT} \
    {NULL} {OUTPUTS} {PURPOSE} {TO} {TYPES} {USER} {USERNAME} \
    {abs} {access} {after} {alias} {all} {and} {architecture} \
    {array} {assert} {attribute} {begin} {block} {body} \
    {buffer} {bus} {case} {component} {configuration} {constant} \
    {disconnect} {downto} {else} {elsif} {end} {entity} {exit} \
    {file} {for} {function} {generate} {generic} {guarded} {if} \
    {in} {inout} {is} {label} {library} {linkage} {loop} {map} \
    {mod} {nand} {new} {next} {nor} {not} {null} {of} {on} \
    {open} {or} {others} {out} {package} {port} {procedure} \
    {process} {range} {record} {register} {rem} {report} \
    {return} {select} {severity} {signal} {subtype} {then} \
    {to} {transport} {type} {units} {until} {use} {variable} \
    {wait} {when} {while} {with} {xor}]
    
    # ===================================== #
    #      Andes Core cell naming rules     #
    # ===================================== #
    
    define_name_rules nds_core_rule \
    -allowed {a-z A-Z 0-9 _ } \
    -max_length 256 \
    -first_restricted {0-9_} \
    -last_restricted {_} \
    -target_bus_naming_style {%s[%d]} \
    -map {{{"_$", ""}, {"^_", ""}, {"__", "_"}}} \
    -equal_ports_nets \
    -inout_ports_equal_nets \
    -remove_irregular_port_bus \
    -remove_irregular_net_bus \
    -flatten_multi_dimension_busses \
    -check_bus_indexing \
    -reserved_words [list {always} {assign} {begin} {case} \
    {casex} {casez} {deassign} {default} {defparam} {disable} \
    {edge} {else} {end} {endcase} {endfunction} {endmodule} \
    {endprimitive} {endspecify} {endtable} {endtask} {event} \
    {for} {force} {forever} {fork} {function} {highz0} {highz1} \
    {if} {initial} {inout} {input} {integer} {join} {large} \
    {macromodule} {medium} {module} {negedge} {output} {parameter} \
    {posedge} {primitive} {pull0} {pull1} {reg} {release} {repeat} \
    {scalared} {small} {specify} {specparam} {strong0} {strong1} \
    {supply0} {supply1} {table} {task} {time} {tri} {tri0} {tri1} \
    {triand} {trior} {trireg} {vectored} {wait} {wand} {weak0} \
    {weak1} {while} {wire} {wor} {ALIAS} {BIDIRECT} {CEND} \
    {COMPSEGMENT} {END} {ENDC} {ENDCOMPS} {ENDIMPLS} {ENDMACRO} \
    {ENDNETS} {END_OF_FILE} {EQUIVALENCE} {EXT} {EXTCONNECTOR} \
    {FROM} {IMPLSEGMENT} {INPUTS} {LEVEL} {MACRO} {NETSEGMENT} \
    {NULL} {OUTPUTS} {PURPOSE} {TO} {TYPES} {USER} {USERNAME} \
    {abs} {access} {after} {alias} {all} {and} {architecture} \
    {array} {assert} {attribute} {begin} {block} {body} {buffer} \
    {bus} {case} {component} {configuration} {constant} {disconnect} \
    {downto} {else} {elsif} {end} {entity} {exit} {file} {for} \
    {function} {generate} {generic} {guarded} {if} {in} {inout} \
    {is} {label} {library} {linkage} {loop} {map} {mod} {nand} \
    {new} {next} {nor} {not} {null} {of} {on} {open} {or} {others} \
    {out} {package} {port} {procedure} {process} {range} {record} \
    {register} {rem} {report} {return} {select} {severity} {signal} \
    {subtype} {then} {to} {transport} {type} {units} {until} {use} \
    {variable} {wait} {when} {while} {with} {xor}]
    
    define_name_rules nds_core_rule_2 -map {{{"_$",""},{"^_",""},{"__","_"}}}
    
}

