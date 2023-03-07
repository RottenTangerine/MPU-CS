<script setup>

import api from '../apiconfig.js'

import {useRouter} from "vue-router";
import {reactive, ref} from "vue";

import AddMovieCard from "../components/AddMovieCard.vue";

const route = useRouter()

const movieId = route.currentRoute.value.params.id;
const movie = reactive({})


const options = {
  method: 'GET',
  headers: {
    'X-RapidAPI-Key': api.imdb.key,
    'X-RapidAPI-Host': 'imdb8.p.rapidapi.com'
  }
};

fetch('https://imdb8.p.rapidapi.com/title/get-details?tconst=' + movieId, options)
    .then(response => response.json())
    .then(response => {
      movie.id = movieId
      movie.coverImage = response.image.url
      movie.title = response.title
      movie.year = response.year

      fetch('https://imdb8.p.rapidapi.com/title/get-genres?tconst=' + movieId, options)
          .then(response => response.json())
          .then(response => {
            movie.genre = response
          })

      fetch('https://imdb8.p.rapidapi.com/title/get-synopses?tconst=' + movieId, options)
          .then(response => response.json())
          .then(response => {
            movie.description = response[0].text
          })

      fetch('https://imdb8.p.rapidapi.com/title/get-top-crew?tconst=' + movieId, options)
          .then(response => response.json())
          .then(response => {
            movie.director = response.directors[0].name
          })

      fetch('https://imdb8.p.rapidapi.com/title/get-full-credits?tconst=' + movieId, options)
          .then(response => response.json())
          .then(response => {
            let cast = []
            response.cast.forEach(actor => {
              if (actor.legacyNameText) {
                cast.push(actor.legacyNameText)
              }
            })
            movie.leadingActor = cast.slice(0, 5)
          })
          .catch(err => console.error(err));

      // I am so lazy to fetch the rest of the data
      // the api is so slow and I don't want to wait
      movie.runLength = 120
      movie.studio = 'Studio'
      movie.trailer = 'https://www.youtube.com/watch?v=Q0CbN8sfihY'
    })

const rentalPrice = ref(1.99);

const confirm = () => {
  const movieData = reactive({
    id: movie.id,
    coverImage: movie.coverImage,
    title: movie.title,
    year: movie.year,
    genre: movie.genre.join(', '),
    description: movie.description.replace(/(\r\n|\n|\r)/gm, ''),
    director: movie.director,
    leadingActor: movie.leadingActor.join(', '),
    runLength: movie.runLength,
    studio: movie.studio,
    trailer: movie.trailer,
    rentalPrice: rentalPrice.value
  })

  movieData.description = movieData.description.substring(0, 60) + '...'
  const requestBody = JSON.stringify(movieData)

  let curl = "curl -X POST http://localhost:8080/MovieLobby-1.0-SNAPSHOT/api/movie/add/ -H 'Content-Type: application/json' -d '" + requestBody + "'"
  alert('Copy this curl command to add the movie to the database manually:\n' + curl)

//   const options = {
//     method: 'POST',
//     mode: 'same-origin',
//     credentials: 'same-origin',
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: requestBody
//   }
//
//   fetch(api.config.url + '/movie/add', options)
//       .then(response => response.json())
//       .then(response => {
//         console.log(response)
//         route.push('/movies')
//       })
//       .catch(err => console.log(err));
}

</script>

<template>
  <div class="container text-center">
    <div class="my-2 leading-8 max-w-screen-lg text-left mx-auto">
      <h1 class="text-4xl text-gray-300 font-bold py-5">Edit</h1>
      <div class="text-white">

        <div class="relative">
            <AddMovieCard
                :id="movie.id"
                :coverImage="movie.coverImage"
                :description="movie.description"
                :director="movie.director"
                :genre="movie.genre"
                :leadingActor="movie.leadingActor"
                :rentalPrice="movie.rentalPrice"
                :title="movie.title"
                :year="movie.year"
            />
          <div class="bg-black p-8 border-amber-300 border border-2 rounded-lg">
            <div class="mb-3 grid grid-cols-2">
              <div class="col-span-1">
                Set Rental Price ($)
                <input class="bg-stone-800 rounded-md p-2 flex text-2xl font-bold text-a" v-model="rentalPrice">
              </div>
              <button class="col-span-1 md:ml-32 mt-8 text-black bg-white rounded-lg px-4 py-2 font-bold w-48" @click="confirm">Update</button>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>