Lxy = 300
from math import sin, pi
from PIL import Image

def main():
    SinFile = open('100sin.txt','r')
    imgValFile = open('imageVal.txt','w')
    SinData = SinFile.read().splitlines()
    SinFile.close()
    Frame1 = Image.open('barbara300.png')
    new_image = Frame1.resize((10, 10))
    for i in range(100):
        for j in range(100):
            pixel = new_image.getpixel((i,j))
            
            imgValFile.write(str(pixel)+'\n')
    new_image.save('myimage_100.png')
    
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
                mem1 = mem1%300
                mem2 = int(SinData[x])
                mem2 *= Axy
                mem2 = mem2//100
                mem2 += y
                mem2 = mem2%300

                if(mem2 < 299 and mem1 < 299):
                    pixel = Frame1.getpixel((x,y))
                    try:
                        Frame2.putpixel((mem1+1,mem2+1),pixel)
                    except:
                        print('Ha fallado')
                        print((mem1+1,mem2+1))
                        exit()
                #newX = 
                #print(pixel)
        Frame2.save('img/barbaraImgParsed'+str(Axy//5)+'.png','PNG')
main()

