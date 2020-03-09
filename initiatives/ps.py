class pairSet:
        
    def __init__(self,fileName):
        self.fileName = fileName
        self.pairSet = set({})
        fl = open(self.fileName, 'r')
        ls = fl.read().splitlines()
        for line in ls:
            key_val = line.split()
            if len(key_val) is 1:
                key_val.append('0')
            self.add(key_val[0], key_val[1])

    def add(self,key,val):
        if self.has(key):
            self.pairSet.remove((key,self.at(key)))
        
        self.pairSet.add((key,val))
        
    def unzip(self):
        return list(zip(*self.pairSet))

    def at(self,key):
        return self.unzip()[1][self.unzip()[0].index(key)]

    def has(self, key):
        return (len(self.pairSet) >= 1) and (key in self.unzip()[0])
    
    def keys(self):
        ls = []
        for pair in self.pairSet:
            ls.append(pair[0])
        return ls

    def gib(self):
        return self.pairSet

    def save(self):
        fl = open(self.fileName, 'w')
        for pair in self.pairSet:
            fl.write('%s %s\r\n' %(pair[0], pair[1]))
        fl.close()
        
