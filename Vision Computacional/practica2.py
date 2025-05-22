import face_recognition
import cv2
import threading
import time

# Cargar imágenes y codificar rostros
caras = []
nombres = []

imagenes = [
    ('TomHiddleston.jpg', "Tom Hiddleston"),
    ('TomHolland.jpeg', "Tom Holland"),
    ('TomHardy.jpeg', "Tom Hardy")
]

for img_path, nombre in imagenes:
    imagen = face_recognition.load_image_file(img_path)
    encoding = face_recognition.face_encodings(imagen)
    if encoding:
        caras.append(encoding[0])
        nombres.append(nombre)

# Configurar cámara
video = cv2.VideoCapture(0)
video.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
video.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
video.set(cv2.CAP_PROP_FPS, 30)

procesando = True
frame_actual = None
resultado_reconocimiento = "Buscando..."
lock = threading.Lock()

# Capturar frames en tiempo real en un buffer
def capturar_frames():
    global frame_actual
    while procesando:
        ret, frame = video.read()
        if not ret:
            break
        with lock:
            frame_actual = frame.copy()

hilo_captura = threading.Thread(target=capturar_frames, daemon=True)
hilo_captura.start()

# Realizar reconocimiento facial en segundo plano
def reconocer_rostros():
    global resultado_reconocimiento
    while procesando:
        time.sleep(0.05)  # Reducir la pausa para mejorar respuesta
        with lock:
            if frame_actual is None:
                continue
            # Convertir a escala de grises y reducir tamaño para mejorar rendimiento
            frame_pequeno = cv2.resize(frame_actual, (0, 0), fx=0.5, fy=0.5)
            frame_gris = cv2.cvtColor(frame_pequeno, cv2.COLOR_BGR2GRAY)
        
        personas = face_recognition.face_locations(frame_gris, model='hog')
        caras_frame = face_recognition.face_encodings(frame_pequeno, personas)
        
        with lock:
            resultado_reconocimiento = "Desconocido"
            for cara_frame in caras_frame:
                encontradas = face_recognition.compare_faces(caras, cara_frame)
                if True in encontradas:
                    primerCaraEncontrada = encontradas.index(True)
                    resultado_reconocimiento = nombres[primerCaraEncontrada]
                    break

hilo_reconocimiento = threading.Thread(target=reconocer_rostros, daemon=True)
hilo_reconocimiento.start()

# Mostrar video en tiempo real con el resultado del reconocimiento
while True:
    ret, frame = video.read()
    if not ret:
        break
    
    with lock:
        cv2.putText(frame, resultado_reconocimiento, (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)
    
    cv2.imshow("Vista en tiempo real", frame)
    
    if cv2.waitKey(1) & 0xFF == ord('a'):
        break

procesando = False
video.release()
cv2.destroyAllWindows()
