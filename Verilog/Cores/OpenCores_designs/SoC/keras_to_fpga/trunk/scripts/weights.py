#

import struct

print(struct.unpack('!f', bytes.fromhex('405cb2c3'))[0])
print(struct.unpack('!f', bytes.fromhex('c05cb2c0'))[0])
print(struct.unpack('!f', bytes.fromhex('b49294a7'))[0])
