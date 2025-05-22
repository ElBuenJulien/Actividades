# -*- coding: utf-8 -*-
"""
Created on Mon Mar 31 08:31:22 2025

@author: cjnpe
"""

import face_recognition
import cv2
import pyttsx3

hablar = pyttsx3.init()
voces = hablar.getProperty('voices')
hablar.setProperty('voices', voces[1].id)
rate = hablar.getProperty('rate')
hablar.setProperty('rate', rate)

caras = []
nombres = []
personasencontradas = []

persona1 = face_recognition.load_image_file('TomHiddleston.jpg')
persona2 = face_recognition.load_image_file('TomHolland.jpeg')
persona3 = face_recognition.load_image_file('TomHardy.jpeg')

if face_recognition.face_encodings(persona1):
    personaEncontrada1 = face_recognition.face_encodings(persona1)[0]
    caras.append(personaEncontrada1)
    nombres.append("Tom Hiddleston")

if face_recognition.face_encodings(persona2):
    personaEncontrada2 = face_recognition.face_encodings(persona2)[0]
    caras.append(personaEncontrada2)
    nombres.append("Tom Holland")
    
if face_recognition.face_encodings(persona3):
    personaEncontrada3 = face_recognition.face_encodings(persona3)[0]
    caras.append(personaEncontrada3)
    nombres.append("Tom Hardy")
    
video = cv2.VideoCapture(0)

while True:
    ret, frame = video.read()
    if not ret:
        break
    personas = face_recognition.face_locations(frame)
    caras_frame = face_recognition.face_encodings(frame, personas)
    
    for(arriba, derecha, abajo, izquierda), cara_frame in zip(personas, caras_frame):
        encontradas = face_recognition.compare_faces(caras, cara_frame)
        nom = "Desconocido"
        
        if True in encontradas:
            primerCaraEncontrada = encontradas.index(True)
            nom = nombres[primerCaraEncontrada]
            nom = 'hay una maldicion china que dice gua chimin gua chin chan cho gua chingatumadre' + nom
            
            if nom not in personasencontradas:
                personasencontradas.append(nom)
                hablar.say(nom)
                hablar.runAndWait()
                break
            
        cv2.putText(frame, nom, (izquierda, arriba), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (255, 0, 0), 2)
        
    cv2.imshow("Persona", frame)
    
    if cv2.waitKey(1) & 0xFF == ord('a'):
        break
    
video.release()
cv2.destroyAllWindows()
