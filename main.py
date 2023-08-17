# This Python file uses the following encoding: utf-8
import sys
import os
import datetime



from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Signal, QTimer

import psutil

import '/Source/Process/Processes'

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.timer = QTimer()
        self.timerForProc = QTimer()

        self.timer.timeout.connect(lambda: self.setMainCall())
        self.timerForProc.timeout.connect(lambda: self.setProcessList())

        self.timer.start(100)
        self.timerForProc.start(1000)

    # CPU signals
    printCPU = Signal(str)
    printCPUCount = Signal(str)
    # Temperature Signals
    printCPUTemperature = Signal(str)
    printNVMETemperature = Signal(str)
    # Processes
    printProcess = Signal('QVariant')

    def setMainCall(self):
        self.setCPU()
        self.setCPUTemperature()
        self.setNVMETemperature()
#        self.setProcessList()

        ################################ CPU Usage Information ################################
    def setCPU(self): # the number in the () bellow is for the interval that i used to measure the CPU
        cpu = str(psutil.cpu_percent(1))
        self.printCPU.emit(cpu)

    def setCPUCount(self):
        cpuCount = str(psutil.cpu_count())
        self.printCPUCount.emit(cpuCount)

       ################################ Temperature ################################
    def setCPUTemperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit=True))
        cpuTemp = str(temp.get("pch_cometlake")[0][1])
#        print(temp.get("pch_cometlake")[0][1])
        self.printCPUTemperature.emit(cpuTemp)

    def setNVMETemperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit=True))
        nvmeTemp = str(temp.get("nvme")[0][1])
        self.printNVMETemperature.emit(nvmeTemp)

       ################################ Ram Usage  Informatin ################################3
    def setRAMTotal(self):
        ramTotal = str(psutil.virtual_memory()[0])
        self.printRamTotal.emit(ramTotal)

    def setRAMAvailable(self):
        ramAvailable = str(psutil.virtual_memory()[1])
        self.printRamAvailable.emit(ramAvailable)

    def setRAMUsagePercent(self):
        # The usage is the number 2 index in the tuple
        ramUsagePercent = str(psutil.virtual_memory()[2])
        self.printRamUsagePercent.emit(ramUsagePercent)

    def setRAMUsage(self):
        ramUsage = str(psutil.virtual_memory()[3])
        self.printRamUsage.emit(ramUsage)

    def setRAMFree(self):
        ramFree = str(psutil.virtual_memory()[4])
        self.printRamFree.emit(ramFree)

        ################################ Get Processes Information ################################
    def setProcessList(self):
        listOfJobs = []

        for p in psutil.process_iter(['pid','name', 'username', 'cmdline', 'cpu_times']):

            listOfJobs.append(p.info)

        listOfJobs.append(p.info)

        self.printProcess.emit(listOfJobs)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())





