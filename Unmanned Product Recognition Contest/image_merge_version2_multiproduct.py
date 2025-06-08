import numpy as np;
import cv2;
import os;
from PIL import Image;
import random;
import glob;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
path0 = 'C:/Users/Han/Desktop/auto_selling/haribo/*.jpg'
path1 = 'C:/Users/Han/Desktop/auto_selling/redbull/*.jpg'
path2 = 'C:/Users/Han/Desktop/auto_selling/spam/*.jpg'
path3 = 'C:/Users/Han/Desktop/auto_selling/coca_cola/*.jpg'
path4 = 'C:/Users/Han/Desktop/auto_selling/dr_pepper/*.jpg'
path5 = 'C:/Users/Han/Desktop/auto_selling/cheese/*.jpg'
paths = path0, path1, path2, path3, path4, path5;
#--------------------------------------------------------------------------------------------------------
#%% 그림 합치기고 저장하기
n = 5; # 만들 사진의 갯수
x = 40; y =40; xl= 40; yl = 40; 
for img in range(n):
    images = [];
    texts = [];
    titles = [];
    for path in range(len(paths)):
        titles.append(random.choice(glob.glob(paths[path])));
        original_image = cv2.imread(titles[path]);
        res_image = cv2.resize(original_image, (320, 240));
        images.append(res_image);
        lines = open(str(titles[path])[:-4] + '.txt', 'r').readlines();
        for line in range(len(lines)):
            lines[line] = lines[line][:-1].split(' ');
        texts.append(lines);
    background = np.array(Image.new("RGB",(640,480),(213,213,213)));
    h, w, c = res_image.shape; 
    bbs_aug = [];
    for prd in range(len(paths)):
        roi = background[y+prd*yl : y+prd*yl+h, x+prd*xl : x+prd*xl+w];
        mask = cv2.cvtColor(images[prd], cv2.COLOR_BGR2GRAY);
        mask[mask[:]==255]=0;
        mask[mask[:]>4]=255;
        mask_inv = cv2.bitwise_not(mask);
        image2 = cv2.bitwise_and(images[prd], images[prd], mask=mask);
        back = cv2.bitwise_and(roi, roi, mask=mask_inv);
        dst = cv2.add(image2, back);
        background[y+prd*yl : y+prd*yl+h, x+prd*xl : x+prd*xl+w] = dst;
        bbs_aug.append([texts[prd][0][0]+' ' ,str((x+prd*xl+float(texts[prd][0][1])*320)/640)+' ',str((y+prd*yl+float(texts[prd][0][2])*240)/480)+' ',str(float(texts[prd][0][3])/2)+' ',str(float(texts[prd][0][4])/2)+'\n'])
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug', f'Multi_Merge_'+str(img)+'.jpg'), background);
    tx = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'Multi_Merge_'+str(img) +'.txt', 'w');
    for j in range(len(paths)):
        tx.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    tx.close();