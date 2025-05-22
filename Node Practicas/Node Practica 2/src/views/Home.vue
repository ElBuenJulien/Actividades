<script setup lang="ts">
    import LateralBar from '../components/LateralBar.vue';
    import Footer from '../components/footer.vue';
</script>

<template>
    <div class="contenedor">
        <LateralBar></LateralBar>
    
        <div class="Content">
            <router-view></router-view>
        </div>
    </div>
    <Footer></Footer>
</template>

<style scoped>
.Titulo{
    font-size: large;
    font-family: sans-serif;
    size: 10px;
}

.contenedor{
    display: flex;
    height: 100%;
}
.content{
    flex: 1;
    width: 100%;
    padding: 20px;
}
</style>
