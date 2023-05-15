
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
    input_filename = 'Software/barbaraGrey300.png'
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
    f.write(str(8))
    f.write(header_2)


    for x in range(0, w):
        for y in range(0, h):
            total = im.getpixel((x,y))& 255
            hexa = hex(total)
            if (total == 0):
                hexa = "0x00"
            while len(hexa[2:]) < 2:
                hexa = f'0x0{hexa[2:]}'
            lines.append(hex(index)[2:] + ":\t"+hexa[2:]+";\n")
            index += 1
    for x in range(0, w):
        for y in range(0, h):
            total = im.getpixel((x,y))& 255
            hexa = hex(total)
            if (total == 0):
                hexa = "0x00"
            while len(hexa[2:]) < 2:
                hexa = f'0x0{hexa[2:]}'
            lines.append(hex(index)[2:] + ":\t"+hexa[2:]+";\n")
            index += 1
    f.writelines(lines)
    f.write("END;")

    print(">>> DONE");

else:
    print("NEED MOAR INFO")