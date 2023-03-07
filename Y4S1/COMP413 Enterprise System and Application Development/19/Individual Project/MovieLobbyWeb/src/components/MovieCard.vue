<script setup lang="ts">

import router from "../router/router";
import { useStore } from "vuex";
import {computed} from "vue";
import api from "../apiconfig.js";

const store = useStore();
const storedUserEmail = computed(() => store.state.userEmail)
const storedUserToken = computed(() => store.state.userToken)

const props = defineProps<{
  id: string;
  coverImage: string;
  title: string;
  description: string;
  genre: string;
  year: number;
  rentalPrice: number;
}>();

const edit = () => {
  router.push('/edit/' + props.id)
};

const rent = () => {
  if (storedUserToken.value > props.rentalPrice) {
    const requestURL = api.config.url + "/rental/rent/" + props.id + "/" + storedUserEmail.value;
    console.log(requestURL)
    fetch(requestURL)
      .then((res) => res.text())
      .then((json) => {
        if (json === "success") {
          alert("Rent successful");
        }
        console.log(json)
      });
  }

};

</script>

<template>
  <div class="flex flex-col items-center rounded-lg border shadow-md md:flex-row border-black bg-black my-4">
    <img class="object-cover w-1/3 rounded-l-lg" :src="coverImage" alt="">
    <div class="flex flex-col justify-between p-4 leading-normal">
      <div class="flex flex-col space-y-4">
        <div class="flex justify-between items-start">
          <h2 class="text-3xl font-bold">{{ title }}</h2>
        </div>
        <div>
          <div class="text-sm text-gray-400">{{ genre }}</div>
          <div class="text-lg text-gray-200">{{ year }}</div>
        </div>
        <p class="text-gray-400 max-h-40 overflow-y-hidden">{{ description }}</p>
        <div class="flex text-2xl font-bold text-a">${{ rentalPrice }}</div>
      </div>
      <div class="grid grid-cols-2">
        <button class="mt-12 text-black bg-white rounded-lg px-4 py-2 font-bold w-28 col-span-1" @click="rent">Rent</button>
        <button class="mt-12 text-blue-600 rounded-lg px-4 py-2 font-bold w-28 col-span-1" @click="edit">Edit</button>
      </div>
    </div>
  </div>

</template>

<style scoped></style>
