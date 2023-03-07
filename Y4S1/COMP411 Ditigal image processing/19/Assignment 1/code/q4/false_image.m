function image = false_image(img)
	[rows, cols] = size(img);
	false_img = zeros(rows, cols, 3);

	% five colors: blue, green, magenta, red, cyan
	colors = [0, 0, 255; 0, 255, 0; 255, 0, 255; 255, 0, 0; 0, 255, 255];

	% ranges for each color from 1 ... 255
	ranges = [1, 51; 52, 102; 103, 153; 154, 204; 205, 255];

	for i = 1:rows
		for j = 1:cols
			for k = 1:5
				if img(i, j) >= ranges(k, 1) && img(i, j) < ranges(k, 2)
					false_img(i, j, :) = colors(k, :);
				end
			end
		end
    end
	image = false_img;
end

