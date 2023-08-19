# This Python file uses the following encoding: utf-8
import sys
import os
import datetime


import sys
from pathlib import Path

#from PySide6.QtGui import QGuiApplication
#from PySide6.QtQml import QQmlApplicationEngine

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Signal, QTimer

import psutil

import Source.Process.Processes as myProc
import Source.Sensors.Temperature as temp
import Source.Sensors.Fans as fans

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.timer = QTimer()
        self.timerForProc = QTimer()

        self.timer.timeout.connect(lambda: self.setMainCall())
        self.timerForProc.timeout.connect(lambda: self.setProcessList())

        self.timer.start(100)
        self.timerForProc.start(1000)

        self.generalTemp = temp.Temperature()
        self.sysFans = fans.Fans()


    # CPU signals
    printCPU = Signal(str)
    printCPUCount = Signal(str)
    # Temperature Signals
    printCPUTemperature = Signal(str)
    printNVMETemperature = Signal(str)
    printWIFITemperature = Signal(str)
    # Fan Speed Signals
    printFansSpeed = Signal(str)
    # Processes
    printProcess = Signal('QVariant')


    def setMainCall(self):
        self.setCPU()
        self.setCPUTemperature()
        self.setNVMETemperature()
        self.setWifiTemperature()
        self.setFansSpeed()
#        self.setProcessList()

        ################################ CPU Usage Information ######################
    def setCPU(self): # the number in the () bellow is for the interval that i used to measure the CPU
        cpu = str(psutil.cpu_percent(1))
        self.printCPU.emit(cpu)

    def setCPUCount(self):
        cpuCount = str(psutil.cpu_count())
        self.printCPUCount.emit(cpuCount)

       ################################ Temperature ################################
    def setCPUTemperature(self):
        self.printCPUTemperature.emit(self.generalTemp.get_cpu_temperature())
    def setNVMETemperature(self):
        self.printNVMETemperature.emit(self.generalTemp.get_nvme_temperature())
    def setWifiTemperature(self):
        self.printWIFITemperature.emit(self.generalTemp.get_wifi_temperature())

        ################################ Fans ######################################
    def setFansSpeed(self):
        self.printFansSpeed.emit(self.sysFans.get_fan_speed())

       ################################ Ram Usage  Informatin #######################
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

        ################################ Get Processes Information ###################
    def setProcessList(self):
        listOfJobs = myProc.Processes()
        self.printProcess.emit(listOfJobs.get_process_most())


if __name__ == "__main__":

#    app = QGuiApplication(sys.argv)
#    engine = QQmlApplicationEngine()
#    main = MainWindow()


#    engine.rootContext().setContextProperty("backend", main)

##    qml_file = Path(__file__).resolve().parent / "main.qml"
#    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))
##    engine.load(qml_file)

#    if not engine.rootObjects():
#        sys.exit(-1)
#    sys.exit(app.exec())

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())





