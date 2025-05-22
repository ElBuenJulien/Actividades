# -*- coding: utf-8 -*-
"""
Created on Fri Apr  4 07:41:56 2025

@author: cjnpe
"""

from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import QtWidgets
from PyQt5.QtWidgets import QFileDialog, QApplication, QMainWindow, QMessageBox
import sys
import cv2
import numpy as np
from main import Ui_MainWindow
import face_recognition
import json
import os

class MiClase(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__()
        self.ventana = Ui_MainWindow()
        self.ventana.setupUi(self)
        self.ventana.mnu_guardar.triggered.connect(self.MostrarGuardar)
        self.ventana.mnu_identificar.triggered.connect(self.MostrarIdentificar)
        self.ventana.mnu_salir.triggered.connect(self.salir)
        self.ventana.btn_guardar.clicked.connect(self.guardar)
        self.ventana.btn_identificar.clicked.connect(self.identificarRostro)

        self.Work = None
        self.Work2 = None

    def MostrarGuardar(self):
        self.ventana.frame1.setEnabled(True)
        self.ventana.frame2.setEnabled(False)
        self.ActivarCamara()

    def MostrarIdentificar(self):
        self.ventana.frame2.setEnabled(True)
        self.ventana.frame1.setEnabled(False)
        self.ActivarCamara2()

    def salir(self):
        self.close()

    def ActivarCamara(self):
        if self.Work is None:
            self.Work = Work()
            self.Work.ImagenC.connect(self.lbl_Imagen_cargar)
            self.Work.start()
            
    def ActivarCamara2(self):
        if self.Work2 is None:
            self.Work2 = Work2()
            self.Work2.ImagenC.connect(self.lbl_Imagen_cargar)
            self.Work2.lbl_nombre.connect(self.mostrarNombre)
            self.Work2.start()

    def lbl_Imagen_cargar(self, Imagen):
        self.ventana.lbl_image.setPixmap(QPixmap.fromImage(Imagen))

    def closeEvent(self, event):
        if self.Work is not None:
            self.Work.hilo = False
            self.Work.wait()
        if self.Work2 is not None:
            self.Work2.hilo = False
            self.Work2.wait()
        event.accept()
        
    def guardar(self):
        texto = self.ventana.txt_nombre.text()
        if texto == "":
            QMessageBox.warning(self, "¡Advertencia!", "Escribe un nombre por favor")
        else:
            if self.Work:
                self.Work.recibirNombre(texto)
                self.Work.capturar = 2
                QMessageBox.information(self, "¡ÉXITO!", "Persona Registrada Correctamente")
                
    def identificarRostro(self):
        if self.Work2:
            self.Work2.bandera = True
        
    def mostrarNombre(self, nombre):
        self.ventana.lbl_nombre.setText(nombre)


class Work2(QThread):
    ImagenC = pyqtSignal(QImage)
    lbl_nombre = pyqtSignal(str)

    def __init__(self):
        super().__init__()
        self.nombre = ""
        self.bandera = False
        self.caras = []
        self.nombres = []
        
        try:
            if os.path.exists("fotos.json"):
                with open("fotos.json", "r") as f:
                    personas = json.load(f)
                    
                    for persona in personas:
                        img = face_recognition.load_image_file(persona["imagen"])
                        personaEncontrada = face_recognition.face_encodings(img)
                        if personaEncontrada:
                            self.caras.append(personaEncontrada[0])
                            self.nombres.append (persona["nombre"])
                            
        except Exception as e:
            print(f"error {e}")
        
    def recibirNombre(self, texto):
        self.nombre = texto

    def run(self):
        self.hilo = True
        video = cv2.VideoCapture(0)
        while self.hilo:
            ret, frame = video.read()
            if ret:
                image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)
                if self.bandera:
                    self.bandera = False
                    ubicaciones = face_recognition.face_locations(image)
                    codigos_frame = face_recognition.face_encodings(image, ubicaciones)

                    for (arriba, derecha, abajo, izquierda), codificacion in zip (ubicaciones, codigos_frame):
                        #coincidencias = face_recognition.compare_faces(self.caras, cara_frame)
                        nom = "Desconocido"
                        #if True in coincidencias:
                        if self.caras:
                            distancia = face_recognition.face_distance(self.caras, codificacion)
                            min_distancia = min(distancia)
                            indice_min = distancia.tolist().index(min_distancia)
                            if min_distancia < 0.5:
                                nom = "Hola  " + self.nombres[indice_min]
                            #index = coincidencias.index(True)
                            #nom = "Hola  " + self.nombres[index]
                        else:
                            nom = "Desconocido"
                            self.lbl_nombre.emit(nom)

                conversion = QImage(image.data, image.shape[1], image.shape[0], QImage.Format_RGB888)
                p = conversion.scaled(400, 300, Qt.KeepAspectRatio)
                self.ImagenC.emit(p)
            QThread.msleep(30)
        video.release()


class Work(QThread):
    ImagenC = pyqtSignal(QImage)

    def __init__(self):
        super().__init__()
        self.hilo = True
        self.capturar = 0
        self.nombre = ""

    def recibirNombre(self, texto):
        self.nombre = texto

    def run(self):
        video = cv2.VideoCapture(0)
        while self.hilo:
            ret, frame = video.read()
            if ret:
                image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)   
                if self.capturar == 2:
                    if not os.path.exists('Rostros'):
                        os.makedirs('Rostros')
                    rutaimagen = os.path.join('Rostros', self.nombre + ".jpg")
                    #archivo = self.nombre + ".jpg"
                    cv2.imwrite(rutaimagen, frame)
                    lista = []
                    if os.path.exists("fotos.json"):
                        with open ("fotos.json", "r") as f:
                            lista = json.load(f)
                    lista.append({"nombre":self.nombre, "imagen":rutaimagen})
                    with open ("fotos.json", "w") as f:
                        json.dump(lista, f, indent=4)
                    self.capturar = 0
                conversion = QImage(image.data, image.shape[1], image.shape[0], QImage.Format_RGB888)
                p = conversion.scaled(400, 300, Qt.KeepAspectRatio)
                self.ImagenC.emit(p)
            QThread.msleep(30)
        video.release()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    ventana = MiClase()
    ventana.show()
    sys.exit(app.exec_())
