Inverse Cipher
InvShiftRows(state)  // See Sec. 5.3.1
InvSubBytes(state)  // See Sec. 5.3.2
AddRoundKey(state, w[round*Nb, (round+1)*Nb-1])
InvMixColumns(state)  // See Sec. 5.3.

NOTE: Key scheduler same as encryption.