# -*- coding: utf-8 -*-
"""
Created on Tue May  6 08:17:42 2025

@author: cjnpe
"""

import cv2
import mediapipe as mp

manos = mp.solutions.hands

mano = manos.Hands()

video = cv2.VideoCapture(0)

while video.isOpened():
    r, frame = video.read()
    if not r:
        break
    frame = cv2.flip(frame, 1)
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    resultado = mano.process(rgb)
    if resultado.multi_hand_landmarks:
        for landmark in resultado.multi_hand_landmarks:
            mp.solutions.drawing_utils.draw_landmarks(frame, landmark, manos.HAND_CONNECTIONS)
            
    cv2.imshow("Manos", frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
video.release()
cv2.destroyAllWindows()