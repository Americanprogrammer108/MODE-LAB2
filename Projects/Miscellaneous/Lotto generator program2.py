import sys
import random
from random import randint

oddnumbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49]
evennumbers = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50]

selectednumbers = []
oddoreven = int

#This program will generate numbers from the odd and even numbers list
frequency = input("Enter the numbers you want to play: ")
try:
    frequency = int(frequency)

    rows = input("Enter the number of rows: ")
    try:
        rows = int(rows)
        rowcount = int

        rowcount = 1
        x = int
        while rowcount <= rows:
            
            x = 1
            while x <= frequency:
                oddoreven = random.randint(0, 10)
                if oddoreven == 1 or oddoreven == 3 or oddoreven == 5 or oddoreven == 7 or oddoreven == 9:
                    #generate a random odd number
                    chance = random.randint(0, len(oddnumbers) - 1)
                    selectednumbers.append(oddnumbers[chance])
                    oddnumbers.remove(oddnumbers[chance])
                else:
                    #generate a random even number
                    chance = random.randint(0, len(evennumbers) - 1)
                    selectednumbers.append(evennumbers[chance])
                    evennumbers.remove(evennumbers[chance])

                x = x+1
            selectednumbers.sort()
            print("Row", rowcount, ": ", selectednumbers)


            selectednumbers.clear()
            #clear everything after printing out the numbers

            oddnumbers.clear()
            evennumbers.clear()
            #same goes for the numbers

            z = int
            z = 1
            while z <= 49:
                #reset the list
                oddnumbers.append(z)
                z = z + 2

            y = int
            y = 2
            while y <= 50:
                evennumbers.append(y)
                y = y + 2


            rowcount = rowcount + 1

        print("")
        print("Good luck tonight!")
    except:
        print("Not a valid input")
        sys.exit()
except:
    print("Not a valid input")
    sys.exit()




