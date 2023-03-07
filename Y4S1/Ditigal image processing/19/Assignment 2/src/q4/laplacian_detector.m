function newimg = laplacian_detector(img)
    w = [0 1 0; 1 -4 1; 0 1 0];
    newimg = my_filter(img, w);
end