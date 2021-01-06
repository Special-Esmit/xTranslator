from deep_translator import GoogleTranslator
import sys
import socket
from time import sleep

print ("<$> Created By Special_Esmit :)")
print ("<$> Translate Server =)\n")

f = open("/var/log/transserver.log" , "a")
err = False

s = socket.socket()

while err == False:
	try:
		ip = "localhost"
		port = 15001
		s.bind((ip, port))
		s.listen(True)
		err = True
	except:
		time.sleep(5)
		print("<!> Error In Running Server, Retry")
		continue

print ("<^> Server Is Listening")

while True:
	try:
		c, addr = s.accept()
		rs = c.recv(1024).decode()
		ar = rs.split("^")
		translated = GoogleTranslator(source='auto', target=ar[0]).translate(ar[1])
		c.send(str(translated).encode())
		f.write("<*> " +rs + "  " + str(addr) + " <^> Translate Sended\n")
		print ("<*> Translated " + rs + " From " + str(addr) + "\n" )
		c.close()
	except:
		c.send("<!> Connection Or Translating Error, Connection Closed".encode())
		print ("<!> Error Connection From " + str(addr) + " Message: " + rs + "\n")
		f.write("<!> Error Connection From " + str(addr) + "Message: " + rs + "\n")
		c.close()
