# This Python file uses the following encoding: utf-8
import psutil

class Processes:
    def __init__(self):
        self.listOfProcess = []

    def get_current_process(self):
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
