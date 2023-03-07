img = imread('./brain.bmp');
tiledlayout(2,2);

% (1) Calculate and display the histogram of the image
nexttile;
plot_histogram(img);

% (2) Calculate and display the PDF of the image
nexttile;
plot_pdf(img);

% (3) Calculate and display the CDF of the image
nexttile;
plot_cdf(img);

% (4) Generate a false color image of the given image with 5 colors. Give darker colors to low grey levels and brighter colors to high grey levels
nexttile;
false_img = false_image(img);
imshow(false_img);

% (5) Observe the false color image and describe the abnormal thing you observed
% The red zone is recognized specially among the large portion of the green
% area. Hence, it may possible that the red zone is abnormal and it is
% circled in the image.