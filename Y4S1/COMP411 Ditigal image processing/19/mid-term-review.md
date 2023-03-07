# Mid-term scale

1. terms - how to enhance the contrast

2. quantlization

3. one line of scilab code

4. code writing: assignment 4/5

## Points

levels of image processing
- low: image to image
- mid: image to attributes
- high: image to cognitives

- digitalizing the coordinate values is called **sampling**
- digitalizing the amplitude values is **quantization**

subsampling: 2:1 subsampling (2000 pixels to 1000 pixels)
quantilize 8-bit image to 4-bit -> (halved image file size)

upsampling: using interpolation

coordinate: spatial resolution - interpolation(插值) 
amplitude: intensity resolution - quantlization(量化)

histogram MATLAB
```MATLAB
img = imread(img);
[row, column, channel] = size(img);
h = zeros(1, 256, channel);
for g = 0:255
	h(1, g+1, :) = sum(sum(img == g, 1), 2);
end
h = h / (row * column);    % PDF
```

CDF
```MATLAB
cdf = zeros(256, 1)
for i = 1:256
	cdf(i) = sum(pdf(1:i))
end
```

thresholding
th = 100
I(I<th) = 0
I(I>=th) = 255

make image double: uint8 -> double
- wrap-around: 
	- s = s - 255 * n if s > 255
	- s = 0 if s < 0
- clipping: 
	- s = 255 if s > 255
	- s = 0 if s < 0
rounding img: double -> uint8

histogram equalization
histogram stretching -> enhance contrast
mapping fn(old_graylevel) -> new_graylevel

spatial filtering: (linear, non-linear)
- smoothing
- sharpening(x)

gradient-based edge detection: (roberts, prewitt, sobel)
mask -> | -1 -1 -1  |
				|	 0  0  0. |
				|	 1  1  1  |
as horizontal edge detector

## Exercise

1. Create a 5x5 average filter and store it in a variable `mask`.

```MATLAB
mask = ones(5, 5) / 25;
```

2. Given a grayscale image `img`, find the m x n neighborhood whose centre is (x,y) and store it in a variable `Nb`;

```MATLAB
Nb = img(x-(m-1)/2:x+(m-1)/2, y-(n-1)/2:y+(n-1)/2);
```

3. store the 10th row of a 2D matrix `img` in a variable `row`

```MATLAB
row = img(10, :);
```

4. Given a grayscale image `I`, set all the pixels in `I` whose grey levels are bigger than 255 to be 255.

```MATLAB
I(I>255) = 255;
```

5. Replace the red channel of a colour image `img` with its blue channel.

```MATLAB
img(:, :, 1) = img(:, :, 3);
```

6. store the value image of a colour image `img` in `V`.

```MATLAB
V = uint8(sum(img, 3) / 3);
```