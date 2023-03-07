function new_img = average_filter(img, scale)

[row, column] = size(img);
w = ones(scale, scale) / (scale * scale);
[filter_row, filter_column] = size(w);
img = double(img);

if length(size(img)) ~= 2
    disp("Error: not a grayscale image")
    return
end

row_padding = (filter_row - 1) / 2;
column_padding = (filter_column - 1) / 2;

temp = zeros(row + 2 * row_padding, column + 2 * column_padding);
result = zeros(row + 2 * row_padding, column + 2 * column_padding);
temp(row_padding + 1 : row + row_padding, column_padding + 1 : column + column_padding) = img;

for i = row_padding + 1 : row + row_padding
	for j = column_padding + 1 : column + column_padding
		result(i, j) = abs(sum(sum(temp(i - row_padding : i + row_padding, j - column_padding : j + column_padding) .* w)));
	end
end

new_img = uint8(result(row_padding + 1 : row + row_padding, column_padding + 1 : column + column_padding));

end

