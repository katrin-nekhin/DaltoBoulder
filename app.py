import cv2
import numpy as np

img = np.zeros((500, 500, 3), dtype=np.uint8)
cv2.putText(img, "Setup Complete!", (50, 250), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)
cv2.imwrite("output.jpg", img)
print("Image saved as output.jpg")
