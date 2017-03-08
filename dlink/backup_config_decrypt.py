#!/usr/bin/env python3
import struct
import blowfish
def setup():
    unk_f = open('blowfish_s_p.txt','rb')
    unk = unk_f.read()
    unk_f.close()
    s_list = []
    for i in range (0,4):
        s_list.append([])
        for j in range (0,256):
            s_list[i].append(None)
    for i in range (0,4):
        for j in range (0,256):
            s_list[i][j] = struct.unpack_from('I',unk,i*256*4+j*4)[0]
        s_list[i] = tuple(s_list[i])
    s_tuple = tuple(s_list)
    
    p_list = []
    for i in range (0,9):
        t_list = []
        t_list.append(struct.unpack_from('I',unk,4096+4*i*2+0)[0])
        t_list.append(struct.unpack_from('I',unk,4096+4*i*2+4)[0])
        p_list.append(tuple(t_list[::-1]))
        
    p_tuple = tuple(p_list)
    return (s_tuple,p_tuple)

def read_config():
    conf_f = open('Config.CFG','rb')
    conf = conf_f.read()
    conf_f.close()
    return conf

result = setup()
cipher = blowfish.Cipher("Steven WuDCS-933L")
cipher.S = result[0]
cipher.P = result[1]

conf = read_config()

