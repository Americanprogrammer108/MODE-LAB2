import sys
import random
from random import randint
           
mixednumbers1 = []
mixednumbers2 = []
mixednumbers3 = []
mixednumbers4 = []
mixednumbers5 = []

mixednumbers6 = []
mixednumbers7 = []
mixednumbers8 = []

selectednumbers = []
oddoreven = int

powerball = int

x = int
y = int

x = 1
y = 1

#This program will generate numbers based on how the numbers are randomly added to the mixednumber list
#Fill in the random list for the white balls
while x <= 70:
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

#Now, fill in the list for the gold Mega Ball
while y <= 25:
    numberlist = random.randint(6, 8)
    if numberlist == 6:
        mixednumbers6.append(y)
    elif numberlist == 7:
        mixednumbers7.append(y)
    elif numberlist == 8:
        mixednumbers8.append(y)
    y = y + 1

print("MEGA MILLIONS LOTTERY GENERATOR")


try:
    rows = input("Enter the number of rows: ")
    try:
        rows = int(rows)
        rowcount = int

        rowcount = 1
        y = int
        while rowcount <= rows:
            y = 1
            while y <= 6:
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
            #now generate the number for the powerball
            powerballchance = random.randint(6, 8)

            if powerballchance == 6:
                pick = random.randint(0, len(mixednumbers6))
            elif powerballchance == 7:
                pick = random.randint(0, len(mixednumbers7))
            elif powerballchance == 8:
                pick = random.randint(0, len(mixednumbers8))

            selectednumbers.append(pick)
            
            print("Row", rowcount, ": ", selectednumbers)
            selectednumbers.clear()
            

            # clear everything after printing out the numbers

            mixednumbers1.clear()
            mixednumbers2.clear()
            mixednumbers3.clear()
            mixednumbers4.clear()
            mixednumbers5.clear()

            mixednumbers6.clear()
            mixednumbers7.clear()
            mixednumbers8.clear()
            rowcount = rowcount + 1
        # same goes for the numbers

            z = int
            z = 1
            n = int

            while z <=70:
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

            z = 1
            while z <=25:
                n = random.randint(6, 8)
                #reset the list
                if n == 6:
                    mixednumbers6.append(z)
                elif n == 7:
                    mixednumbers7.append(z)
                elif n == 8:
                    mixednumbers8.append(z)
                z = z + 1


    

        print("")
        print("Good luck tonight!")
    except:
        print("Not a valid input")
        sys.exit()
except:
    print("Not a valid input")
    sys.exit()