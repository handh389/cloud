#-------------------------------------------------------------------------------------------------------------------------------------
# 학생들 정보 가져오기
import csv; import random; import numpy as np;

# 학생들에 대한 데이터 불러오기
student_data = [];
with open('student_survey.csv') as csvfile:                               
    data = csv.reader(csvfile);
    for row in data:
        student_data.append(row);  # csv파일을 한줄한줄 리스트로 옮겨온다.
student_data = student_data[2:];  # csv파일의 첫째줄은 headerline, 둘째줄은 교수님이므로 맨 위 두 줄 없애고 그 이후만 남긴다.

#------------------------------------------------------------------------------------------------------------------------------------
# 팀 분배를 위한 기본 변수 설정
# 전체 학생 수 : 34명
student_num = len(student_data);  

# 한 팀당 수 : 4명
member_num = 4; # 기본적으로 한 팀당 4명 씩이지만 딱 나눠떨어지지 않는 경우,남은 사람들을 1조부터 한명 씩 배치할 예정이다.

# 팀의 수 : 8개 -> 나누기의 몫
team_num = student_num // member_num;     

# 처음에 4명씩 팀을 나눴을 때 팀을 못 구한 학생 수 (2명)
remain_student = student_num - team_num * member_num;        

# 몇 번 섞을 것인지 횟수
shuffle_num = 10;                                                
# -------------------------------------------------------------------------------------------------------------------------------------

# 일단 맨 처음에는 csv 파일의 순서대로 팀을 배열한다.

# 4명씩 팀 배정
teams = [];
for team in range(team_num):
    teams.append(student_data[team*member_num : (team+1)*member_num]);    # csv파일에 있는 순서대로 4명씩 팀을 배열한다.

# 짝이 맞지 않아 남은 학생은 0조, 1조에 팀 배정
for remain in range(remain_student):                                     
    teams[remain].append(student_data[team_num*member_num + remain]);
    
#%%
# -------------------------------------------------------------------------------------------------------------------------------------
# 팀별로 평균 성적, 분산 구하는 함수 정의
# ******************************************************************************
def calc(teams):                                                                        
    team_avg = np.zeros((team_num, 5));                                                 
    total_team_avg = [];
    # ===========================================================================
    for team in range(team_num):   # 팀별기준 for문   
        team_programming_data = [];        # 프로그래밍 실력 데이터를 넣을 []
        team_research_data = [];           # 연구 경험 데이터를 넣을 []
        team_math_data = [];               # 수학 실력 데이터를 넣을 []
        team_writing_data = [];            # 글쓰기 실력 데이터를 넣을 []
        team_teamplay_data = [];           # 팀플 선호 데이터를 넣을 []
     
        # -----------------------------------------------------------------------
        for member in range(member_num):  # 각 팀의 멤버들에 대한 for문
            # csv파일 내에서 0~2번째 열은 이름, 학번, 아이디이므로 3번째 데이터부터 차례차례 가져온다.                                                                                 
            team_programming_data.append(float(teams[team][member][3]));          # 조원들의 코딩 점수 
            team_research_data.append(float(teams[team][member][4]));             # 조원들의 연구 경험 점수
            team_math_data.append(float(teams[team][member][5]));                 # 조원들의 수학 점수
            team_writing_data.append(float(teams[team][member][6]));              # 조원들의 글쓰기 점수
            team_teamplay_data.append(float(teams[team][member][7]));             # 조원들의 팀플 선호도 점수
        # ------------------------------------------------------------------------
        # 다시 팀별 기준 for문으로 나와서
        # 항목 별로 그 팀의 평균점수가 얼마인지 구한다.(각 팀에 대한 평균)    
        team_avg[team][0] = np.average(team_programming_data);               # 팀의 코딩 점수 평균     
        team_avg[team][1] = np.average(team_research_data);                  # 팀의 연구 경험 점수 평균
        team_avg[team][2] = np.average(team_math_data);                      # 팀의 수학 점수 평균
        team_avg[team][3] = np.average(team_writing_data);                   # 팀의 글쓰기 점수 평균
        team_avg[team][4] = np.average(team_teamplay_data);                  # 팀의 팀플 선호도 점수 평균
        
        # 팀원의 전체 평균 점수 (전체에 걸쳐 랜덤으로 조를 섞을 거면 이건 굳이 구하지 않아도 된다.)
        total_team_avg.append(np.sum((team_avg[team])+team_avg[team][0])/6); # 모든 항목 통틀어 팀 평균(코딩 가중치 2배)
                                                                        # [1조 평균, 2조 평균, 3조 평균, ..., 8조 평균]
                                                                        # 나중에 섞을 때 조별전체평균을 이용할 것이므로 구함
    # =============================================================================    
    # 이제는 전체 팀에 대해 한꺼번에 봐야하므로 팀별 기준 for문에서 나와서                                                                         
    # 조사항목 별로 분산을 구한다.(전체 조에 대한 분산)                                                                           
    var_programming = np.var(team_avg[:, 0]);      
    var_research = np.var(team_avg[:, 1]);
    var_math = np.var(team_avg[:, 2]);
    var_writing = np.var(team_avg[:, 3]);
    var_teamplay = np.var(team_avg[:, 4]);
    var = [var_programming, var_research, var_math, var_writing, var_teamplay];  
    
    # 분산값 모두 합한 것이 score(코딩 가중치는 2배므로 한번 더 더해준다)
    score = np.sum(var) + var_programming;
    
    # 출력 : total_team_avg = calc(teams)[0], score = calc(teams)[1], var = calc(teams)[2]
    return total_team_avg, score, var, team_avg;                

# *********************************************************************************

#%%
#--------------------------------------------------------------------------------------------------------------------------------------
# 팀 분배 시작
# 평균 기준으로 (1등팀, 8등팀 / 2등팀, 7등팀 / 3등팀, 6등팀 / 4등팀, 5등팀) 4개의 풀로 나누어 섞기를 반복

score = np.zeros(shuffle_num);   # shuffle 할 수만큼 score를 적어 넣을 리스트를 만든다.  
score[0] = calc(teams)[1];       # 첫번째 스코어는 그냥 csv 파일에 적혀있는대로 팀을 짜서 구한 score로 한다. 
valid_score = [];                # valid_score라는 개념을 도입하여 이전 최고기록 보다 좋은 기록이 나온 경우에만 기록
valid_score.append(score[0]);    # 일단은 맨 처음 csv 파일 기준으로 구한 스코어를 첫번째 valid_score로 정함

# ***********************************************************************************************************
for i in range(shuffle_num-1):    # i는 shuffle 회차, 첫번째 회차는 csv파일에 적힌대로 했으므로 하나 뺐다.
    
    total_team_avg = calc(teams)[0];    # 팀들의 평균값 :[1조 평균, 2조 평균,..., 8조 평균]
    sort_total_team_avg = np.argsort(total_team_avg).tolist();  # 각 팀의 평균값이 전체 팀중 몇번째로 큰지 알려준다.
    
    
    # =======================================================================================================
    for p in range(team_num // 2):    # 1.8위, 2,7위 이런식으로 나눠 섞을 것이므로 2로 나눈 몫이 pool의 갯수
                                       # p는 몇 번째 pool인지를 나타낸다.
        
        # ---------------------------------------------------------------------------
        # pool에 들어갈 두 팀을 한 pool에 넣는다.(1,8위, 2,7위, 3,6위, 4,5위)
        pool = [];
        for member in range(len(teams[sort_total_team_avg.index(p*2)])): 
            pool.append(teams[sort_total_team_avg.index(p*2)][member]);
        for member in range(len(teams[sort_total_team_avg.index((team_num)-p*2-1)])):
            pool.append(teams[sort_total_team_avg.index((team_num)-p*2-1)][member]);
        # ----------------------------------------------------------------------------
        
        # 2개 조를 합친 pool을 뒤섞는다. (가령, 1위팀과 8위팀이 합쳐진 pool을 뒤섞는다.)
        random.shuffle(pool);  
        
        # 섞은 뒤 다시 조 분배 -> 이로써 새로운 팀이 생성되었다.  
        teams[sort_total_team_avg.index(p*2)] = pool[: len(teams[sort_total_team_avg.index(p*2)] ) ];                  
        teams[sort_total_team_avg.index(team_num-p*2-1)] = pool[len(teams[sort_total_team_avg.index(p*2)]) :];
    # ========================================================================================================
    
    # 새로 구한 조편성의 스코어를 구한다.
    score[i+1] = calc(teams)[1];   
    
    # 만약 새로 구한 스코어가 이전의 최고기록 보다 좋으면,
    if score[i+1] < valid_score[len(valid_score)-1]:                 
        valid_score.append(score[i+1]);    # 그 스코어가 새로운 valid_score가 되는 것이다.
        
        # 결과 출력
        print(str(i+2) + '번째'); # 실제론 i+1번째지만, 파이썬은 0부터 시작하므로 1을 더 더해줌.                                   
        print('score : ' + str(score[i+1]));
        print('var :' + str(calc(teams)[2]));
        
        for team in range(team_num):
            print(str(team+1) + '조 ======================================================');
            print('평균: ' + str(calc(teams)[3][team]));
            for member in range(len(teams[team])):
                print(teams[team][member]);
        print('==========================================================');
        
# ************************************************************************************************************