function value = my_psnr(original, compressed)
    original = double(original);
    compressed = double(compressed);
	[row, column, channel] = size(original);
	if channel == 3
		original = rgb2gray(original);
		compressed = rgb2gray(compressed);
	end
	mse = sum(sum((original - compressed).^2))/(row*column);
	value = 10*log10(255^2/mse);
end