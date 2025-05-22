<script setup lang="ts">
    import {ref} from 'vue';

    const error = ref('');
    const n1 = ref(0);
    const n2 = ref(0);
    const result = ref(0)

    const dividir = () =>{
        if (n2.value == 0){
            error.value = 'no se puede dividir entre 0';
        }
        else{
            result.value = n1.value / n2.value;
        }
    }
</script>

<template>
    <div class="Content">
        <h1>Division</h1>
        <input type="number" id="n1" v-model="n1" placeholder="Escribe un Numero">
        <br>
        <br>
        <input type="number" id="n2" v-model="n2" placeholder="Escribe otro Numero">
        <br>
        <br>
        <div class="button">
            <button @click="dividir">Dividir</button>
        </div>
        <div class="Result">
            <h1>Resultado:</h1>
            <h2>{{ error }}</h2>
            <h2>{{result}}</h2>
        </div>
    </div>
</template>

<style scoped>
    .Content{
        padding: 10px;
        font-family: sans-serif;
    }
</style>
