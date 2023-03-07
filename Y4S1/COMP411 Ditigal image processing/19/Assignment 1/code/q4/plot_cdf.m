function distribution = plot_cdf(img)
	pdf = plot_pdf(img);
	cdf = zeros(256, 1);
	for i = 1:256
		cdf(i) = sum(pdf(1:i));
	end
	plot(cdf);
	title('Cumulative Distribution Function');
	xlabel('intensity');
	ylabel('probability');
	distribution = cdf;
end

