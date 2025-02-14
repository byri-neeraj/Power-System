This Matlab program returns the admittance (Y) bus matrix required for the load flow analysis of the system.
Load flow analysis comes under the Steady State analysis needed to calculate the Bus Terminal Voltage and Line current.

Code needs from bus, to bus, resistance, reactance and line charging admittance from the user. It uses ldata to store the user given input and
performes loop operation to calculate the final admittance matrix.

Admittance bus is a sparse matrix. It take less memory and less computation time for the calculation and 
needed to find the terminal voltage.
