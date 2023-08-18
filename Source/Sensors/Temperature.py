# This Python file uses the following encoding: utf-8
import psutil


class Temperature:
    def __init__(self):
        pass

    def get_cpu_temperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit=True))
        cpuTemp = str(temp.get("pch_cometlake")[0][1])
        return cpuTemp

    def get_nvme_temperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit=True))
        nvmeTemp = str(temp.get("nvme")[0][1])
        return nvmeTemp
