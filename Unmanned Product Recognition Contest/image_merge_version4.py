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
file_title = 'Multi_Merge2_'; # 파일명
n = 5; # 만들 사진의 갯수

paths = [];
for path in range(len(products)):
    paths.append('C:/Users/Han/Desktop/auto_selling/' + classes[products[path]] + '/*.jpg');

#%% 그림 합치기고 저장하기
background_titles = random.sample(glob.glob(background_path), n);
for img in range(n):
    images = [];
    texts = [];
    titles = [];
    for path in range(2):
        titles.append(random.choice(glob.glob(random.choice(paths))));
        original_image = cv2.imread(titles[path]);
        res_image = cv2.resize(original_image, (160, 120));
        images.append(res_image);
        lines = open(str(titles[path])[:-4] + '.txt', 'r').readlines();
        for line in range(len(lines)):
            lines[line] = lines[line].split(' ');
        texts.append(lines);
    
    background_title =  background_titles[img];
    background = np.array(cv2.imread(background_title));
    background_texts = [];
    background_lines = open(str(background_title[:-4]+ '.txt'), 'r');  
    h, w, c = res_image.shape; 
    bbs_aug = [];
    for prd in range(2):
        roi = background[prd*360 : prd*360+120, prd*480: prd*480+160];
        mask = cv2.cvtColor(images[prd], cv2.COLOR_BGR2GRAY);
        mask[mask[:]==255]=0;
        mask[mask[:]>4]=255;
        mask_inv = cv2.bitwise_not(mask);
        image2 = cv2.bitwise_and(images[prd], images[prd], mask=mask);
        back = cv2.bitwise_and(roi, roi, mask=mask_inv);
        dst = cv2.add(image2, back);
        background[prd*360 : prd*360+120, prd*480: prd*480+160] = dst;
        bbs_aug.append([texts[prd][0][0]+' ' ,str((prd*480+float(texts[prd][0][1])*160)/640)+' ',str((prd*360+float(texts[prd][0][2])*120)/480)+' ',str(float(texts[prd][0][3])*0.25)+' ',str(float(texts[prd][0][4])*0.25)+'\n'])
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/'+ file_title +str(img)+'.jpg'), background);
    tx = open('C:/Users/Han/Desktop/auto_selling/Aug/'+file_title +str(img) +'.txt', 'w');
    for j in range(2):
        tx.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    tx.write(background_lines.read());            
    tx.close();