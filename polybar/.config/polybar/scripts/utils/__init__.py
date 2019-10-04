import utils.colors
import utils.humanreadable
import utils.creds
import subprocess


def output_of(cmd):
    try:
        return subprocess.run(cmd, stdout=subprocess.PIPE)\
            .stdout.decode('utf-8').strip()
    except:
        return None

def icon(unicode_char, font):
    return '%{ T' + font + ' }' + unicode_char + '%{ T- }'

def action(_action, text):
    return '%{ A:' + _action + ': }' + text + '%{ A- }'


def fg(color, text):
    return '%{ F' + color + ' }' + text + '%{ F- }'


def bg(color, text):
    return '%{ B' + color + ' }' + text + '%{ B- }'


def file_contents(f):
    try:
        ff = open(f, 'r')
        c = ff.read().strip()
        ff.close()
        return c
    except:
        return None
