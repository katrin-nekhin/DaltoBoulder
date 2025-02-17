from fastapi import FastAPI, UploadFile, File
import cv2
import numpy as np
import io

app = FastAPI()

@app.post("/process-image/")
async def process_image(file: UploadFile = File(...)):
    contents = await file.read()
    np_img = np.frombuffer(contents, np.uint8)
    img = cv2.imdecode(np_img, cv2.IMREAD_COLOR)

    # Example: Convert image to grayscale
    gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Encode the processed image back to bytes
    _, encoded_img = cv2.imencode(".jpg", gray_img)
    return {"message": "Image processed successfully", "image": encoded_img.tobytes()}
