function out_pcm = ima_adpcm_enc(in_samp)
// This function encodes the input samples audio vector using IMA ADPCM algorithm. The 
// input is assumed to be sampled using 16 bits per sample. The output vector is a 
// compressed version of the input audio signal which requires only 4 bits per input 
// sample.
// The function will scale the input vector to 16 bits per sample automatically if all 
// values in the vector are in the range [-1:1].
//
// Author: Moti Litochevski
// Date: February 17, 2010
// 

// check the input vector samples range 
if (abs(in_samp) <= 1),
	in_samp = round(in_samp * (2^15-1));
end 

// step quantizer adaptation lookup table 
STEP_LUT = [ ...
		7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 21, 23, 25, 28, 31, 34, ...
		37, 41, 45, 50, 55, 60, 66, 73, 80, 88, 97, 107, 118, 130, 143, 157, ...
		173, 190, 209, 230, 253, 279, 307, 337, 371, 408, 449, 494, 544, 598, ...
		658, 724, 796, 876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066, ...
		2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358, 5894, 6484, ...
		7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899, 15289, 16818, 18500, ...
		20350, 22385, 24623, 27086, 29794, 32767];
// quantizer index adaptation lookup table 
INDEX_LUT = [-1, -1, -1, -1, 2, 4, 6, 8];

// prepare output vector 
out_pcm = zeros(length(in_samp), 4);	// in binary format 

// prepare loop variables 
predictor_samp = zeros(1, length(in_samp)+1);
qstep_index = ones(1, length(in_samp)+1);

// compression loop 
for idx = [1:length(in_samp)],
	// subtract the previous sample form the current input sample 
	samp_diff = in_samp(idx)*8 - predictor_samp(idx);
	
	// extract the current quantizer step size 
	qstep_size = STEP_LUT(qstep_index(idx));
	
	// start difference quantization from the sign bit 
	out_pcm(idx, 1) = 1 * (samp_diff < 0);
	samp_diff = abs(samp_diff);
	
	// quantize the absolute value bit by bit 
	// the same process is used to calculate the de-quantizer output sample. note that the 
	// de-quantizer sample is started from the middle of the current step size (qstep_size/8).
	dequant_samp = qstep_size;
	// bit 2 
	out_pcm(idx, 2) = 1 * (samp_diff >= (qstep_size * 8));
	samp_diff = samp_diff - out_pcm(idx, 2) * qstep_size * 8;
	dequant_samp = dequant_samp + out_pcm(idx, 2) * qstep_size * 8;
	// bit 1 
	out_pcm(idx, 3) = 1 * (samp_diff >= (qstep_size * 4));
	samp_diff = samp_diff - out_pcm(idx, 3) * qstep_size * 4;
	dequant_samp = dequant_samp + out_pcm(idx, 3) * qstep_size * 4;
	// bit 0 
	out_pcm(idx, 4) = 1 * (samp_diff >= (qstep_size * 2));
	dequant_samp = dequant_samp + out_pcm(idx, 4) * qstep_size * 2;
	
	// update the predictor sample for the next iteration according to the sign bit 
	if (out_pcm(idx, 1)),
		predictor_samp(idx+1) = predictor_samp(idx) - dequant_samp;
	else 
		predictor_samp(idx+1) = predictor_samp(idx) + dequant_samp;
	end 
	// check for predictor sample saturation condition 
	if (predictor_samp(idx+1) > (2^18-1)),
		predictor_samp(idx+1) = 2^18 - 1;
	elseif (predictor_samp(idx+1) < -2^18),
		predictor_samp(idx + 1) = -2^18;
	end 
	
	// update the step size index 
	pcm_val = out_pcm(idx, [2:4]) * [4, 2, 1]';
	qstep_index(idx+1) = qstep_index(idx) + INDEX_LUT(pcm_val+1);
	// check index saturation conditions 
	if (qstep_index(idx+1) < 1)
		qstep_index(idx+1) = 1;
	elseif (qstep_index(idx+1) > 89)
		qstep_index(idx+1) = 89;
	end
end 

// convert the resulting compressed binary values to decimal 
out_pcm = bi2de(out_pcm);

endfunction 
