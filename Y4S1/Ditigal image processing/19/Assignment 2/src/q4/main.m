tiledlayout(1, 2);

img = imread('operahouse_med.tif');
nexttile;
imshow(img);
title('Original');

res = laplacian_detector(img);

th = 10;
res(res>th) = 255;
res(res<th) = 0;

nexttile;
imshow(res);
title('Laplacian Edge');
imwrite(res, 'operahouse_edge.tif')
