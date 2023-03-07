<script setup>
import {ref, reactive} from 'vue'
import SearchResult from '../components/SearchResult.vue'
import api from '../apiconfig.js'

const url = api.config.url + '/movie/all'

const searchTitle = ref('')
const searchResults = reactive([])

const searchMovie = () => {
  // clear search results
  searchResults.splice(0, searchResults.length)
  const url = 'https://imdb8.p.rapidapi.com/auto-complete/' + '?q=' + searchTitle.value;
  const options = {
    method: 'GET',
    headers: {
      'X-RapidAPI-Key': api.imdb.key,
      'X-RapidAPI-Host': 'imdb8.p.rapidapi.com'
    },
  };
  fetch(url, options)
    .then(res => res.text())
    .then(json => {
      JSON.parse(json).d.forEach(movie => {
        if (movie.i && movie.id && movie.l && movie.q && movie.y && movie.s) {
          searchResults.push(movie)
          console.log(movie)
        }
      })
    })
}
</script>

<template>
  <div class="container text-center">
    <div class="my-2 leading-8 max-w-screen-md text-left mx-auto">
      <h1 class="text-4xl text-gray-300 font-bold py-5">Add Movie</h1>
      <div class="text-white">

        <div class="relative">
          <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
            <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
          </div>
          <input v-model="searchTitle" type="search" id="default-search" class="block p-4 pl-10 w-full text-sm rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 bg-gray-700 border-gray-600 placeholder-gray-400 text-white focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Search Movie Name ..." required>
          <button @click="searchMovie" class="text-black absolute right-2.5 bottom-2.5 bg-white font-medium rounded-lg text-sm px-4 py-2">Search for <span class="font-bold">{{ searchTitle }}</span></button>
        </div>

        <div v-for="result in searchResults" class="my-4">
          <SearchResult
              :id="result.id"
              :title="result.l"
              :year="result.y"
              :coverImage="result.i.imageUrl"
              :genre="result.genre"
              :actors="result.s"
          />
        </div>

      </div>
    </div>
  </div>
</template>