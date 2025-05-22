<script setup lang="ts">

</script>

<template>
    <div class="content">

    
    <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img class="d-block w-100" src="../img/1.webp" alt="First slide">
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="../img/2.webp" alt="Second slide">
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="../img/3.webp" alt="Third slide">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
</div>
  </template>
  

<style scoped>
    .carousel {
    width: 100%;
    max-width: 100%;
    }

    .carousel-inner {
    height: 100vh;
    }

    .carousel-item {
    height: 100%;
    }

    .carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* o 'contain' si quieres ver toda la imagen sin recorte */
    }

</style>