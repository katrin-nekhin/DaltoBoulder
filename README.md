# DaltoBoulder (Climbing Route Visualizer for Color Blind)
This app helps color-blind (daltonic) boulder climbers identify the holds belonging to their chosen route. The app will highlight the relevant holds to assist climbers to navigate the wall.


Instructions for downloading the Android command-line tools:

wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip -d $HOME/Android/Sdk/cmdline-tools
mv $HOME/Android/Sdk/cmdline-tools/cmdline-tools $HOME/Android/Sdk/cmdline-tools/latest


# Progerss Summary 
Goal:
1. Highlight climbing holds from a wall image.
2. Identify and highlight a specific route by its color.

Methods Tested:

1. Noise Removal & Smoothing:
  - Used cv.fastNlMeansDenoisingColored and morphological operations to clean up the image and preserve small holds.
   
2. Color-Based Thresholding:
  - Converted images to HSV and tried to segment holds by thresholding hue, saturation, and value.
  - Attempted to classify holds by finding peaks in the hue histogram.
    
3. Manual Color Selection:
  - Selected a pixel as a reference for a route’s color and segmented similar pixels.

4. Background Removal:
  - Estimated background color using histogram and random sampling, then masked it out.

5. Block-wise Color Segmentation:
  - Divided the image into blocks, found dominant color in each, and masked accordingly.

6. Edge Detection & K-means (Exploratory)
  - Applied edge detection and experimented with blurring and morphological operations.

# Results
- Noise removal and morphological smoothing: improved image quality and hold visibility.
- Color-based segmentation: worked to some extent but struggled with overlapping colors, lighting, and background similarity.
- Manual color selection: could highlight a route but was sensitive to color variation and lighting.
- Block-wise segmentation: helped localize colors but was limited by block size and color diversity.
- Edge detection: provided hold outlines but not reliable segmentation.

# Best Potential
Color-based segmentation (HSV thresholding) combined with morphological operations showed the most promise for highlighting holds and routes, but needs refinement for robustness.

# Ideas Forward
Semantic Segmentation: Use deep learning (e.g., U-Net, Mask R-CNN) to automatically segment holds and routes, regardless of color or lighting.
Data Annotation: Prepare labeled images for training a segmentation model.
Combine Color & Shape: Integrate color segmentation with edge/contour detection for better accuracy.
User Interaction: Allow manual selection of holds/routes to guide segmentation.
Let me know if you want a more detailed breakdown or suggestions for semantic segmentation experiments!

