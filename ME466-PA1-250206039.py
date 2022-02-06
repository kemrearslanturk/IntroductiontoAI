# -*- coding: utf-8 -*-
"""
Created on Sat Oct 14 16:14:45 2021

@author: Korkut Emre Arslanturk/250206039
"""
#importing libraries

f = open("readme250206039.txt", "r")
print(f.read())

import random
import numpy as np

#Define Functions
# function check number has repeated digits or not.
def isrepeated(num):
    digits = make_listofdigits(num)
    check=len(digits)!=len(set(digits))
    return check
#function calculate bulls and cows numbers using prediction and secret number.
def Bulls_Cows_Number(Num1,Num2):
    digit_1 = make_listofdigits(Num1);  digit_2 = make_listofdigits(Num2)
    
    results = np.array(digit_1) == np.array(digit_2)
    
    bull = sum(results)
    cow = 0

    for item in digit_1:
        if (item in digit_2) == 1:
            cow = cow+1

    cow = cow-bull
    
    return(bull, cow)
  

# function convers integer number to digit list
def make_listofdigits(Num):
    digits = []
    
    for digit in str(Num):
        digits.append(int(digit))
    
    return(digits)
#guessing number algorithm
def Guess(Num, set_of_val, bulls, cows):
    
    if (bulls == 0 and cows == 0):
        if Num in set_of_val:
            set_of_val.remove(Num)
        
        return(random.choice(set_of_val))

            
        
    else:
        
        for item in set_of_val:
            digits_set = make_listofdigits(item); digits = make_listofdigits(Num)
            if sum(np.array(digits_set)==np.array(digits)) < bulls:
                set_of_val.remove(item)

        for item in set_of_val:
            digits_set = make_listofdigits(item); digits = make_listofdigits(Num)
         
            
            val = 0
            for digit in digits:
                if (digit in digits_set):
                    val = val + 1
            
            if val<cows:
                set_of_val.remove(item)

        return(random.choice(set_of_val))


#Main Code

#creating set of possible correct values
set_of_val = []

for k in range(1023, 9876):
    if isrepeated(k) == False:
        set_of_val.append(k)


secret = input("Enter Secret Number: ")
# checking for that secret value is acceptable or not
if int(secret)>10000 or int(secret)<1000:
    print("Secret number must be a four digits.")
    print("Game Over!")

elif isrepeated(secret) == True:
    print("Repeated digits are not allowed.")
    print("Game Over!")
    exit
    
else:
#making prediction
    flag_num = 0 ;try_count = 1

    while (True):
            if flag_num == 0:
                flag_num = flag_num + 1
                Guessed_nmbr = (random.choice(set_of_val))
                print("A: My guess is ", Guessed_nmbr)

            bul, cow = input("B: Number of bulls and cows respectively: ").split()
            bul=int(bul); cow=int(cow)
            if (bul, cow) != Bulls_Cows_Number(Guessed_nmbr,secret):
                print("Wrong inputs entered.")
                break
            
            if bul == 4:
                print("I WON")
                print("Your secret number is", Guessed_nmbr)
                break
            else:
                if Guessed_nmbr in set_of_val:
                    set_of_val.remove(Guessed_nmbr)
                    Guessed_nmbr = Guess(Guessed_nmbr, set_of_val, bul, cow)
                    print("A: My guess is", Guessed_nmbr)
                    try_count=try_count+1

    print("Number of tries:",try_count)
