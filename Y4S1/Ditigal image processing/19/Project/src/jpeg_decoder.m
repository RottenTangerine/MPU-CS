function img = jpeg_decoder(header_dict, header_ac_seperator, header_resolution, quality_coef, content)

    inverse_zigzag = [1 2 6 7 15 16 28 29;
                      3 5 8 14 17 27 30 43;
                      4 9 13 18 26 31 42 44;
                      10 12 19 25 32 41 45 54;
                      11 20 24 33 40 46 53 55;
                      21 23 34 39 47 52 56 61;
                      22 35 38 48 51 57 60 62;
                      36 37 49 50 58 59 63 64];

    Q = [16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];

    bit_stream = huffmandeco(bin2dec(content), header_dict);
    header_ac_seperator = rle(header_ac_seperator, "de");
    block_row = header_resolution(1) / 8;
    block_col = header_resolution(2) / 8;
    img = zeros(header_resolution);

    head = 1;
    DC_prev = bit_stream(1);

    current_row = 1;
    current_col = 1;
    current_channel = 1;

    for i = 1:length(header_ac_seperator)
        cut = uint32(header_ac_seperator(i));
        DC = bit_stream(head);
        AC = bit_stream(head+1:head+cut);

        % RLE decoding
        AC = rle(AC, "de");

        % Calculate DC
        if head ~= 1
            DC = DC_prev + DC;
            DC_prev = DC;
        end

        block = [DC AC];

        % inverse zigzag
        try
            block = block(inverse_zigzag);
        catch
            continue
        end

        % inverse quantization
        block = block .* Q * quality_coef;

        % inverse DCT
        block = idct2(block);
        block = uint8(block);

        img(current_row:current_row+7, current_col:current_col+7, current_channel) = block;

        current_col = current_col + 8;

        if current_col > block_col * 8
            current_col = 1;
            current_row = current_row + 8;
        end

        if current_row > block_row * 8
            current_row = 1;
            current_channel = current_channel + 1;
        end

        head = head + cut + 1;
    end

    img = uint8(img);
    img = ycbcr2rgb(img);
end