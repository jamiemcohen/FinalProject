# FinalProject
Computer Networks Final Project
Location Tracker by Jamie Cohen
Live Demo: https://youtu.be/j6F7USkTOzQ

Summary
This project originally set out to create an iOS application that could integrate a mapping functionality to gather user’s current location and send it to an external server.

Components
This project has two components: a simple TCP socket server written in python that uses a framework called “Twisted” to handle the connections, and an iOS application written in Objective-C that asks for a user's’ name, collects their location, and sends it to the server. The idea behind using a TCP server is that it can handle multiple connections at once and if many people had the application on their phone, it would be able to collect the location information from all the users at the same time. 

User Guide
1. Download the file entitle “server.py”
2. Ensure that Python is installed on your mac, and download the Twisted framework http://twistedmatrix.com/trac/wiki/Downloads
3. Open Terminal and type in “sudo python server.py” to start the TCP server. This TCP server will run on your local port 21, so please kill all connections on that port. 
You can even test the connection by opening up another terminal window and typing in ”telnet localhost 21”
4. Download the Xcode project file entitle “FinalProject”
5. Make sure the TCP connection is still open and hit run. 
6. You will be prompted with a screen containing a map view zoomed to Vanderbilt University.
7. Write your name in the text box and press “Send Location”
8. A new view will appear showing your current location’s latitude and longitude. 
9. Look at the terminal output and see that the server received the name and location as well. 
10. Click “Send Again” to try the functionality again and return to the initial view. 




