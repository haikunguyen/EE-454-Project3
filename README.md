# EE-454-Project3
Repository for EE 454 Project 3

This project demonstrates four simple motion detection algorithms used on a collection of images:
  1. Simple Background Subtraction
  2. Simple Frame Differencing
  3. Adaptive Background Subtraction
  4. Persistent Frame Differencing
  
The project was implemented using MATLAB.


In this repository, you will find:
  1. panelView.m - a composite of all four motion detection algorithms used to render a 4-panel video displaying each method
  2. simpleBGsubtract.m - an implementation of simple background subtraction method with video rendering
  3. simpleFrameDifference.m - an implementation of simple frame differencing method with video rendering
  4. adaptiveBGsubtract.m - an implementation of adaptive background subtraction method with video rendering
  5. persistFrameDifference.m - an implementation of persistent frame differencing method with video rendering
  6. grayscale.m - a function used to convert a picture to grayscale
  7. getDim.m - a function used to get the pixel dimension of a picture
  8. thresholding.m - a function used to filter pixels to a certain threshold. (pixels below) = 0 & (pixels above) == 255



Implementation Process:

simpleBGsubtract, simpleFrameDifference, adaptiveBGsubtract, and persistFrameDifference were all created as test programs to
individually demonstrate each motion detecting algorithm for analysis and refinement of their implementation in the code.

Once each individual algorithms' code was sufficient, they were implemented into a single program (panelView) to allow for direct 
comparison between each algorithm with a 4-panel display.


*NOTE: 

You can find a full report on this project in the repository titled, "Motion Detection Report."

The report details the implementation procedure, as well as the intermediate and final results and the code's efficiency in more detail.
