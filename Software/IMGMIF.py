
from ast import Bytes
import sys
from PIL import Image
from ARRAYMIF import *

header = """
-- MADE BY Brian Wagemans
DEPTH =  """

header_2 = """;
WIDTH = 2;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT
BEGIN\n"""

if (len(sys.argv) < 2):
    input_filename = 'myimage_100.png'
    output_filename = 'myimage_100.bin'

    im = Image.open(input_filename)
    f = open(output_filename, 'w');

    print("> Image size: ")
    print(im.size)
    print("")
    w = im.size[0]
    h = im.size[1]

    print("> Writing to file: "+ output_filename)
    lines = []
    index = 0
    for x in range(0, w):
        for y in range(0, h):
            total = round(sum(im.getpixel((x,y)))/3)& 255
            hexa = (bin(int(bin(ord(total)))-48))
            lines.append(hexa)
            index += 1
    f.writelines(lines)
    print(">>> DONE");

else:
    print("NEED MOAR INFO")