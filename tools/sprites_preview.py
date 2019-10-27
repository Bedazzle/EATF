import os

import PIL
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw 


BASE = '..\\'
SOURCE = 'eric_decoded.bin'
TARGET = 'eric_decoded.png'
ADR = 32768

#SOURCE = 'bomberman.bin'
#TARGET = 'bomberman.png'
#ADR = 16384


IMAGE_WIDTH = 400
IMAGE_HEIGHT = 2100


class zxbin(object):
    '''
    classdocs
    '''

    def __init__(self, filename, offset):
        '''
        Constructor
        '''

        self.raw = open(filename, "rb").read()
        self.offset = offset

        # CL_BLK EQU 0    ; black        000
        # CL_BLU EQU 1    ; blue        001
        # CL_RED EQU 2    ; red        010
        # CL_MGN EQU 3    ; magenta    011
        # CL_GRN EQU 4    ; green        100
        # CL_SKY EQU 5    ; skyblue    101
        # CL_YEL EQU 6    ; yellow    110
        # CL_WHT EQU 7    ; white        111

        self.BRIGHT = {
            0: (0,0,0),          # CL_BLK
            1: (0,0,255),        # CL_BLU
            2: (255,0,0),        # CL_RED
            3: (255,0,255),      # CL_MGN
            4: (0,255,0),        # CL_GRN
            5: (0,255,255),      # CL_SKY
            6: (255,255,0),      # CL_YEL
            7: (255,255,255),    # CL_WHT
        }
        
        self.REGULAR = {
            0: (0,0,0),          # CL_BLK
            1: (0,0,215),        # CL_BLU
            2: (215,0,0),        # CL_RED
            3: (215,0,215),      # CL_MGN
            4: (0,215,0),        # CL_GRN
            5: (0,215,215),      # CL_SKY
            6: (215,215,0),      # CL_YEL
            7: (215,215,215),    # CL_WHT
        }

        self.set_ink(0)
        self.set_paper(7)
        self.reset_bright()
        

    def __enter__(self):
        return self


    def __exit__(self, exception_type, exception_value, traceback):
        try:
            pass
        except Exception as error:
            print('Error closing')
            raise error
        
    def get_byte(self, adr):
        try:
            return self.raw[adr - self.offset]
        except Exception as error:
            print('adr=', adr, 'offset=', self.offset)
            raise error

    def set_ink(self, index):
        self.ink = index
         
    def set_paper(self, index):
        self.paper = index
        
    def set_bright(self):
        self.brightness = True
        self.colors = self.BRIGHT
    
    def reset_bright(self):
        self.brightness = False
        self.colors = self.REGULAR

    def byte_to_colors(self, source):
        result = []
        for bit in format(source, '08b'):
            if bit == '0':
                result.append(self.colors[self.paper])
            else: 
                result.append(self.colors[self.ink])
            
        return result
    

    def set_color(self, source):
        b = format(source, '08b')
        _flash = b[0]
        bright = int(b[1], 2)
        paper = int(b[2:5], 2)
        ink = int(b[5:8], 2)
        
        self.set_ink(ink)
        self.set_paper(paper)
        
        if bright:
            self.set_bright()
        else:
            self.reset_bright()


with zxbin(BASE+SOURCE, ADR) as eric:
    with Image.new('RGB', (IMAGE_WIDTH, IMAGE_HEIGHT), color=(128,128,128,0)) as new_im:
        fonts_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'fonts')
        font = ImageFont.truetype(os.path.join(fonts_path, 'arial.ttf'), 8)
        draw = ImageDraw.Draw(new_im)

        # ------------------------                
        sprites = [
            {'adr': 37574, 'count': 256, 'x': 5, 'y': 1}
            ,
            {'adr': 39882, 'count': 10, 'x': 200, 'y': 1}
        ]
        
        for sprite in sprites:
            x = sprite['x']
            y = sprite['y']
            adr = sprite['adr']
            
            for num in range(sprite['count']):
                txt = '{}: {} / {}'.format(num, adr, format(adr, '02x'))
                
                draw.text((x+20, y-1), txt, (255,255,255), font=font)
    
                eric.set_color(eric.get_byte(adr+8))
                
                for src_addr in range(adr, adr+8):
                    data = eric.byte_to_colors(eric.get_byte(src_addr))
                    
                    for inx, clr in enumerate(data):
                        new_im.putpixel((x+inx, y), clr)
                    
                    y += 1
    
                adr += 9
        # ------------------------                
        sprites = [
            {'adr': 37574, 'count': 128, 'x': 100, 'y': 1}
            ,
            {'adr': 39980, 'count': 31, 'x': 200, 'y': 150}

            ,
            {'adr': 40564, 'count': 1, 'x': 200, 'y': 500}
            ,
            {'adr': 40586, 'count': 1, 'x': 200, 'y': 508}
            ,
            {'adr': 40608, 'count': 1, 'x': 200, 'y': 516}
            ,
            {'adr': 40630, 'count': 1, 'x': 200, 'y': 524}
            ,
            {'adr': 40652, 'count': 1, 'x': 200, 'y': 532}
            ,
            {'adr': 40674, 'count': 1, 'x': 200, 'y': 540}
            ,
            {'adr': 40696, 'count': 1, 'x': 200, 'y': 548}
            ,
            {'adr': 40718, 'count': 1, 'x': 200, 'y': 556}
            ,
            {'adr': 40740, 'count': 1, 'x': 200, 'y': 564}
            ,
            {'adr': 40762, 'count': 1, 'x': 200, 'y': 572}
            ,
            {'adr': 40784, 'count': 1, 'x': 200, 'y': 580}
            ,
            {'adr': 40806, 'count': 1, 'x': 200, 'y': 588}
            ,
            {'adr': 40828, 'count': 1, 'x': 200, 'y': 596}
            ,
            {'adr': 40850, 'count': 1, 'x': 200, 'y': 604}
            ,
            {'adr': 40872, 'count': 1, 'x': 200, 'y': 612}
            ,
            {'adr': 40894, 'count': 1, 'x': 200, 'y': 620}
        ]
        
        for sprite in sprites:
            x = sprite['x']
            y = sprite['y']
            adr = sprite['adr']
            
            for num in range(sprite['count']):
                txt = '{}: {} / {}'.format(num, adr, format(adr, '02x'))

                draw.text((x+20, y-1), txt, (255,255,255), font=font)

                for pair in range(2):
                    eric.set_color(eric.get_byte(adr+8))
                    
                    for src_addr in range(adr, adr+8):
                        data = eric.byte_to_colors(eric.get_byte(src_addr))
                        
                        for inx, clr in enumerate(data):
                            new_im.putpixel((x+inx, y), clr)
                        
                        y += 1
                        
                    y -= 8
                    x += 8
        
                    adr += 9
                
                y += 8
                x -= 16
        # ------------------------                
        sprites = [
            {'adr': 37880, 'count': 7, 'x': 300, 'y': 1}
			,
            {'adr': 39590, 'count': 8, 'x': 300, 'y': 200}
			,
            {'adr': 38438, 'count': 8, 'x': 300, 'y': 350}
			,
            {'adr': 39998, 'count': 7, 'x': 300, 'y': 500}
			,
            {'adr': 40268, 'count': 8, 'x': 300, 'y': 650}
			,
            {'adr': 39302, 'count': 8, 'x': 300, 'y': 800}
			,
            {'adr': 39014, 'count': 8, 'x': 200, 'y': 650}
			,
            {'adr': 38816, 'count': 3, 'x': 200, 'y': 800}
			,
            {'adr': 37664, 'count': 3, 'x': 200, 'y': 900}
        ]

        for sprite in sprites:
            x = sprite['x']
            y = sprite['y']
            adr = sprite['adr']
            
            for num in range(sprite['count']):
                txt = '{}: {} / {}'.format(num, adr, format(adr, '02x'))

                draw.text((x+20, y-1), txt, (255,255,255), font=font)

                backup = adr
                
                for hilo in range(2):
                    for pair in range(2):
                        eric.set_color(eric.get_byte(adr+8))
                        
                        for src_addr in range(adr, adr+8):
                            data = eric.byte_to_colors(eric.get_byte(src_addr))
                            
                            for inx, clr in enumerate(data):
                                new_im.putpixel((x+inx, y), clr)
                            
                            y += 1
                            
                        y -= 8
                        x += 8
            
                        adr += 9
                    
                    y += 8
                    x -= 16
                    
                    adr = backup + 16*9
                    
                adr = backup + 9*2
        # ------------------------                


# bomberman
#        # ------------------------                
#        sprites = [
#            {'adr': 37350, 'count': 128, 'x': 100, 'y': 1}
#			,
#            {'adr': 39658, 'count': 5, 'x': 200, 'y': 1}
#        ]
#        
#        for sprite in sprites:
#            x = sprite['x']
#            y = sprite['y']
#            adr = sprite['adr']
#            
#            for num in range(sprite['count']):
#                txt = '{}: {} / {}'.format(num, adr, format(adr, '02x'))
#
#                draw.text((x+20, y-1), txt, (255,255,255), font=font)
#
#                for pair in range(2):
#                    eric.set_color(eric.get_byte(adr+8))
#                    
#                    for src_addr in range(adr, adr+8):
#                        data = eric.byte_to_colors(eric.get_byte(src_addr))
#                        
#                        for inx, clr in enumerate(data):
#                            new_im.putpixel((x+inx, y), clr)
#                        
#                        y += 1
#                        
#                    y -= 8
#                    x += 8
#        
#                    adr += 9
#                
#                y += 8
#                x -= 16
#        # ------------------------                




                
        new_im.show()
        new_im.save(TARGET)
        print('Saved "{}"'.format(TARGET))
