import numpy as np;
import cv2;
import os;
from PIL import Image;
import random;
import glob;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
classes = 'haribo', 'redbull', 'spam', 'coca_cola';

products = 0, 1; # 상품 번호
background_color = (213, 0, 0); # 배경 색깔
file_title = 'Multi_Merge15_'; # 파일명
n = 5; # 만들 사진의 갯수

paths = [];
for path in range(len(products)):
    paths.append('C:/Users/Han/Desktop/auto_selling/' + classes[products[path]] + '/*.jpg');
#--------------------------------------------------------------------------------------------------------
#%% 그림 합치기고 저장하기
x = 0; y =0; xl= 80; yl = 100; 
for img in range(n):
    images = [];
    texts = [];
    titles = [];
    for path in range(15):
        titles.append(random.choice(glob.glob(random.choice(paths))));
        original_image = cv2.imread(titles[path]);
        res_image = cv2.resize(original_image, (320, 240));
        images.append(res_image);
        lines = open(str(titles[path])[:-4] + '.txt', 'r').readlines();
        for line in range(len(lines)):
            lines[line] = lines[line].split(' ');
        texts.append(lines);
    background = np.array(Image.new("RGB",(640,480),background_color));
    h, w, c = res_image.shape; 
    bbs_aug = [];
    for prdy in range(3):
        for prdx in range(5):
            roi = background[y+prdy*yl : y+prdy*yl+h, x+prdx*xl : x+prdx*xl+w];
            mask = cv2.cvtColor(images[prdy*4+prdx], cv2.COLOR_BGR2GRAY);
            mask[mask[:]==255]=0;
            mask[mask[:]>4]=255;
            mask_inv = cv2.bitwise_not(mask);
            image2 = cv2.bitwise_and(images[prdy*4+prdx], images[prdy*4+prdx], mask = mask);
            back = cv2.bitwise_and(roi, roi, mask = mask_inv);
            dst = cv2.add(image2, back);
            background[y+prdy*yl : y+prdy*yl+h, x+prdx*xl : x+prdx*xl+w] = dst;
            bbs_aug.append([texts[prdy*4+prdx][0][0]+' ' ,str((x+prdx*xl+float(texts[prdy*4+prdx][0][1])*320)/640)+' ',str((y+prdy*yl+float(texts[prdy*4+prdx][0][2])*240)/480)+' ',str(float(texts[prdy*4+prdx][0][3])*0.5)+' ',str(float(texts[prdy*4+prdx][0][4])*0.5)+'\n'])
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/'+ file_title +str(img)+'.jpg'), background);
    tx = open('C:/Users/Han/Desktop/auto_selling/Aug/'+file_title +str(img) +'.txt', 'w');
    for j in range(15):
        tx.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    tx.close();