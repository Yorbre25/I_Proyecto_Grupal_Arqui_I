Lxy = 300
from math import sin, pi
from PIL import Image

def main():
    SinFile = open('100sin.txt','r')
    SinData = SinFile.read().splitlines()
    SinFile.close()
    Frame1 = Image.open('barbara300.png')
    for frames in range(5,400,5):
        Axy = frames
        Frame2 = Image.new(mode="RGB", size=(300, 300))
        for x in range(Lxy):
            for y in range(Lxy):
                #calculo x nueva
                mem1 = int(SinData[y])
                mem1 *= Axy
                mem1 = mem1//100
                mem1 += x
                mem2 = mem1
                mem1 = mem1 % Lxy

                mem3 = int(SinData[x])
                mem3 *= Axy
                mem3 = mem3//100
                mem3 += y
                mem4 = mem3
                mem3 = mem3 % Lxy

                if(mem2 == mem1 and mem3 == mem4):
                    pixel = Frame1.getpixel((x,y))
                    Frame2.putpixel((mem1,mem3),pixel)
                #newX = 
                #print(pixel)
        Frame2.save('img/barbaraImgParsed'+str(Axy//5)+'.png','PNG')
main()

