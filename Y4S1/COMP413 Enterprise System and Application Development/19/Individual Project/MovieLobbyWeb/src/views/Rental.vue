<script setup>
// import { reactive, ref, watch, computed } from 'vue'
import api from "../apiconfig";
import RentalMovieCard from "../components/RentalMovieCard.vue";
import { computed, ref } from "vue";
import { useStore } from "vuex";

const store = useStore();
const storedUserEmail = computed(() => store.state.userEmail)
const storedUserToken = computed(() => store.state.userToken)

const add = ref(10)
const topUp = () => {
  const requestURL = api.config.url + "/user/token/topup/" + storedUserEmail.value + "/" + add.value;
  fetch(requestURL)
    .then((res) => res.text())
    .then((json) => {
      if (json === "{'response': success}") {
        alert("Top up $" + add.value + " successful");
        getToken()
      }
    });
}

const getToken = () => {
  const requestURL = api.config.url + "/user/token/" + storedUserEmail.value;
  const options = {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  };
  fetch(requestURL, options)
    .then((res) => res.text())
    .then((json) => {
      store.commit("setToken", json);
    });
}

const movieList = ref([]);

const getRental = () => {
  const requestURL = api.config.url + "/rental/get/" + storedUserEmail.value;
  fetch(requestURL)
    .then((res) => res.json())
    .then((json) => {
      json.forEach((element) => {
        const requestMovieURL = api.config.url + "/movie/get/" + element.movieId;
        fetch(requestMovieURL)
          .then((res) => res.json())
          .then((movie) => {
            movie.rentalPrice = element.rentalPrice;
            movieList.value.push(movie);
          });
      });
    });
}


getToken()
getRental()

</script>

<template>
  <div class="container text-center text-white">
    <div class="my-2 leading-8 max-w-screen-md text-left mx-auto">
      <h1 class="text-4xl text-gray-300 font-bold py-5">Hello {{ storedUserEmail.split('@')[0] }}</h1>
      <div class="bg-black p-10 rounded-2xl grid grid-cols-2">
        <div class="text-white col-span-1">
          Balance ${{ storedUserToken.split('.')[0] + '.' + storedUserToken.split('.')[1].substring(0, 2) }}
        </div>
        <div class="col-span-1">
          Add $
          <input class="bg-stone-700 w-1/3 rounded-l inline-block px-3" v-model="add" type="number">
          <button @click="topUp" class="rounded-r bg-white w-10 text-black">
            +
          </button>
        </div>
      </div>
      <h1 class="text-4xl text-gray-300 font-bold py-5">My Rentals</h1>
      <div v-for="movie in movieList">
        <RentalMovieCard 
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
