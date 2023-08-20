# This Python file uses the following encoding: utf-8
import psutil
import numpy as np

class Memory:
    def __init__(self):
        pass
    #dict_keys(['total', 'available', 'percent', 'used', 'free', 'active', 'inactive', 'buffers', 'cached', 'shared', 'slab'])

    # This is to convert psutil data to human readable
    def adjust_percision_Megabytes(self, num):
        tot = (num >> 20)
        return tot

    def adjust_percision_Gygabytes(self, num):
        tot = (num >> 30)
        return tot

    def adjust_decimal_percision(self,num):
        rounded = float(round(num, 2))
        return rounded

    # This is to normalize the data from 0 - 1 to fir the progress bar variable
    def normalize_data(self,data):
        # Making data human readable
        data = list(map(self.adjust_percision_Gygabytes,data))
        x = np.array(data)
        # normalizing the data
        norm = (x-np.min(x))/(np.max(x)-np.min(x))
        norm = list(map(self.adjust_decimal_percision,norm))

        return norm

    def get_memory_used(self):
        memory = psutil.virtual_memory()
        mem = [0,1,2,3,4,5,6]
        # The 0 bellow is a holder to not throw off the the normalization
        mem[0],mem[1],mem[2],mem[3]  = memory[0],memory[1],0,memory[3]
        mem = self.normalize_data(mem)
        # Added the percentage later so it wouldnt get normalized
        # This numbers cant get normalized, not sure but it may through calc off.
        mem[0],mem[2] = self.adjust_decimal_percision(self.adjust_percision_Megabytes(memory[0])/1000), memory[2]
        # mem[4] is the memory being used
        mem[4] = 1 - mem[1]
        # This is a numpy array and nneds to be converted to python list

        return list(mem)


# Need to pass to GUI later
    def get_swap_memory_used(self):
        swap = psutil.swap_memory()
        mem = [0,0,0,0,0,0,0]

        mem[0],mem[1],mem[2],mem[3]  = swap[0],swap[1],swap[2],0
        mem = self.normalize_data(mem)
        mem[0],mem[3] = self.adjust_decimal_percision(self.adjust_percision_Megabytes(swap[0])/1000), swap[3]
        mem[5] = 1 - mem[1]
        return list(mem)




