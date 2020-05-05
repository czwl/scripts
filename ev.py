 #!/usr/bin/python
import struct
import time
import sys
from subprocess import call 

infile_path = "/dev/input/event" + sys.argv[1] 
#long int, long int, unsigned short, unsigned short, unsigned int
FORMAT = 'llHHI'
EVENT_SIZE = struct.calcsize(FORMAT)

#open file in binary mode
in_file = open(infile_path, "rb")

event = in_file.read(EVENT_SIZE)
pressed=0;
keycombo="";
keymap= {'47':'v'};

while event:
    (tv_sec, tv_usec, type, code, value) = struct.unpack(FORMAT, event)

    if value == 1:        
        pressed = 1 ;          
    elif value == 0:
        pressed = 0 ;
        
    print (code , value);        

    event = in_file.read(EVENT_SIZE)

in_file.close()

