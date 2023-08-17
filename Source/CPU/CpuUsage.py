# This Python file uses the following encoding: utf-8
import psutil

class CpuUsage:
    def __init__(self):
        pass
    def get_number_of_cores(self):
        # Number of Cores including the the threading, 2 threads per core
        # Unless youre on intel
        return psutil.cpu_count(logical=True)
# The percentage of cpu being used per every core, physical or logical
# In our case we are going to use the logical
    def get_cpu_percent_used_per_core(self):
        return  psutil.cpu_percent(interval=1, percpu=True)

# The oercentage of the entire CPU being used
    def get_cpu_percent_used(self):
        return psutil.cpu_percent()

# The Grequency of the CPU as a whole
    def get_cpu_freq(self):
        return psutil.cpu_freq()
