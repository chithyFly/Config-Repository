#!/usr/bin/env python

# Requirement:
# fuzzywuzzy, levenshtein
import argparse
from fuzzywuzzy import fuzz
from importlib.metadata import version
import os
import random
import time as timer
import xml.etree.ElementTree as ET

from datetime import datetime, date, time, timedelta

def set_wallpaper(path):
    path = path.replace(" ", "\\ ")
    print("Setting wallpaper: " + path)
    os.system("feh " + args.feh_arguments + " " + path + " 2>/dev/null")

def get_wallpapers():
    print("Getting wallpapers")
    wallpapers = os.popen("find " + args.base_directory + " -type f -name '*.xml' 2>/dev/null").read().split("\n")
    return wallpapers

def pick_wallpaper(wallpapers, name):
    if (name ==  None):
        print("Picking random wallpaper")
        return random.choice(wallpapers)

    weight = 0;
    chosen = None;

    for wallpaper in wallpapers:
        ratio = fuzz.ratio(name, wallpaper)
        if (ratio > weight):
            weight = ratio
            chosen = wallpaper

    print("Picking wallpaper with name like " + name)
    return chosen

def get_wallpaper_data(wallpaper_xml):
    background = ET.parse(wallpaper_xml).getroot()
    time_start = background.find("starttime")

    d = date.today()
    t = time(int(time_start.find("hour").text), int(time_start.find("minute").text), int(time_start.find("second").text))
    start_time = datetime.combine(d, t)

    map = {}

    for child in background:
        if child.tag == "static":
            duration = child.find("duration").text
            from_path = child.find("file").text
            to_path = None
        elif child.tag == "transition":
            duration = child.find("duration").text
            from_path = child.find("from").text
            to_path = child.find("to").text
        else:
            continue

        if (to_path != None):
            start_time += timedelta(seconds=float(duration)/2)
            map[str(start_time)] = {"file": from_path, "start_time": start_time}

            start_time += timedelta(seconds=float(duration)/2)
            map[str(start_time)] = {"file": to_path, "start_time": start_time}

            continue

        start_time += timedelta(seconds=float(duration))
        map[str(start_time)] = {"file": from_path, "start_time": start_time}

    return map

def dump_wallpaper_data(wallpaper_dict):
    for key, struct in wallpaper_dict.items():
        print("KEY -> " + key)
        for prop, value in struct.items():
            print("\t" + prop + " -> " + str(value))
        print("")

def handle_wallpaper(wallpaper_dict):
    print("Handling wallpaper")

    selected = None

    now = datetime.now()

    current = None
    next = None

    for key, struct in wallpaper_dict.items():
        key = datetime.fromisoformat(key)

        if (now >= key):
            current = wallpaper_dict[str(key)]
            continue

        if (now <= key):
            next = wallpaper_dict[str(key)]
            break

    eta = (next['start_time']-now).total_seconds()

    print("ETA: " + str(eta))
    print("Now: " + str(now))
    print("Next wallpaper: " + str(next['start_time']))

    if (current == None):
        print("There are no wallpapers to current time.")
        return

    set_wallpaper(current['file'])

    timer.sleep(eta)

def list_available_wallpapars(list):
    if (list == False):
        return

    wallpapers = get_wallpapers()

    for  wallpaper in wallpapers:
        wallpaper = wallpaper.split('/')
        wallpaper = wallpaper[len(wallpaper)-1]
        wallpaper = wallpaper.split('.')
        print(wallpaper[0])

    exit(0)


def ensure_required_binaries_are_installed():
    has_find = os.popen("command -v find 2>/dev/null").read()
    has_feh = os.popen("command -v feh 2>/dev/null").read()

    if (has_find == ''):
        print("Please install find before run this program.")

    if (has_feh == ''):
        print("Please install feh before run this program.")

def ensure_required_python_deps():
    try:
        version('python-levenshtein')
    except:
        print('Missing python-levenshtein dep')
        exit(1)

def main():
    wallpapers = get_wallpapers()

    if len(wallpapers) == 1 and wallpapers[0] == "":
        print("No dynamic wallpapers found")
        exit(0)

    while True:
        wallpaper_xml = pick_wallpaper(wallpapers, args.name)
        wallpaper_data = get_wallpaper_data(wallpaper_xml)
        handle_wallpaper(wallpaper_data)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Handle xml dynamic wallpapers")

    parser.add_argument(
        "--feh-arguments",
        type=str,
        default="--randomize --bg-fill",
        help="Specific arguments to feh"
    )

    parser.add_argument(
        "--base-directory",
        type=str,
        default="/usr/share/backgrounds",
        help="Path with xml files"
    )

    parser.add_argument(
        "--name",
        type=str,
        default=None,
        help="Name of wallpaper to be searched in list"
    )

    parser.add_argument(
        "--list",
        default=False,
        action='store_true',
        help="Show all available xml"
    )

    args = parser.parse_args()

    list_available_wallpapars(args.list)

    ensure_required_binaries_are_installed()
    #ensure_required_python_deps()

    main()
