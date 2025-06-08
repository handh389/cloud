import imgaug as ia;
import numpy as np;
import imgaug.augmenters as iaa;
from imgaug import parameters as iap;
from imgaug.augmentables.bbs import BoundingBox, BoundingBoxesOnImage
import cv2;
import os;
from PIL import Image;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
path = 'C:/Users/Han/Desktop/auto_selling/haribo/'
os.chdir(path) # 해당 폴더로 이동
files = os.listdir(path) # 해당 폴더에 있는 파일 이름을 리스트 형태로 받음
jpg_img = [];
jpg_title = [];
txt_text = [];
for file in files:
    if '.jpg' in file: 
        f = cv2.imread(file)
        g = str(file);
        jpg_img.append(f)
        jpg_title.append(g);
    if str(file[:-4]) + '.txt' in file:
        t = open(file, 'r').readlines();
        for i in range(0, len(t)):
            t[i] = t[i][:-1].split(' ');
        txt_text.append(t);    
#--------------------------------------------------------------------------------------------------------
#%% 그림 합치기고 저장하기
x = 300; y =300; xl= 100; yl = 100; s = 3; n = 5; # 처음 물체를 놓는 x, y좌표, 물체 간 간격, 그림을 확대한 비율, 물체 갯수
# x, y, n은 왠만하면 그대로 두기
# 만약 대각선으로 배치하고 싶다면 xl과 yl을 같은 절댓값으로 한다.
# 만약 가로로만 배치하고 싶다면 yl을 0으로 한다.
# 만약 세로로만 배치하고 싶다면 xl을 0으로 한다.
# 대각선일 때는 공간적인 여유가 커서 xl, y1을 작게 해도 겹치는 공간이 적지만
# 가로, 혹은 세로로만 배치할 때는 공간적인 여유가 좁아서 xl, yl을 늘리는게 좋다.
for img in range(0, len(txt_text)):
    background = np.array(Image.new("RGB",(640*s,480*s),(255,255,255)));
    image = jpg_img[img];
    h, w, c = image.shape;
    bbs_aug = [];
    for i in range(n):
        roi = background[y+i*yl : y+i*yl+h, x+i*xl : x+i*xl+w]; 
        mask = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY);
        mask[mask[:]==255]=0;
        mask[mask[:]>0]=255;
        mask_inv = cv2.bitwise_not(mask); 
        image2 = cv2.bitwise_and(image, image, mask=mask);
        back = cv2.bitwise_and(roi, roi, mask=mask_inv);
        dst = cv2.add(image2, back)
        background[y+i*yl : y+i*yl+h, x+i*xl : x+i*xl+w] = dst;
        bbs_aug.append([txt_text[i][0][0]+' ' ,str((x+i*xl+float(txt_text[img][0][1])*640)/(640*s))+' ',str((y+i*yl+float(txt_text[img][0][2])*480)/(480*s))+' ',str(float(txt_text[img][0][3])/s)+' ',str(float(txt_text[img][0][4])/s)+'\n'])
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug', f'Merge_'+jpg_title[img]+'.jpg'), background);
    tx = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'Merge_'+jpg_title[img]+'.txt', 'w');
    for j in range(n):
        tx.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);