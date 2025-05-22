# -*- coding: utf-8 -*-
"""
Created on Mon Mar 24 08:30:48 2025

@author: cjnpe

rojo claro 0,100,20
rojo oscuro 5,255,255

rojo2 claro 175,100,20
rojo2 oscuro 179,255,255

verde claro 25,20,20
verde oscuro 100,255,255

azul claro 100,100,20
azul oscuro 125,255,255
"""


'''
Verde
'''
import cv2
import numpy as np

img = cv2.imread('colores.jpg')
img2 = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

VerdeClaro = np.array([25,20,20], np.uint8)
VerdeOscuro = np.array([100,255,255], np.uint8)

mascara = cv2.inRange(img2, VerdeClaro, VerdeOscuro)

kernel = np.ones((7,7), np.uint8)

mascara = cv2.morphologyEx(mascara, cv2.MORPH_CLOSE, kernel)
mascara = cv2.morphologyEx(mascara, cv2.MORPH_OPEN, kernel)

seleccion = cv2.bitwise_and(img, img, mask=mascara)

contorno, valor = cv2.findContours(mascara.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

cv2.namedWindow('Resultado', cv2.WINDOW_NORMAL)
cv2.imshow('Resultado', seleccion)

seleccion[mascara>0] = (255,150,200)

cv2.namedWindow('Original', cv2.WINDOW_NORMAL)
cv2.imshow('Original', img)
cv2.namedWindow('Cambio', cv2.WINDOW_NORMAL)
cv2.imshow('Cambio', seleccion)
cv2.waitKey(0)
cv2.destroyAllWindows()


"""
'''
Rojo
'''
import cv2
import numpy as np

img = cv2.imread('colores.jpg')
img2 = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

Rojo1Claro = np.array([0,100,20], np.uint8)
Rojo1Oscuro = np.array([5,255,255], np.uint8)
Rojo2Claro = np.array([175,100,20], np.uint8)
Rojo2Oscuro = np.array([179,255,255], np.uint8)

mascara1 = cv2.inRange(img2, Rojo1Claro, Rojo1Oscuro)
mascara2 = cv2.inRange(img2, Rojo2Claro, Rojo2Oscuro)
mascara = cv2.add(mascara1, mascara2)

seleccion = cv2.bitwise_and(img, img, mask=mascara)

contorno, valor = cv2.findContours(mascara.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

cv2.namedWindow('Resultado', cv2.WINDOW_NORMAL)
cv2.imshow('Resultado', seleccion)

seleccion[mascara>0] = (255,150,200)

cv2.namedWindow('Original', cv2.WINDOW_NORMAL)
cv2.imshow('Original', img)
cv2.namedWindow('Cambio', cv2.WINDOW_NORMAL)
cv2.imshow('Cambio', seleccion)
cv2.waitKey(0)
cv2.destroyAllWindows()
"""

"""
'''
Azul
'''
import cv2
import numpy as np

img = cv2.imread('colores.jpg')
img2 = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

AzulClaro = np.array([100,100,20], np.uint8)
AzulOscuro = np.array([125,255,255], np.uint8)

mascara = cv2.inRange(img2, AzulClaro, AzulOscuro)

kernel = np.ones((7,7), np.uint8)

mascara = cv2.morphologyEx(mascara, cv2.MORPH_CLOSE, kernel)
mascara = cv2.morphologyEx(mascara, cv2.MORPH_OPEN, kernel)

seleccion = cv2.bitwise_and(img, img, mask=mascara)

contorno, valor = cv2.findContours(mascara.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

cv2.namedWindow('Resultado', cv2.WINDOW_NORMAL)
cv2.imshow('Resultado', seleccion)

seleccion[mascara>0] = (255,150,200)

cv2.namedWindow('Original', cv2.WINDOW_NORMAL)
cv2.imshow('Original', img)
cv2.namedWindow('Cambio', cv2.WINDOW_NORMAL)
cv2.imshow('Cambio', seleccion)
cv2.waitKey(0)
cv2.destroyAllWindows()
"""