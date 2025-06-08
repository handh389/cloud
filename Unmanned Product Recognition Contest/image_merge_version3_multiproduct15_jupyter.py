import numpy as np;
import cv2;
import os;
from PIL import Image;
import random;
import glob;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
classes = '0.aunt_jemima_original_syrup', '1.band_aid_clear_strips', '2.bumblebee_albacore', '3.cholula_chipotle_hot_sauce', \
    '4.crayola_24_crayons', '5.hersheys_cocoa', '6.honey_bunches_of_oats_honey_roasted', '7.honey_bunches_of_oats_with_almonds', \
    '8.hunts_sauce', '9.listerine_green', '10.mahatma_rice', '11.white_rain_body_wash', '12.pringles_bbq', '13.cheeze_it', \
    '14.hersheys_bar', '15.redbull', '16.mom_to_mom_sweet_potato_corn_apple', '17.a1_steak_sauce', '18.jif_creamy_peanut_butter', \
    '19.cinnamon_toast_crunch', '20.arm_hammer_baking_soda', '21.dr_pepper', '22.haribo_gold_bears_gummi_candy', \
    '23.bulls_eye_bbq_sauce_original', '24.reeses_pieces', '25.clif_crunch_peanut_butter', '26.mom_to_mom_butternut_squash_pear', \
    '27.pop_trarts_strawberry', '28.quaker_big_chewy_chocolate_chip', '29.spam', '30.coffee_mate_french_vanilla', \
    '31.pepperidge_farm_milk_chocolate_macadamia_cookies', '32.kitkat_king_size', '33.snickers', '34.toblerone_milk_chocolate', \
    '35.clif_z_bar_chocolate_chip', '36.nature_valley_crunchy_oats_n_honey', '37.ritz_crackers', '38.palmolive_orange', \
    '39.crystal_hot_sauce', '40.tapatio_hot_sauce', '41.nabisco_nilla', '42.pepperidge_farm_milano_cookies_double_chocolate', \
    '43.campbells_chicken_noodle_soup', '44.frappuccino_coffee', '45.chewy_dips_chocolate_chip', '46.chewy_dips_peanut_butter', \
    '47.nature_vally_fruit_and_nut', '48.cheerios', '49.lindt_excellence_cocoa_dark_chocolate', '50.hersheys_symphony', \
    '51.campbells_chunky_classic_chicken_noodle', '52.martinellis_apple_juice', '53.dove_pink', '54.dove_white', '55.david_sunflower_seeds', \
    '56.monster_energy', '57.act_ii_butter_lovers_popcorn', '58.coca_cola_bottle', '59.twix';

products = 33;                      # 상품 번호
file_title = 'snickers';           # 만들 사진의 파일 제목
n = 5;                                   # 만들 사진의 갯수

paths = [];
for path in range(len(products)):
    paths.append('/home/ai_competition22/3.backsub_images_100/' + classes[products[path]] + '/*.jpg');
background_path = '/home/ai_competition22/1.competition_trainset/1_dataset/*.jpg';
#--------------------------------------------------------------------------------------------------------
#%% 그림 합치기고 저장하기
titles = random.sample(glob.glob(random.choice(background_path)), n);
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
    
    background_title =  titles[img];
    background = cv2.imread(background_title);
    background_texts = [];
    background_lines = open(str(background_title[:-4]+ '.txt'), 'r');  
    h, w, c = res_image.shape; 
    bbs_aug = [];
    for prd in range(2):
        roi = background[prd*480 : prd*480+160, prd*360 : prd*360+120];
        mask = cv2.cvtColor(images[prd], cv2.COLOR_BGR2GRAY);
        mask[mask[:]==255]=0;
        mask[mask[:]>4]=255;
        mask_inv = cv2.bitwise_not(mask);
        image2 = cv2.bitwise_and(images[prd], images[prd] mask=mask);
        back = cv2.bitwise_and(roi, roi, mask=mask_inv);
        dst = cv2.add(image2, back);
        background[prd*480 : prd*480+160, prd*360 : prd*360+120] = dst;
        bbs_aug.append([texts[prd][0][0]+' ' ,str((prd*480+float(texts[prd][0][1])*160)/640)+' ',str((prd*360+float(texts[prd][0][2])*120)/480)+' ',str(float(texts[prd][0][3])*0.25)+' ',str(float(texts[prd][0][4])*0.25)+'\n'])
    cv2.imwrite(os.path.join('/home/ai_competition22/1.competition_trainset/merge/'+ file_title +str(img)+'.jpg'), background);
    tx = open('/home/ai_competition22/1.competition_trainset/merge/'+file_title +str(img) +'.txt', 'w');
    for j in range(15):
        tx.writelines([bbs_aug[j][0], bbs_aug[j][1], bbs_aug[j][2], bbs_aug[j][3], bbs_aug[j][4]]);
    tx.write(background_lines.read());            
    tx.close();
    
    
