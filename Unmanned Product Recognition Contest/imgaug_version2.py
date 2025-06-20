import imgaug.augmenters as iaa;
import cv2;
import os;
import random;
import glob;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
path = 'C:/Users/Han/Desktop/auto_selling/dataset1_ex/*.jpg'
#--------------------------------------------------------------------------------------------------------
#%% 색깔 바꾸기(Gamma contrast, 감마보정)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.GammaContrast((0.5, 2.0), per_channel=True);
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'gamma_contrast_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'gamma_contrast_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 색깔 바꾸기(log contrast)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.LogContrast(gain=(0.6, 1.4), per_channel=True);
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'log_contrast_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'log_contrast_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 색깔 바꾸기 (color temperature)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.ChangeColorTemperature((1100, 10000));
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'color_temp_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'color_temp_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 반대 픽셀(inverse pixel)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.Invert(1.0);
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'invert_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'invert_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 블러(Gaussian blur)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.GaussianBlur(sigma=(0.8, 3.0));
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'gaussian_blur_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'gaussian_blur_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 블러(avg blur)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.AverageBlur(k=(2, 11));
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'avg_blur_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'avg_blur_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 노이즈 만들기(가우시언 노이즈)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.imgcorruptlike.GaussianNoise(severity=(2, 4));
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'gaussian_noise_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'gaussian_noise_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 노이즈 만들기(pepper)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = aug = iaa.Pepper(0.1);
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'pepper_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'pepper_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 노이즈 만들기(salt)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.Salt(0.1);
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'salt_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'salt_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 밝기 조정(brightness)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.imgcorruptlike.Brightness(severity=(3,5));
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'brightness_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'brightness_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 그림 가리기(coarse dropout-10%)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.CoarseDropout(0.1, size_percent=0.1, per_channel=0.5);
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'coarse_dropout_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'coarse_dropout_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 그림 가리기(coarse pepper-10%)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.CoarsePepper(0.1, size_percent=(0.01, 0.1));
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'coarse_pepper_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'coarse_pepper_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 그림 가리기(coarse salt-10%)
n = 5; # 만들 사진의 갯수
for img in range(n):
    title = random.choice(glob.glob(path));
    image = cv2.imread(title);
    lines = open(str(title[:-4]+ '.txt'), 'r');
    aug = iaa.CoarseSalt(0.1, size_percent=(0.01, 0.1));
    image_aug = aug(image = image);
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'coarse_salt_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'coarse_salt_'+str(img) +'.txt', 'w');
    txt.write(lines.read());
    lines.close();
    txt.close();
#%% 그림 회전(위아래)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    texts = [];
    lines = open(str(title[:-4]+ '.txt'), 'r').readlines();
    for line in range(len(lines)):
        lines[line] = lines[line][:-1].split(' ');
    texts.append(lines);
    aug = iaa.Flipud(1.0);
    bbs_aug = [];
    for line in range(len(lines)):
        bbs_aug.append([texts[0][line][0]+' ' ,texts[0][line][1]+' ',str(1.0-float(texts[0][line][2]))+' ',texts[0][line][3]+' ',texts[0][line][4]+'\n']);
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'flipud_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'flipud_'+str(img) +'.txt', 'w');
    for j in range(len(lines)):
        txt.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    txt.close();
#%% 그림 회전(좌우)
n = 5; # 만들 사진의 갯수
titles = random.sample(glob.glob(path), n);
for img in range(n):
    title = titles[img];
    image = cv2.imread(title);
    texts = [];
    lines = open(str(title[:-4]+ '.txt'), 'r').readlines();
    for line in range(len(lines)):
        lines[line] = lines[line][:-1].split(' ');
    texts.append(lines);
    aug = iaa.Fliplr(1.0);
    bbs_aug = [];
    for line in range(len(lines)):
        bbs_aug.append([texts[0][line][0]+' ' ,str(1.0-float(texts[0][line][1]))+' ',texts[0][line][2]+' ',texts[0][line][3]+' ',texts[0][line][4]+'\n']);
    image_aug = aug(image = image);    
    cv2.imwrite(os.path.join('C:/Users/Han/Desktop/auto_selling/Aug/', f'fliplr_'+str(img)+'.jpg'), image_aug);
    txt = open('C:/Users/Han/Desktop/auto_selling/Aug/'+'fliplr_'+str(img) +'.txt', 'w');
    for j in range(len(lines)):
        txt.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    txt.close();