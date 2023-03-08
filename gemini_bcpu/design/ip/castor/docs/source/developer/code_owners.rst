.. _developer_code_owners:

Code Ownership
==============

Work Domains
------------
In general, the current tape-project can be split into the following work domains

- Architecture definition
- Netlist post-processing
- Physical Design

For each work domain, there are explicit subdirectories at the root. Input files and scripts (for regression tests) should be placed in these subdirectories.

Team Responsibilities
---------------------

.. note:: All the team members should be responsive on any github issue and pull request where they are mentioned. Expected response window is in 24 hours. Otherwise, meetings will be forced to synchronize. Meeting notes will be added to related issues and pull requests

Architecture team
^^^^^^^^^^^^^^^^^

Architecture team is in charge of 

  - FPGA architecture description files
  - Scripts to generate netlists
  - Scripts to run regression tests (partially owned by sign-off team)
  - Communicate with netlist post-processing team when there is a conflict

Netlist post-processing team
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Netlist post-processing team is in charge of 

  - Netlists generated from FPGA architecture
  - Scripts to post-process netlists
  - Scripts to run regression tests (partially owned by sign-off team)
  - Communicate with physical design team when there is a conflict

Physical design team
^^^^^^^^^^^^^^^^^^^^

Physical design team is in charge of

  - Netlists after post-processing
  - Output files including GDS, LEF, LIB, SPEF etc.
  - Scripts to run physical design
  - Communicate with sign-off team when there is a conflict

Sign-off team
^^^^^^^^^^^^^

Sign-off team is in charge of

  - Scripts to run manufacturability checks, i.e., DRC, LVS etc.
  - Scripts to run functional verification w/o timing annotation
  - Scripts to run STA

IT team
^^^^^^^

IT team is in charge of 
  - Github Action workflows to enable all the regression tests
  - Resolve any license and environment setup for other teams
