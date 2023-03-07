img = imread('operahouse.tif');
med = median_filter(img);
avg = average_filter(img, 3);
imwrite(med, 'operahouse_med.tif');
imwrite(avg, 'operahouse_avg.tif');

tiledlayout(1, 3);

nexttile;
imshow(img);
title('Original');

nexttile;
imshow(med);
title('Median');

nexttile;
imshow(avg);
title('Average');
