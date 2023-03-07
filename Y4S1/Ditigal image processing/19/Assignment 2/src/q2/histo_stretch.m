function img_strch = histo_stretch(img, a, b, A, B)

	if length(size(img)) == 3
		img = rgb2gray(img);
	end

	img_strch = double(img);
	mask = double((img >= a) & (img <= b));
	img_temp = floor((B - A) * (img_strch - a) / (b - a) + A);
	img_strch = img_temp .* mask + img_strch .* (1 - mask);
	img_strch = uint8(img_strch);

end

