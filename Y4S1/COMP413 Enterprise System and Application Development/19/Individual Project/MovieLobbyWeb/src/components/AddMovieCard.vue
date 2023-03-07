<script setup lang="ts">

import {ref} from "vue";

const props = defineProps<{
  id: string;
  coverImage: string;
  description: string;
  director: string;
  genre: [string];
  leadingActor: [string];
  rentalPrice: number;
  // runLength: number;
  // studio: string;
  title: string;
  // trailer: string;
  year: number;
}>();


</script>

<template>
  <div class="flex flex-col items-center rounded-lg border shadow-md md:flex-row border-black bg-black my-4">
    <img class="object-cover w-1/3 rounded-l-lg" :src="coverImage" alt="">
    <div class="flex flex-col justify-between p-4 leading-normal">
      <div class="flex flex-col space-y-5">
        <div class="flex justify-between items-start">
          <input v-model="title" class="text-3xl font-bold bg-stone-800 p-2 rounded-xl"/>
        </div>
        <div>
          <span v-for="g in genre" class="text-sm text-gray-400">{{ g }}, </span> <span class="text-blue-600">Edit</span>
          <div class="text-lg text-gray-200">{{ year }}<span class="text-blue-600">  Edit</span></div>
          <span v-for="a in leadingActor" class="text-sm text-gray-400">{{ a }}, </span><span class="text-blue-600">Edit</span>
          <div class="text-md text-gray-200">Director: {{ director }}<span class="text-blue-600">  Edit</span></div>
        </div>
        <textarea v-model="description" class="bg-stone-800 p-2 rounded-xl text-gray-400 max-h-40 overflow-y-hidden"></textarea>
      </div>
    </div>
  </div>

</template>

<style scoped></style>
