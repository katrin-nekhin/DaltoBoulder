#IMPORTS
import cv2
import numpy as np
import io

#image upload


#image process

    #"start" holds identification
    # Load the image
image = cv2.imread('wall.jpg')

    # Apply mean-shift filtering
    # sp: spatial window radius, sr: color window radius
#result_image = cv2.pyrMeanShiftFiltering(image, sp=20, sr=50)
result_image1 = cv2.pyrMeanShiftFiltering(image, sp=50, sr=20)
cv2.imwrite('result1.jpg',result_image1)
result_image2 = cv2.pyrMeanShiftFiltering(result_image1, sp=20, sr=25)
result_image2 = cv2.pyrMeanShiftFiltering(result_image2, sp=10, sr=25)

    # Display the result
cv2.imwrite('result2.jpg',result_image2)

#K-mean
# Reshape image data into a 2D array of pixels and 3 color values (BGR)
Z = image.reshape((-1, 3))
Z = np.float32(Z)

# Define criteria and number of clusters (K)
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
K = 8  # you can adjust K to get more or fewer colors
_, labels, centers = cv2.kmeans(Z, K, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)

# Convert centers to uint8 and reconstruct the image
centers = np.uint8(centers)
quantized = centers[labels.flatten()]
result_image = quantized.reshape((image.shape))

cv2.imwrite('result-k-mean.jpg',result_image)
    

    #for each "start" hold do:
        # find all holds belong to the route (hold's color classification)
        # mark all holds that belong to the route
        # name and save the picture

    #contour "start" holds

    #show user and ask to choose 

    #show image of route according to users choice



#save image
