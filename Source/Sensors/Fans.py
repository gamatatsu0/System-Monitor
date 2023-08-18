# This Python file uses the following encoding: utf-8
import psutil
import re


class Fans:
    def __init__(self):
        pass

    def use_regex(self, input_text):
        pattern = re.compile(r"\[.*\]", re.IGNORECASE)
        return pattern.match(input_text)

# Gets the speed of the fans
    def get_fan_speed(self):
        # returns a dict so but
        #we cant call by name because we may encounter different models
        fanInfo = psutil.sensors_fans().popitem()
        fanName = str(fanInfo[1][1][1])

        return fanName
