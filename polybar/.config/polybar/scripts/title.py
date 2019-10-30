#!/usr/bin/env python3

import json
import subprocess
import pprint
import sys
import textwrap
import Xlib.display
import Xlib

MAX_SIZE = 120

def call(query, is_json=True):
    query = subprocess.Popen(query, stdout=subprocess.PIPE)
    output = query.communicate()[0]
    if is_json:
        return json.loads(output)
    return output

def parse_nodes(root):
    result = []
    if root['firstChild'] != None:
        result.extend(parse_nodes(root['firstChild']))
    if root['secondChild'] != None:
        result.extend(parse_nodes(root['secondChild']))

    if root['client'] != None:
        result.append({
            root['id']: root['client']['instanceName']
        })

    return result

def write(o):
    o = o.rstrip()
    o += "\n"
    sys.stdout.write(o)
    sys.stdout.flush()


disp = Xlib.display.Display()
root = disp.screen().root

NET_WM_NAME = disp.intern_atom('_NET_WM_NAME')
NET_ACTIVE_WINDOW = disp.intern_atom('_NET_ACTIVE_WINDOW')

root.change_attributes(event_mask=Xlib.X.FocusChangeMask)

while True:
    # I dont understand xorg at all, but this apperently causes next_event
    # to fire on all title changes
    window_id = root.get_full_property(NET_ACTIVE_WINDOW, Xlib.X.AnyPropertyType).value[0]
    window = disp.create_resource_object('window', window_id)
    window.change_attributes(event_mask=Xlib.X.PropertyChangeMask)

    query = call(['bspc', 'query', '-T', '-d'])

    if query['layout'] != 'monocle':
        active_window = call(['xdotool', 'getactivewindow'], is_json=False)
        write(call(['xdotool', 'getwindowname', active_window], is_json=False).decode('utf-8'))
    else:
        result = ""

        nodes = parse_nodes(query['root'])
        max_length = MAX_SIZE // len(nodes)
        for node in nodes:
            for _id in node.keys():
                name = call(['xdotool', 'getwindowname', str(_id)], is_json=False)
                concat_name = textwrap.shorten(name.decode("utf-8"), width=max_length, placeholder='..')

                if _id == query['focusedNodeId']:
                    result += " %{B#cf6a4c}%{F#1C1C1C}" + f" {concat_name} " + "%{B#1C1C1C}%{F#C5C5C5} |"
                else: 
                    result += "%{A:bspc node -f " + str(_id) + ":}" + f" {concat_name} " + "%{A} |"

        write(result[:-1])

    # Wait for next event
    disp.next_event()


