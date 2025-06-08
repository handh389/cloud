#%% PFM_TermProject_2016-19161_한동환
import numpy as np;
import matplotlib.pyplot as plt;
import scipy.integrate as integrate;
#==============================================================================
#Case1 수치해석- watersaturation이 0.5인 경우
K = 4 * 10 **(-13);
mu = 0.09;
R = 0.1;
u5 = np.zeros((11, 10000));
du5 = np.zeros((11, 10000));
for r in range(0, 11): # r/100
    dudz = lambda z, u: [u[1],  u[0] * (16 * K * mu / R**3) / (1 + 4*K*mu/R * (1- (r / R /100)**2))]
    u0 = [1-(r/R/100)**4, -4/R*(K*mu/R)**0.5]; 
    sol = integrate.solve_ivp(dudz, [0, 40000], u0, method = 'RK45', t_eval = np.arange(0, 40000, 4));
    u5[r] = np.resize(sol.y[0], (10000));
    du5[r] = np.resize(sol.y[1], (10000));
#%%Case1 수치해석- watersaturation이 0.6인 경우
K = 2.5 * 10 **(-13);
mu = 0.09;
R = 0.1;
u6 = np.zeros((11, 10000));
du6 = np.zeros((11, 10000));
for r in range(0, 11): # r/100
    dudz = lambda z, u: [u[1],  u[0] * (16 * K * mu / R**3) / (1 + 4*K*mu/R * (1- (r / R /100)**2))]
    u0 = [1-(r/R/100)**4, -4/R*(K*mu/R)**0.5]; 
    sol = integrate.solve_ivp(dudz, [0, 40000], u0, method = 'RK45', t_eval = np.arange(0, 40000, 4));
    u6[r] = np.resize(sol.y[0], (10000));
    du6[r] = np.resize(sol.y[1], (10000));
#%%Case1 수치해석- watersaturation이 0.8인 경우
K = 8 * 10 **(-14);
mu = 0.09;
R = 0.1;
u8 = np.zeros((11, 10000));
du8 = np.zeros((11, 10000));
for r in range(0, 11): # r/100
    dudz = lambda z, u: [u[1],  u[0] * (16 * K * mu / R**3) / (1 + 4*K*mu/R * (1- (r / R /100)**2))]
    u0 = [1-(r/R/100)**4, -4/R*(K*mu/R)**0.5]; 
    sol = integrate.solve_ivp(dudz, [0, 40000], u0, method = 'RK45', t_eval = np.arange(0, 40000, 4));
    u8[r] = np.resize(sol.y[0], (10000));
    du8[r] = np.resize(sol.y[1], (10000));