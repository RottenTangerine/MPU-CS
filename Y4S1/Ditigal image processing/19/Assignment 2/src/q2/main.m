img = imread('tree.bmp');
tiledlayout(2,3);

nexttile;
imshow(img);

nexttile;
plot_pdf(img);

nexttile;
plot_cdf(img);

stretched = histo_stretch(img, 125, 200, 0, 255);

nexttile;
imshow(stretched);

nexttile;
plot_pdf(stretched);

nexttile;
plot_cdf(stretched);