<script setup lang="ts">
import Quickguide from "../components/MovieCard.vue";
// import { reactive, ref, watch, computed } from 'vue'
import { computed } from "vue";
import { useStore } from "vuex";

const store = useStore();

const hello = computed(() => {
  return store.state.hello;
});
</script>

<template>
  <div class="container text-center text-white">
  </div>
</template>
