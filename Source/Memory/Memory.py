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
    # This is to normalize the data from 0 - 1 to fir the progress bar variable
    def normalize_data(self,data):
        # Making data human readable
        data = list(map(self.adjust_percision_Megabytes,data))
        x = np.array(data)
        # normalizing the data
        norm = (x-np.min(x))/(np.max(x)-np.min(x))
        return norm

    def get_memory_used(self):
        memory = psutil.virtual_memory()
        mem = [0,1,2,3,4,5,6]
        # The 0 bellow is a holder to not throw off the the normalization
        mem[0],mem[1],mem[2],mem[3] = memory[0],memory[1],0,memory[3]
        mem = self.normalize_data(mem)
        # Added the percentage later so it wouldnt get normalized
        mem[2] = memory[2]
        return (mem)



    def get_swap_memory_used(self):
        swap = psutil.swap_memory()[0]
