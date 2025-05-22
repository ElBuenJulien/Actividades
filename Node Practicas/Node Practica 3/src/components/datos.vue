<script setup lang="ts">
import { ref, onMounted } from 'vue';

const datos = ref<any[]>([]);

function consultarDatos() {
  fetch('https://teczapotlanejo.com/proyectoESP32/valoresesp.php')
  .then(respuesta => respuesta.json())
  .then((datosRespuesta) => {
    console.log(datosRespuesta);

    if (typeof datosRespuesta[0].success === 'undefined'){
      datos.value = datosRespuesta;
    }else{
      datos.value = []
    }
  })
  .catch(error =>{
    console.log('Error al pedir datos', error)
  })
}

onMounted(() =>{
  consultarDatos()
})

function BorrarDato(id:number){
  console.log(id);

  fetch('https://teczapotlanejo.com/proyectoESP32/valoresesp.php?borrar='+id)
  .then(respuesta => respuesta.json())
  .then((datosRespuesta) => {
    console.log(datosRespuesta);
    window.location.href="datos"
  })
  .catch(error =>{
    console.log('Error al pedir datos', error)
  })
}
 
</script>

<template>
    <div class="Content">
      <h2>Obtener Datos ESP32</h2>
      <br><br>
<table class="table">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Temperatura</th>
      <th scope="col">Humedad</th>
      <th scope="col">Potenciometro</th>
      <th scope="col">Eliminar</th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="dato in datos" :key="dato.id">
      <th scope="row">{{ dato.id }}</th>
      <td>{{ dato.temperatura }}</td>
      <td>{{ dato.humedad }}</td>
      <td>{{ dato.potenciometro }}</td>
      <td><button class="btn btn-danger" v-on:click="BorrarDato(dato.id)">Eliminar</button></td>
    </tr>
  </tbody>
</table>
      <br />
      <div class="button">
        <button class="btn btn-dark" @click="">Obtener Datos</button>
      </div>
      <br><br>
    </div>
  </template>
  
  <style scoped>
  html,
  body {
    height: 100%;
    margin: 0;
    padding: 0;
  }
  
  h1{
      font-size: 80px;
      font-style: bold;
  }
  
  .Content {
    height: 100vh;
    width: 1100px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  
    font-family: sans-serif;
    padding: 20px;
  }

  .table{
    margin-left: 30px;
  }

  input {
    padding: 8px;
    font-size: 16px;
    margin-bottom: 10px;
    border-radius: 10px;
    background-color: white;
    box-shadow: 5px 5px 5px rgb(97, 97, 97);
  }
  
  button {
    padding: 8px 16px;
    font-size: 16px;
    cursor: pointer;
    box-shadow: 5px 5px 5px rgb(97, 97, 97);
  }
  </style>
  