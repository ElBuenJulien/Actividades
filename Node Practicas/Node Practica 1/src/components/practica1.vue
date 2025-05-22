<script setup lang="ts">
    import {ref} from 'vue';
    const contador = ref(0);
    const incrementar = () =>{
        contador.value++;
    }
    const decrementar = () =>{
        contador.value--;
    }
</script>

<template>
    <div class="pagina">
        <div class="contenedor">
            <h1>Practica 1</h1>
            <p>
                Practica para realizar un contador mediante un boton.
            </p>
            <div class="contador">
                <p class="cuenta">
                    {{contador}}
                </p>
                <button @click="incrementar">Incremetar</button>
                <button @click="decrementar">Decremetar</button>
            </div>
        </div>
    </div>
</template>

<style>
    .pagina{
        background-color: rgb(165, 165, 165);
        border-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .cuenta{
        font-size: 80px;
    }
    .contenedor{
        padding: 10px;
        text-align: center;
    }
    p{
        font-size: large;
        color: black;
        font-style: normal;
    }
    button{
        background-color: rgb(207, 207, 207);
        border-radius: 10px;
        height: 50px;
        width: 100px;
        margin-right: 10px;
        border-color: rgb(207, 207, 207);;
    }
</style>
