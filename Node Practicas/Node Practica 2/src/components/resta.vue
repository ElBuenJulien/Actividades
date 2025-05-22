<script setup lang="ts">
    import {ref} from 'vue';

    const n1 = ref(0);
    const n2 = ref(0);
    const result = ref(0)

    const restar = () =>{
        result.value = n1.value - n2.value;
    }
</script>

<template>
    <div class="Content">
      <h1>Resta</h1>
      <br><br>
      <input type="number" v-model="n1" placeholder="Escribe un Número" />
      <br />
      <input type="number" v-model="n2" placeholder="Escribe otro Número" />
      <br />
      <div class="button">
        <button class="btn btn-dark" @click="restar">Restar</button>
      </div>
      <br><br>
      <div class="Result">
        <h2>Resultado: {{ result }}</h2>
      </div>
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
  