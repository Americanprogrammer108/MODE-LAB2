import sys
import random
from random import randint
import time

selectednumbers = []
oddoreven = int

x = int
x = 1


#This program will generate numbers from the starting number adding the random number


frequency = input("Enter the numbers you want to play: ")
try:
    frequency = int(frequency)
    rows = input("Enter the number of rows: ")
    try:
        rows = int(rows)
        myrows = 1
        
        numcount = 0
        #generate a number for the addition
        while myrows <= rows:
            while numcount < frequency:
                startingnumber = random.randint(1, 20)
                addingnumber = random.randint(1, 20)
                if (startingnumber + addingnumber > 50):
                    addingnumber = random.randint(1, 20)
                else:
                    selectednumbers.append(startingnumber + addingnumber)
                    numcount += 1
                    addingnumber = random.randint(1, 20)
            selectednumbers.sort()    
            print("Row ", myrows, ": ", selectednumbers)
            selectednumbers.clear()
            myrows = myrows + 1
            time.sleep(1)
            numcount = 0
            

        print("")
        print("Good luck tonight!")
    except:
        print("Not a valid input")
        sys.exit()
except:
    print("Not a valid input")
    sys.exit()