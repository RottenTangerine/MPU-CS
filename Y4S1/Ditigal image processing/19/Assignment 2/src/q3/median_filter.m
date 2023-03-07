function new_img = median_filter(img)

[row, column] = size(img);

new_img = zeros(row, column);
img = double(img);
for i = 2:row-1
	for j = 2:column-1
		new_img(i, j) = median([img(i-1, j-1), img(i-1, j), img(i-1, j+1), img(i, j-1), img(i, j), img(i, j+1), img(i+1, j-1), img(i+1, j), img(i+1, j+1)]);
	end
end
new_img = uint8(new_img);

end


