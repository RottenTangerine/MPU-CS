<script setup lang="ts">

import router from "../router/router";

const props = defineProps<{
  id: string;
  coverImage: string;
  title: string;
  genre: string;
  year: number;
  actors: string;
}>();

const add = () => {
  router.push("/add/" + props.id);
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
          <span v-for="g in genre" class="text-sm text-gray-400">{{ g }}, </span>
          <div class="text-lg text-gray-200">{{ year }}</div>
        </div>
        <p class="text-gray-400 max-h-40 overflow-y-hidden">{{ actors }}</p>
      </div>
      <button class="mt-12 text-black bg-white rounded-lg px-4 py-2 font-bold w-28" @click="add">Add</button>
    </div>
  </div>

</template>

<style scoped></style>
