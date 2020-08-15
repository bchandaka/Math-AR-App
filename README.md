# Math AR App
A fun, interactive to way to learn math through AR - Made for the Garudahacks Hackathon
## The Concept
Especially in these times, educating young children virtually can be a very difficult task. So, to better engage and educate young children, we created an app that uses Augmented Reality to display various math tools that can help students learn math in fun and engaging ways. \
The main 3D tools we proposed were:
- Number Line
- Algebra Tiles (used for counting)
- Geometry tools (protactor, ruler)
- geometry objects

## The Technology
The main technologies in this project are:
- Flutter - Used to create an android app that users interact with to learn math through AR
- Unity - Used the Arfoundation and echoAR packages to enable viewing of AR scenes on an android device
- echoAR - Used this AR content management system(and its associated tutorials/libraries) to easily store, update, and retrieve 3d models used in this app

## Working Features
- This app is incomplete, but we were able to implement the homepage UI and the basic number line feature
- The Number Line feature displays a random arithmetic problem at the top of the screen which users can answer by using the 3D number line AR object
    - Problems are randomized addition or subtraction problems with answers in the range -9 to +9, which is the range of the 3D number line
    - We had some difficulty displaying our own custom number line model in the application, but we show that the number line model does work when displayed through a web link from the object's echoAR QR Code
