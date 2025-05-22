# -*- coding: utf-8 -*-
"""
Created on Fri May  9 07:20:46 2025

@author: cjnpe
"""

import cv2
import mediapipe as mp

manos = mp.solutions.hands

mano = manos.Hands(static_image_mode=False, max_num_hands=2, min_detection_confidence=0.5)

dibujar_manos = mp.solutions.drawing_utils

video = cv2.VideoCapture(0)

while video.isOpened():
    r, frame = video.read()
    if not r:
        break
    frame = cv2.flip(frame, 1)
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    resultado = mano.process(rgb)
    
    total_dedos = 0
    
    if resultado.multi_hand_landmarks:
        for landmark in resultado.multi_hand_landmarks:
            dibujar_manos.draw_landmarks(frame, landmark, manos.HAND_CONNECTIONS)
            
            dedos = []
            
            for punta in [8,12,16,20]:
                if landmark.landmark[punta].y < landmark.landmark[punta - 2].y:
                    dedos.append(1)
                else:
                    dedos.append(0)
                    
            pulgarI = landmark.landmark [4]
            pulgarD = landmark.landmark [2]
            if pulgarI.x < pulgarD.x:
                dedos.append(1)
            else:
                dedos.append(0)
                
            total_dedos += sum(dedos)
            
    cv2.putText(frame, f"Dedos: {total_dedos}", (10,80), cv2.FONT_HERSHEY_SIMPLEX, 2, (0,255,0), 2)
            #mp.solutions.drawing_utils.draw_landmarks(frame, landmark, manos.HAND_CONNECTIONS)
            
    cv2.imshow("Cuenta Dedos", frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
video.release()
cv2.destroyAllWindows()