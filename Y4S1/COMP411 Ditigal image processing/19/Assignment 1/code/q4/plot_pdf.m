function distribution = plot_pdf(img)
	[row, column, ~] = size(img);
	hist = plot_histogram(img);
	pdf = hist / (row * column);
	plot(pdf);
	title('Probability Distribution Function');
	xlabel('intensity');
	ylabel('probability');
    distribution = pdf;
end

