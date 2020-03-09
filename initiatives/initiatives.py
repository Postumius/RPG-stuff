import random
import ps


def dice(n,sides):
    if sides == 0:
        print("what is a d0 even what does that mean")
        return 0
    total = 0
    for x in range(1,n+1):
        roll = random.randint(1,sides)              
        total += roll
    return total


vals = ps.pairSet("init.txt")

valSet = vals.gib()

while(True):
    input()
    rolls = []
    for pair in valSet:
        rolls.append((pair[0], int(pair[1]), dice(1,20)))

    rolls = sorted(rolls, key=lambda trip: trip[1]+trip[2],
                   reverse=True)
    for trip in rolls:
        print(trip[0] + ' ' + str(trip[1]+trip[2]))
