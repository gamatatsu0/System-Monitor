# This Python file uses the following encoding: utf-8
import psutil


class Temperature:
    def __init__(self):
        pass

    # This return the Temperature of the CPU
    def get_cpu_temperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit= True))
        cpuTemp = str(temp.get("pch_cometlake")[0][1])
        return cpuTemp
    # Getting the wifi temp
    def get_wifi_temperature(self):
        temp = psutil.sensors_temperatures(fahrenheit= True)
        wifiTemp = str(temp.get('iwlwifi_1')[0][1])
        return wifiTemp
    # This return the Temperature of the NVME slot
    def get_nvme_temperature(self):
        temp = (psutil.sensors_temperatures(fahrenheit=True))
        nvmeTemp = str(temp.get("nvme")[0][1])
        return nvmeTemp

    # Add something for the additinal nvme slot
