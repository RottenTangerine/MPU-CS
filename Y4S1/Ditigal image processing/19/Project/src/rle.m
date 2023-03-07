function bit_stream = rle(input_bits, mode)
    
	bit_stream = [];
    
	% encoder
	if mode == "en"
		bit_stream = input_bits(1);
		count = 1;
		for i = 2:length(input_bits)
			if input_bits(i) == input_bits(i-1)
				count = count + 1;
			else
				bit_stream = [bit_stream, count, input_bits(i)];
				count = 1;
			end
		end
		bit_stream = [bit_stream, count];
	end

	% decoder
	if mode == "de"
		for i = 1:2:length(input_bits)
			bit_stream = [bit_stream repmat(input_bits(i), 1, input_bits(i+1))];
		end
	end
end