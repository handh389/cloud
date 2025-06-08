import numpy as np;
import os;
import glob;
#---------------------------------------------------------------------------------------------------------
# 파일 로딩
path = 'C:/Users/Han/Desktop/auto_selling/dataset1_ex/';
os.chdir(path);

relative_classes = [];
# 60개의 클래스가 존재하고 또한 각 클래스는 60개의 다른 클래스와 같은 사진에 들어갈 수 있다.
# 그렇기 때문에 크기가 60인 리스트를 만들었고,
# 리스트를 구성하는 원소들 역시 크기가 60인 리스트로 구성되어있다.
for product in range(60):
    relative_classes.append(np.zeros(60).tolist());
    

for file in glob.glob('*.txt'):                    # .txt로 끝나는 파일을 하나씩 불러온다.
    lines = open(file, 'r').readlines();           # 텍스트 파일을 오픈한다.
    text_data = [];
    for line in range(len(lines)):                 # 텍스트 파일을 한 줄 씩 읽어나간다.            
        lines[line] = lines[line].split(' ');      # 이 때, 띄어쓰기를 기준으로 텍스트 파일 내부 데이터를 구분한다.

    for line in range(len(lines)):                 # 텍스트 파일내의 상품에 대하여
        for product in range(len(lines)):          
            relative_classes[int(lines[line][0])][int(lines[product][0])] += 1; 
            # 같이 있었던 상품의 번호에 해당하는 relative_classes의 상품 리스트를 1씩 더한다.
            
# 결과적으로,
# realative_classes는 각 상품 별로 한 이미지 내에서 다른 상품과 겹친 횟수를 알려준다. 
# 그리고 relative_classes[같은수][같은수], 가령 relative_classes[0][0]은
# 0번 상품이 들어간 이미지가 몇개인지를 알려주기도 한다.       
