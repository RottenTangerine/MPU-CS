<script setup>
import {ref, computed, reactive} from 'vue'
import MovieCard from '../components/MovieCard.vue'
import api from '../apiconfig.js'

const movies = reactive([])

const url = api.config.url + '/movie/all'

fetch(url)
    .then(response => response.json())
    .then(data => {
      data['all'].forEach(movie => {
        movies.push(movie)
      })
    })

</script>

<template>
  <div class="container text-center">
    <div class="my-2 leading-8 max-w-screen-md text-left mx-auto">
      <h1 class="text-4xl text-gray-300 font-bold py-5">Movie Library</h1>
      <div class="text-white">

        <MovieCard
            v-for="movie in movies"
            :id="movie.id"
            :coverImage="movie.coverImage"
            :title="movie.title"
            :description="movie.description"
            :genre="movie.genre"
            :year="movie.year"
            :rentalPrice="movie.rentalPrice"
        />

      </div>
    </div>
  </div>
</template>