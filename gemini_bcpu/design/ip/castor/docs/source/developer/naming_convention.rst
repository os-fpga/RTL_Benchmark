.. _developer_naming_convention:

Naming Convention
=================

Tape-out names
--------------

For easier communication, the various parties involved in the chip design process request that we use codenames for the various tape-outs.
The naming convention for each tape-out follows

::
  <Codename>_<Node>_<Type>_<Date>

.. option:: Codename

  Represents the code name of the tape-out.

.. option:: Node 

  Represents the technology node details. It consists of ``<foundry_name>_<feature_size>_<process_type>``

.. option:: Type

  Represents the type of the tape-out, which can either *Multi-Project Wafer* (MPW) or *Full Mask* (FM)

.. option:: Date

  Represents the deadline (Year with last 2 digits and month) to submit the GDS file to foundry

.. note::
  **In this project, following the naming convention, the final name is** ``Genesis_TSMC22ULP_MPW_2201``

Pin Names
---------

.. note:: Please use lowercase as much as you can

For code readability, the pin name should follow the convention
::
  <Pin_Name>_<Polarity><Direction>


.. option:: Pin Name

  Represents the pin name

.. option:: Polarity

  Represents polarity of the pin, it can be 

  - ``n`` denotes a negative-enable signal 

  .. note:: When not specified, by default we assume this is a postive-enable signal

.. option:: Direction

  Represents the direction of a pin, it can be 

  - ``i`` denotes an input signal
  - ``o`` denotes an output signal

A quick example
::
  clk_ni

represents an input clock signal which is negative-enable

