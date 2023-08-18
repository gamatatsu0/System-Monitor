# This Python file uses the following encoding: utf-8
import psutil

class Fans:
    def __init__(self):
        pass

    def get_fan_speed(self):
        psutil.sensors_fans()
