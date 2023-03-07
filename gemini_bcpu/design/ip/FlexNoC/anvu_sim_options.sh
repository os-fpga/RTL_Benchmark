
# The following options are modifiable at simulation time
enableSolverTraceOnFailure=0 # If 1, A failure in vcs randomizer will dump the context
                             # Beware that the THOROUGH diagnostic is expecting solver failures and this option
                             # will still dump the context.
userSimFlags="+UVM_VERBOSITY=UVM_LOW " # This string will be placed as is on the simulation command line.

# userSimFlags can include
# +anvu_log_perf=0          # Disables the dumping of the performance results at the end of the simulation
