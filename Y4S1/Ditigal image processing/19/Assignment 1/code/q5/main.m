p1 = imread("p1.tif");
p2 = imread("p2.tif");

tiledlayout(1, 3);
nexttile;
imshow(p1)
title("lena")

nexttile;
imshow(p2)
title("mandril")

% Generate a new image by subtracting these two images with different weights, e.g.   0.4 *img1+0.8*img2
new_image = 1.2 * p1 + 1.2 * p2;

% (4) in which condition the whole new image is totally white ?
% for each pixel, if the addition of the two images is greater than 255
% then the pixel is white, hence if the whole new image is totolly white, then
% every single pixel in the new image is greater than 255

% imsave("addition.bmp")

nexttile;
imshow(new_image)
title("new image")
