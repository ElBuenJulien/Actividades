# -*- coding: utf-8 -*-
"""
Created on Mon Mar 24 09:40:00 2025

@author: cjnpe
"""

import cv2
import numpy as np
c = 0

camara = cv2.VideoCapture('rojo.mp4')
while(camara.isOpened()):
    ret, frame = camara.read()
    if ret == True:
        img= cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

        Rojo1Claro = np.array([0,100,20], np.uint8)
        Rojo1Oscuro = np.array([5,255,255], np.uint8)
        Rojo2Claro = np.array([175,100,20], np.uint8)
        Rojo2Oscuro = np.array([179,255,255], np.uint8)
        
        mascara1 = cv2.inRange(img, Rojo1Claro, Rojo1Oscuro)
        mascara2 = cv2.inRange(img, Rojo2Claro, Rojo2Oscuro)
        mascara = cv2.add(mascara1, mascara2)

        kernel = np.ones((7,7), np.uint8)

        mascara = cv2.morphologyEx(mascara, cv2.MORPH_CLOSE, kernel)
        mascara = cv2.morphologyEx(mascara, cv2.MORPH_OPEN, kernel)

        seleccion = cv2.bitwise_and(img, img, mask=mascara)

        contorno, valor = cv2.findContours(mascara.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        seleccion[mascara>0] = (255,150,200)
        cv2.imshow('cambio', seleccion)
        cv2.imshow('frame', frame)
        if cv2.waitKey(30) & 0xFF == ord ('a'):
            break
        if cv2.waitKey(30) & 0xFF == ord ('g'):
            cv2.imwrite('img'+str(c)+'.jpg', frame)
            c += 1
    else:
        break
    
camara.release()
cv2.destroyAllWindows()