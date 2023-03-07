<script setup lang="ts">

const props = defineProps<{
  id: string;
  coverImage: string;
  title: string;
  description: string;
  genre: string;
  year: number;
  rentalPrice: number;
}>();

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
    </div>
  </div>

</template>

<style scoped></style>
