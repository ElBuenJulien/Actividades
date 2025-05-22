<script setup lang="ts">

</script>

<template>
    <div class="contenedor">
        <h1>Galeria de Imagenes</h1>
        <div class="mosaico">
            <img class="imagen"
                v-for="n in 12"
                :key="n"
                :src="`https://picsum.photos/300/300?random=${n}`"
                alt="Imagen"
            />
        </div>
    </div>
</template>

<style scoped>
    .contenedor{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .mosaico{
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 10px;
        width: 1135px;
        padding: 10px;
        box-sizing: border-box;
        justify-items: center;
    }

    .mosaico img{
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
</style>