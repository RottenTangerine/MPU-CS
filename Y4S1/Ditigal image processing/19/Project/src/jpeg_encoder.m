function [header_dict, header_ac_seperator, header_resolution, header_quality, bit_stream] = jpeg_encoder(img, quality_coef)
    header_quality = quality_coef;
    bit_stream = [];
    AC_lengths = [];
    header_resolution = size(img);

    % RGB to YCbCr
    Y = rgb2ycbcr(img);
    Y_dsp = Y;

    % Downsample Cb and Cr channels
    Y_dsp(:,:,2) = 2 * round(Y_dsp(:,:,2)/2);
    Y_dsp(:,:,3) = 2 * round(Y_dsp(:,:,3)/2);

    Q = [16 11 10 16 24 40 51 61 ;
         12 12 14 19 26 28 60 55 ;
         14 13 16 24 40 57 69 56 ;
         14 17 22 29 51 87 80 62 ;
         18 22 37 56 68 109 103 77 ;
         24 35 55 64 81 104 113 92 ;
         49 64 78 87 103 121 120 101 ;
         72 92 95 98 112 100 103 99];

    zigzag = [1 2 6 7 15 16 28 29;
              3 5 8 14 17 27 30 43;
              4 9 13 18 26 31 42 44;
              10 12 19 25 32 41 45 54;
              11 20 24 33 40 46 53 55;
              21 23 34 39 47 52 56 61;
              22 35 38 48 51 57 60 62;
              36 37 49 50 58 59 63 64];


    first = 1;
    % seperate image as 8x8 blocks
    [row, column, ~] = size(Y_dsp);
    Y_dct = zeros(size(Y_dsp));

    for channel = 1:3
        for j = 1:8:row - 7
            for k = 1:8:column - 7

                % 2D DCT
                Y_dct(j:j+7, k:k+7, channel) = dct2(Y_dsp(j:j+7, k:k+7, channel));

                % Quantization using table Q
                Y_dct(j:j+7, k:k+7, channel) = round(Y_dct(j:j+7, k:k+7, channel) ./ (Q * quality_coef));

                % Zigzag scan and convert to 1D array
                Y_lin = zeros(1, 64);
                for i = 1:8
                    Y_lin(zigzag(i, :)) = Y_dct(j+i-1, k:k+7, channel);
                end

                % Extract DC (first digit diff)
                if first == 1
                    DC_prev = Y_lin(1);
                    DC = Y_lin(1);
                    first = 0;
                else
                    DC = Y_lin(1) - DC_prev;
                    DC_prev = Y_lin(1);
                end

                % Extract AC
                AC = Y_lin(2:end);

                % RLE encoding
                AC = rle(AC, "en");
                
                AC_lengths = [AC_lengths, length(AC)];

                bit_string = [DC, AC];
                bit_stream = [bit_stream, bit_string];
            end
        end
    end
    % Huffman encoding on all [DC + AC]'s
    [unique_symbols, ~, symbol_indices] = unique(bit_stream);
    symbol_counts = accumarray(symbol_indices(:), 1);
    symbol_counts = symbol_counts / sum(symbol_counts);
    dict = huffmandict(unique_symbols, symbol_counts);
    bit_stream = huffmanenco(bit_stream, dict);
    bit_stream = dec2bin(bit_stream);
    header_dict = dict;
    header_ac_seperator = rle(uint8(AC_lengths), "en");
end