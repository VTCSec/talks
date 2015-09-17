# replace.py
# For btproxy demo.  See https://github.com/conorpp/btproxy
# This replaces the options in a Pebble notification packet

def master_cb(req):
    req = req.replace(b'Open on phone', b'Hi welcome to')
    req = req.replace(b'Dismiss', b'Btproxy')

    print '<< ', repr(req)
    return req

def slave_cb(res):
    print '>> ', repr(res)
    return res


