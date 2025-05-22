<script setup lang="ts">
</script>

<template>
    <div class="menu">
        <div class="bar">
        <h1>Menu</h1>
        <ul class="container">
            <li class="btn btn-light">
                <router-link to="/datos" class="Rutes">Datos </router-link>
            </li>
        </ul>
    </div>
    </div>
</template>

<style scoped>
    .menu{
        padding: 10px;
        text-align: center;
        color: white;
    }

    .container{
        margin-top: 10px;
        padding: 10px;
    }

    .bar{
        width: 100%;
        height: 100%;
        background-color: rgb(32, 32, 32);
        padding: 10px;
        font-family: sans-serif;
        border-radius: 10px;
        box-shadow: 5px 5px 5px rgb(97, 97, 97);
    }
    .Rutes{
        font-size: 20px;
        font-family: sans-serif;
        color: rgb(0, 0, 0);
    }

    .btn{
        box-shadow: 5px 5px 5px rgb(87, 87, 87);
        width: 150px;
        }
</style>
