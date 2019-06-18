#! /usr/bin/python3

from PIL import Image
import numpy as np
# from functools import reduce


def open_image(path):
    img = Image.open(path)
    img_8 = img.convert('P')
    img_8_resized = img_8.resize((320, 200), Image.ANTIALIAS)
    
    return img_8_resized

def get_pixels(image):
    _pixels = np.array(image.getchannel(0))
    return list(_pixels.flatten())

# def print_file(file_bytes):
#     for i in range(0, len(file_bytes), 4):

#         if i % 16 == 0:
#             if i != 0:
#                 print('')
#             print('0x{:>04X}   ->   '.format(i), end='', flush=True)

#         red_arr = reduce(
#             lambda s, _s : s + '{:>02X}'.format(_s),
#             file_bytes[i:i+4],
#             ''
#         )

#         print('0x' + red_arr + '   ', end='', flush=True)
#     print('')

#     return file_bytes


def read_bin_img(filename):
    file_bytes = []
    with open(filename + '.bin.img', 'rb') as img_file:
            file_bytes = list(img_file.read())
            img_file.close()

    return file_bytes


def write_bin_img(filename, pixels):
    with open(filename + '.bin.img', 'wb') as img_file:
        img_file.write(bytes(pixels))
        img_file.close()


def write_bin_palette(filename, pixels):
    with open(filename + '.bin.plt', 'wb') as plt_file:
        plt_file.write(bytes(pixels))
        plt_file.close()


if __name__ == '__main__':

    path = '/home/louisian/Imagens/heman.jpeg'

    img = open_image(path)
    filename = path.split('/')[-1].split('.')[0]
    pixels = get_pixels(img)

    write_bin_img(filename, pixels)
    write_bin_palette(filename, list(img.palette.palette))

    file_bytes = read_bin_img(filename)

    if file_bytes == pixels:
        print('TUDO CERTO MEU JOIA')
    else:
        print('DISGRAÇA, ALGO DE ERRADO')