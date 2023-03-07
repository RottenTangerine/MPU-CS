import PIL.Image as Image
import numpy as np
import matplotlib.pyplot as plt

def guassian_filter(img, sigma=1):
    # get size of image
    m, n = img.shape
    # get size of kernel
    size = int(6 * sigma + 1)
    # get center of kernel
    center = size // 2
    # initialize kernel
    kernel = np.zeros((size, size), dtype=np.float32)
    # calculate kernel
    for i in range(size):
        for j in range(size):
            x, y = i - center, j - center
            kernel[i, j] = np.exp(-(x**2 + y**2) / (2 * sigma**2))
    kernel /= (2 * np.pi * sigma**2)
    # initialize output image
    output = np.zeros((m, n), dtype=np.float32)
    # convolution
    for i in range(m):
        for j in range(n):
            for k in range(size):
                for l in range(size):
                    ii = i + k - center
                    jj = j + l - center
                    if ii >= 0 and ii < m and jj >= 0 and jj < n:
                        output[i, j] += img[ii, jj] * kernel[k, l]
    return output

def sobel_filter(img):
    # get size of image
    m, n = img.shape
    # initialize output image
    output = np.zeros((m, n), dtype=np.float32)
    # convolution
    for i in range(1, m - 1):
        for j in range(1, n - 1):
            output[i, j] = np.sqrt((img[i - 1, j - 1] + 2 * img[i - 1, j] + img[i - 1, j + 1] - img[i + 1, j - 1] - 2 * img[i + 1, j] - img[i + 1, j + 1])**2 +
                                   (img[i - 1, j - 1] + 2 * img[i, j - 1] + img[i + 1, j - 1] - img[i - 1, j + 1] - 2 * img[i, j + 1] - img[i + 1, j + 1])**2)
    return output

def non_max_suppression(img):
    # get size of image
    m, n = img.shape
    # initialize output image
    output = np.zeros((m, n), dtype=np.float32)
    # non-max suppression
    for i in range(1, m - 1):
        for j in range(1, n - 1):
            # get gradient direction
            direction = np.arctan2(img[i, j], img[i, j])
            # get pixel value of 2 neighbors
            p1, p2 = 255, 255
            if (0 <= direction < np.pi / 8) or (7 * np.pi / 8 <= direction <= np.pi):
                p1, p2 = img[i, j + 1], img[i, j - 1]
            elif np.pi / 8 <= direction < 3 * np.pi / 8:
                p1, p2 = img[i + 1, j - 1], img[i - 1, j + 1]
            elif 3 * np.pi / 8 <= direction < 5 * np.pi / 8:
                p1, p2 = img[i + 1, j], img[i - 1, j]
            elif 5 * np.pi / 8 <= direction < 7 * np.pi / 8:
                p1, p2 = img[i + 1, j + 1], img[i - 1, j - 1]
            # compare pixel value
            if img[i, j] >= p1 and img[i, j] >= p2:
                output[i, j] = img[i, j]
            else:
                output[i, j] = 0
    return output

def threshold(img, low_threshold_ratio=0.05, high_threshold_ratio=0.09):
    # calculate high and low threshold
    high_threshold = img.max() * high_threshold_ratio
    low_threshold = high_threshold * low_threshold_ratio
    # get size of image
    m, n = img.shape
    # initialize output image
    res = np.zeros((m, n), dtype=np.float32)
    # thresholding
    weak = np.int32(25)
    strong = np.int32(255)
    strong_i, strong_j = np.where(img >= high_threshold)
    zeros_i, zeros_j = np.where(img < low_threshold)
    weak_i, weak_j = np.where((img <= high_threshold) & (img >= low_threshold))
    res[strong_i, strong_j] = strong
    res[weak_i, weak_j] = weak
    return (res, weak, strong)

def hysteresis(img, weak, strong):
    # get size of image
    m, n = img.shape
    for i in range(1, m-1):
        for j in range(1, n-1):
            if img[i, j] == weak:
                try:
                    if ((img[i + 1, j - 1] == strong) or (img[i + 1, j] == strong) or (img[i + 1, j + 1] == strong) or
                        (img[i, j - 1] == strong) or (img[i, j + 1] == strong) or
                        (img[i - 1, j - 1] == strong) or (img[i - 1, j] == strong) or (img[i - 1, j + 1] == strong)):
                        img[i, j] = strong
                    else:
                        img[i, j] = 0
                except IndexError as e:
                    pass
    return img

def canny_edge_detection(img, sigma):
    # guassian_filter
    img = guassian_filter(img, sigma)
    # sobel_filter
    img = sobel_filter(img)
    # non-max suppression
    img = non_max_suppression(img)
    # thresholding
    img, weak, strong = threshold(img)
    # hysteresis
    img = hysteresis(img, weak, strong)
    return img

def plot(img, canny):
    # plot original image and canny edge detection
    plt.subplot(121)
    plt.imshow(img, cmap='gray')
    plt.title('Original Image')
    plt.axis('off')
    plt.subplot(122)
    plt.imshow(canny, cmap='gray')
    plt.title('Canny Edge Detection')
    plt.axis('off')
    plt.show()

def main():
    # read image
    img = Image.open('img.jpg')
    # img to grayscale
    img = img.convert('L')
    # img to array
    img = np.array(img)
    # show original image and canny edge detection
    plot(img, canny_edge_detection(img, sigma=1))

if __name__ == "__main__":
    main()
