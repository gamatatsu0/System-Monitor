# This Python file uses the following encoding: utf-8
import psutil

class Processes:
    def __init__(self):
        self.listOfProcess = []

    # Returns a list of process in what ever order process_itter gives us
    def get_process_current(self):
        for proc in psutil.process_iter():
            try:
                processDict = proc.as_dict(attrs=['pid', 'memory_percent', 'name', 'cpu_times', 'create_time', 'memory_info'])
                self.listOfProcess.append(processDict)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        return self.listOfProcess

    # Returns processes from most to least memory used
    def get_process_most(self):
        # for process in process iter
        for proc in psutil.process_iter():
            try:
                processDict = proc.as_dict(attrs=['pid', 'memory_percent', 'name', 'cpu_times', 'create_time', 'memory_info'])
               # Gets the Virtual memory usage. The vms key is used to sort the Processes
                processDict['vms'] = proc.memory_info().vms / (1024 *1024) #

                self.listOfProcess.append(processDict)

            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass


        # List of processes being sorted from largest memory usage to lowest
        self.listOfProcess = sorted(self.listOfProcess, key=lambda procObj: procObj['vms'],reverse=True)
        return self.listOfProcess


