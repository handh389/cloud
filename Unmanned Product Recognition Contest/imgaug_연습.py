import imgaug.augmenters as iaa;
from imgaug.augmentables.bbs import BoundingBox, BoundingBoxesOnImage;
import cv2;
import os;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
path = 'C:/Users/Han/Desktop/auto_selling/dataset1_ex/'
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
# 그림 어렵게 만들기        
seq = iaa.Sequential([iaa.Fliplr(0.5),\
                      # 수평으로 50%의 이미지를 뒤집은 후
                      iaa.GaussianBlur(sigma=(0, 0.5)),\
                          # 이 후 이미지를 blur하게 만들고
                          iaa.LinearContrast((0.75, 1.5)),\
                              # 이미지의 노이즈도 늘리고
                              iaa.Multiply((0.8, 1.2), per_channel=0.2)])
#--------------------------------------------------------------------------------------------------------
# 파일 저장하기
for img in range(0, len(txt_text)):
    boundingboxes = [];
    images_aug = [];
    bbs_aug = [];
    for prd in range(0, len(txt_text[img])):
        boundingboxes.append(BoundingBox(640*(float(txt_text[img][prd][1])-0.5*float(txt_text[img][prd][3])),\
                                         480*(float(txt_text[img][prd][2])-0.5*float(txt_text[img][prd][4])),\
                                             640*(float(txt_text[img][prd][1])+0.5*float(txt_text[img][prd][3])),\
                                                 480*(float(txt_text[img][prd][2])+0.5*float(txt_text[img][prd][4]))));
    bbs = BoundingBoxesOnImage(boundingboxes, shape=jpg_img[img].shape);
    images_aug, bbs_aug = seq(image = jpg_img[img], bounding_boxes = bbs);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug', f'Aug_'+jpg_title[img]+'.jpg'), images_aug);
    Aug_txt_text = []
    for i in range(len(bbs.bounding_boxes)):
        after = bbs_aug.bounding_boxes[i]
        Aug_txt_text.append([txt_text[img][i][0]+' ' ,str((after.x1+after.x2)/(2*images_aug.shape[1]))+' ',str((after.y1+after.y2)/(2*images_aug.shape[0]))+' ',str((after.x2-after.x1)/images_aug.shape[1])+' ',str((after.y2-after.y1)/images_aug.shape[0])+'\n']);
    tx = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'Aug_'+jpg_title[img]+'.txt', 'w');
    for j in range(len(Aug_txt_text)):
        tx.writelines([Aug_txt_text[j][0], Aug_txt_text[j][1], Aug_txt_text[j][2], Aug_txt_text[j][3], Aug_txt_text[j][4]]);