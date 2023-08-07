import os
import sys
import numpy as np
from copy import copy, deepcopy
import cv2

from random import seed
from random import randint
# seed random number generator
seed(1)

#define N
arr=[] 

new_tb = 0

if(new_tb): #generate new tb image
    N=10 #to be changed each time
    random_generator = 0
    tb = open("Tests/image_test.txt", "w")
    for i in range(0,N*N):
        if(random_generator): num = str(randint(0, 255)).zfill(3)
        else: num = str(int(i+1)).zfill(3)
        tb.write(num)
        tb.write("\n")
    tb.close()
    arr = map(str.split, open('Tests/image_test.txt'))
    f = open("Tests/image_python_out.txt", "w")
else: #keep official test from helios
    N=32
    arr = map(str.split, open('Tests/image_test_official.txt'))
    f = open("Tests/image_python_out_official.txt", "w")

    
arr = [list( map(int,i) ) for i in arr] 
arr = np.array(arr)
aa = arr.reshape(N, N)
a = aa.tolist()
print(arr,np.shape(arr),type(arr))
print()
print(aa,np.shape(aa),type(aa))
print()
print(a,np.shape(a),type(a))

b = deepcopy(a)

for i in range(0, N):
    for j in range(0,N):
        right = j+1 if j<N-1 else 0
        left = j-1 if j>0  else 0
        up = i-1 if i>0  else 0
        down = i+1 if i<N-1 else 0
        r = a[i][right] if j<N-1 else 0
        l = a[i][left] if j>0   else 0
        u = a[up][j] if i>0   else 0
        d = a[down][j] if i<N-1 else 0
        d1 = a[up][left] if (i>0 and j>0)   else 0 
        d2 = a[up][right] if (i>0 and j<N-1) else 0 
        d3 = a[down][left] if (i<N-1 and j>0) else 0 
        d4 = a[down][right] if (i<N-1 and j<N-1)  else 0 
        # R - G - B
        arr_g1=np.array([((r+l)/2), (a[i][j]) , ((u+d)/2)])
        arr_r=np.array([(a[i][j]), ((u+d+r+l)/4) , ((d1+d2+d3+d4)/4)])
        arr_b=np.array([((d1+d2+d3+d4)/4) , ((u+d+r+l)/4) , (a[i][j])])
        arr_g2=np.array([((u+d)/2), (a[i][j]) , ((r+l)/2)])
        print(arr_g1, np.shape(arr_g1),type(arr_g1))
        if(i%2):
            if(j%2):
                b[i][j] = np.ceil(arr_g1)  #green center
            else:
                b[i][j] = np.ceil(arr_r)  #red center
        else:
            if(j%2):
                b[i][j] = np.ceil(arr_b)  #blue center
            else:
                b[i][j] = np.ceil(arr_g2)  #green center 2
        b[i][j] = b[i][j].astype(int)

c = deepcopy(b)
print(c,np.shape(c),type(c))

for i in range(0, N):
    for j in range(0,N):
        for k in range(0,3):
            b[i][j][k] = str(b[i][j][k]).zfill(3)

for i in range(0, N):
    for j in range(0,N):
        for k in range(0,3):
            f.write(str(c[i][j][k]).ljust(3))
            f.write(" ")
        f.write("\n")
f.close()
