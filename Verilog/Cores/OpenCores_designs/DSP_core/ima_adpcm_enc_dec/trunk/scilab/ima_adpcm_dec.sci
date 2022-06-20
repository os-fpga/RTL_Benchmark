function out_samp = ima_adpcm_dec(in_pcm)
// This function decodes an IMA ADPCM compressed audio. The output is reconstructed 
// to 16 bits per sample. 
//
// Author: Moti Litochevski
// Date: February 17, 2010
// 

// step quantizer adaptation lookup table 
STEP_LUT = [ ...
		7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 21, 23, 25, 28, 31, 34, ...
		37, 41, 45, 50, 55, 60, 66, 73, 80, 88, 97, 107, 118, 130, 143, 157, ...
		173, 190, 209, 230, 253, 279, 307, 337, 371, 408, 449, 494, 544, 598, ...
		658, 724, 796, 876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066, ...
		2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358, 5894, 6484, ...
		7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899, 15289, 16818, 18500, ...
		20350, 22385, 24623, 27086, 29794, 32767];
// index quantizer adaptation lookup table 
INDEX_LUT = [-1, -1, -1, -1, 2, 4, 6, 8];

// prepare loop variables 
predictor_samp = zeros(1, length(in_pcm)+1);
qstep_index = ones(1, length(in_pcm)+1);
// convert the input coded signal to binary form & calculate the PCM value (without sign)
pcm_bin = de2bi(in_pcm, 4);
pcm_val = pcm_bin(:,[2:4]) * [4, 2, 1]';

// decoding loop 
for idx = [1:length(in_pcm)],
	// extract the current quantizer step size 
	qstep_size = STEP_LUT(qstep_index(idx));
	
	// de-quantizer implementation starts from the middle of the current 
	// quantization step (qstep_size/8)
	dequant_samp = qstep_size;
	// de-quantize bit by bit 
	dequant_samp = dequant_samp + pcm_bin(idx, 2) * qstep_size * 8;
	dequant_samp = dequant_samp + pcm_bin(idx, 3) * qstep_size * 4;
	dequant_samp = dequant_samp + pcm_bin(idx, 4) * qstep_size * 2;
	
	// update the predictor output sample according to the sign bit 
	if (pcm_bin(idx, 1)), 
		predictor_samp(idx+1) = predictor_samp(idx) - dequant_samp;
	else 
		predictor_samp(idx+1) = predictor_samp(idx) + dequant_samp;
	end 
	// check for predictor sample saturation condition 
	if (predictor_samp(idx+1) > (2^18-1)),
		predictor_samp(idx+1) = 2^18-1;
	elseif (predictor_samp(idx+1) < -2^18),
		predictor_samp(idx+1) = -2^18;
	end 
	
	// update the step size index 
	qstep_index(idx+1) = qstep_index(idx) + INDEX_LUT(pcm_val(idx)+1);
	// check index saturation conditions 
	if (qstep_index(idx+1) < 1)
		qstep_index(idx+1) = 1;
	elseif (qstep_index(idx+1) > 89)
		qstep_index(idx+1) = 89;
	end
end 

// output sample is just the saturated & scaled predictor output 
out_samp = predictor_samp(2:$)/8;
// implement rounding 
out_samp = round(out_samp);
cor_idx = find((out_samp - predictor_samp(2:$)/8) == -0.5);
out_samp(cor_idx) = out_samp(cor_idx) + 1;
// check for saturation 
out_samp(find(predictor_samp(2:$)/8 > 32767)) = 32767;
out_samp(find(predictor_samp(2:$)/8 < -32768)) = -32768;

endfunction 
