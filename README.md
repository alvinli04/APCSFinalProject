# APCSFinalProject
## Stephen's Sausage Squad

Alvin Li and Andrew Juang

Project Description:

We will be implementing a 2D version of the tile-based puzzle game Stephen’s Sausage Roll from a bird’s eye view. It’s an orientation-based puzzle game where the player controlled character pushes sausages with their fork to designated grilling spots for, well, grilling. But if the sausage becomes overcooked or falls off the map, the level must be restarted. There are obstacles on each level, and the player must orient themselves and the sausages correctly to cook the sausages and clear the level.


Expanded Proposal:
https://docs.google.com/document/d/11rjUp0ROTnMHaH1btTx4NzmoW22lxmyqH-2S1eCXvDc/edit?usp=sharing

## Devlog

### 5/23/2021
Alvin - wrote the skeleton for classes and their methods, implemented the basic tile structure of the game, as well as WASD movement and rotations. Put in some obstacles which restrict movement and rotations.

Andrew - worked on prototype diagram, the UML diagram, began brainstorming ideas on the implementation of sausage movement. 

### 5/24/2021
Alvin/Andrew - shared screens in zoom meeting, created branch sausagemovement, and began implementing the touchSausage method. updated the sausage class to work with the touchSausage method. 

### 5/25/2021
Andrew - Fixed bug in forkTouchSausage method where sausage would move even though stephen was not oriented correctly. Also fixed rotations in the stephenTouchSausage method and began brainstorming with Alvin on ways to implement the movement of sausage caused by the rotation of stephen. 

### 5/26/2021
Andrew - Fixed some discrepancies in the way coordinates were being represented.

Alvin - Implemented moving sausages when Stephen rotates.

### 5/27/2021 - 5/28/2021
Andrew - Made some fixes on moving sausages by rotating and fixed merge conflicts

Alvin - Implemented mechanics for grilling, along with win/loss condition

### 5/29/2021
Alvin - Displays text for when win/loss conditions are met, started working on a start menu

Andrew - implemented mechanics for sausage movement when a sausage rolls another sausage

### 5/30/2021
Andrew - Updated UML diagram 

Andrew - Looked into movement animations 
