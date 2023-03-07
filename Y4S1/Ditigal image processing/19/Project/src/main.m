% setups: me.tiff is uncompressed 400x400x3 RGB image
filename = 'me.tiff';
saved_filename = 'me-compress.tiff';
quality_coef = 1.18;
img = imread(filename);


% original image in memory (headerless) data size
original_bytes = whos('img').bytes;


% applying jpeg encoder, and got:
% - image header: header_dict, header_ac_seperator, header_resolution, header_quality
% - image content: content
[header_dict, header_ac_seperator, header_resolution, header_quality, content] = jpeg_encoder(img, quality_coef);


% bytes comparison
content_bytes = whos('content').bytes;
headers_bytes = whos('header_ac_seperator').bytes + whos('header_dict').bytes + whos('header_resolution').bytes + whos('header_quality').bytes;
compressed_bytes = content_bytes + headers_bytes;
disp("Before compression (bytes): " + original_bytes);
disp(" After compression (bytes): " + compressed_bytes);
disp("         Compression ratio: " + original_bytes/compressed_bytes);


% applying jpedg decoder to bitstream, and got: decoded image
decoded_img = jpeg_decoder(header_dict, header_ac_seperator, header_resolution, header_quality, content);

% diff analyzing
diff = abs(uint8(img - decoded_img));
diff(diff>3) = 255;
imwrite(diff, "diff.tiff")

% psnr value
value = my_psnr(img, decoded_img);
disp("           PSNR value (dB): " + value);