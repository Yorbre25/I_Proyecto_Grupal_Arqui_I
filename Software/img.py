from operator import xor
import os
import sys
import binascii
from PIL import Image
filename = 'myimage_100.png'
filename2 = 'myimage_1002.png'
Frame1 = Image.open(filename)
key = 255
for frames in range(5,400,5):
        Frame2 = Image.new(mode="RGB", size=(100, 100))
        for x in range(100):
            for y in range(100):
                Frame2.putpixel((x,y),(xor(Frame1.getpixel((x,y))[0],key), xor(Frame1.getpixel((x,y))[1],key), xor(Frame1.getpixel((x,y))[2],key)))
        Frame2.save(filename2,'PNG')

with open(filename2, 'rb') as file:
    image_data = file.read()

data = binascii.hexlify(image_data)

binary = bin(int(data, 16))
binary = binary[2:].zfill(32)

parsed_filename = os.path.splitext(os.path.basename(filename))[0]
binary_filename = 'img.bin'
with open(binary_filename, 'wb') as file:
    file.write(binary.encode());