
import sys
from PIL import Image
from ARRAYMIF import *

header = """
-- MADE BY Brian Wagemans
DEPTH =  """

header_2 = """;
WIDTH = 6;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT
BEGIN\n"""

if (len(sys.argv) < 2):
    input_filename = 'Software/barbara300.png'
    output_filename = 'Software/barbara300.mif'

    im = Image.open(input_filename)

    f = open(output_filename, 'w');

    print("> Image size: ")
    print(im.size)
    print("")
    w = im.size[0]
    h = im.size[1]

    print("> Writing to file: "+ output_filename)
    lines,index = SinMif()
    f.write(header)
    f.write(str(24))
    f.write(header_2)


    for x in range(0, w):
        for y in range(0, h):
            r = im.getpixel((x,y))[0] & 255
            g = im.getpixel((x,y))[1] & 255
            b = im.getpixel((x,y))[2] & 255

            total = r<< 16| g << 8 | b ;


            hexa = hex(total)

            if (total == 0):
                hexa = "0x0000"

            lines.append(hex(index)[2:] + ":\t"+hexa[2:]+";\n")

            index += 1
    for x in range(0, w):
        for y in range(0, h):
            r = im.getpixel((x,y))[0] & 255
            g = im.getpixel((x,y))[1] & 255
            b = im.getpixel((x,y))[2] & 255

            total = r<< 16| g << 8 | b ;


            hexa = hex(total)

            if (total == 0):
                hexa = "0x0000"

            lines.append(hex(index)[2:] + ":\t"+hexa[2:]+";\n")

            index += 1
    f.writelines(lines)
    f.write("END;")

    print(">>> DONE");

else:
    print("NEED MOAR INFO")