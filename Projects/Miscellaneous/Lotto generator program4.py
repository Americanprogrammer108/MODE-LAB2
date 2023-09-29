import sys
import random
from random import randint
           
mixednumbers1 = []
mixednumbers2 = []
mixednumbers3 = []
mixednumbers4 = []
mixednumbers5 = []

selectednumbers = []
oddoreven = int

x = int
x = 1

#This program will generate numbers based on how the numbers are randomly added to the mixednumber list
while x <= 50:
    numberlist = random.randint(1, 5)
    if numberlist == 1:
        mixednumbers1.append(x)
    elif numberlist == 2:
        mixednumbers2.append(x)
    elif numberlist == 3:
        mixednumbers3.append(x)
    elif numberlist == 4:
        mixednumbers4.append(x)
    elif numberlist == 5:
        mixednumbers5.append(x)
    x = x + 1


frequency = input("Enter the numbers you want to play: ")
try:
    frequency = int(frequency)
    rows = input("Enter the number of rows: ")
    try:
        rows = int(rows)
        rowcount = int

        rowcount = 1
        y = int
        while rowcount <= rows:
            y = 1
            while y <= frequency:
                oddoreven = 1
                if oddoreven == 1:
                    chance = random.randint(0, len(mixednumbers1) - 1)
                    selectednumbers.append(mixednumbers1[chance])
                    mixednumbers1.remove(mixednumbers1[chance])
                elif oddoreven == 2:
                    chance = random.randint(0, len(mixednumbers2) - 1)
                    selectednumbers.append(mixednumbers2[chance])
                    mixednumbers2.remove(mixednumbers2[chance])
                elif oddoreven == 3:
                    chance = random.randint(0, len(mixednumbers3) - 1)
                    selectednumbers.append(mixednumbers3[chance])
                    mixednumbers3.remove(mixednumbers3[chance])        
                elif oddoreven == 4:
                    chance = random.randint(0, len(mixednumbers4) - 1)
                    selectednumbers.append(mixednumbers4[chance])
                    mixednumbers4.remove(mixednumbers4[chance])
                elif oddoreven == 5:
                    chance = random.randint(0, len(mixednumbers5) - 1)
                    selectednumbers.append(mixednumbers5[chance])
                    mixednumbers5.remove(mixednumbers5[chance])
                y = y+1
            selectednumbers.sort()
            print("Row", rowcount, ": ", selectednumbers)
            selectednumbers.clear()
            # clear everything after printing out the numbers

            mixednumbers1.clear()
            mixednumbers2.clear()
            mixednumbers3.clear()
            mixednumbers4.clear()
            mixednumbers5.clear()
            rowcount = rowcount + 1
        # same goes for the numbers

            z = int
            z = 1
            n = int

            while z <=50:
                n = random.randint(1, 5)
                #reset the list
                if n == 1:
                    mixednumbers1.append(z)
                elif n == 2:
                    mixednumbers2.append(z)
                elif n == 3:
                    mixednumbers3.append(z)
                elif n == 4:
                    mixednumbers4.append(z)
                elif n == 5:
                    mixednumbers5.append(z)
                z = z + 1


    

        print("")
        print("Good luck tonight!")
    except:
        print("Not a valid input")
        sys.exit()
except:
    print("Not a valid input")
    sys.exit()