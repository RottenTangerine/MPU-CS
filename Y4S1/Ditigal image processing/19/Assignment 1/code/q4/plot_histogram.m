function histogram = plot_histogram(img)
	[~, ~, channel] = size(img);
	hist = zeros(1, 256, channel);
	for g = 0:255
		hist(1, g+1, :) = sum(sum(img == g, 1), 2);
    end

	if channel == 3
		plot(0:255, hist(1, :, 1), 'r', 0:255, hist(1, :, 2), 'g', 0:255, hist(1, :, 3), 'b');
        title('Histogram (colored)');
	    xlabel('g');
	    ylabel('pixels');
	else 
		plot(0:255, hist(1, :, 1));
        title('Histogram (monochrome)');
	    xlabel('g');
	    ylabel('pixels');
    end
    histogram = hist;
end

