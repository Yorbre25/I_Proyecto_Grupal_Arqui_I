import sys
def SinMif():
    if (len(sys.argv) < 2):
        input_filename = 'Software/100sin.txt'
        output_filename = 'Software/Sin100.mif'

        im = open(input_filename,'r')
        new_image = im.resize((100, 100))
        new_image.save('myimage_100.png')
        f = []

        print("")
        h = 300

        print("> Writing to file: "+ output_filename)
        index = 0;
        for total in im.read().splitlines():
            hexa = hex(abs(int(total)))
            if total[0] == '-':
                hexa = hex(int(hexa[2:],16)|128)
            if (total == 0):
                hexa = "0x00"
            while len(hexa[2:]) < 2:
                hexa = f'0x0{hexa[2:]}'
            f.append(hex(index)[2:] + ":\t"+hexa[2:]+";\n")

            index += 1
        return f, index
    else:
        print("NEED MOAR INFO")