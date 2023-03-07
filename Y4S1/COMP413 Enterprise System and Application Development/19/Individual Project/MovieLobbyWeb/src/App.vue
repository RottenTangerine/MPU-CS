<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import { useStore } from 'vuex'
import {computed} from "vue";
const store = useStore()
const storedUserEmail = computed(() => store.state.userEmail)

</script>

<template>
  <div class="container mx-auto my-5">
    <div class="flex sm:justify-center space-x-4" id="nav">
      <router-link to="/library"
                   class="rounded-lg px-3 py-2 text-slate-100 font-extrabold hover:bg-slate-800 hover:text-white">
        Library
      </router-link>
      <router-link
          to="/update"
          class="rounded-lg px-3 py-2 text-slate-100 font-medium hover:bg-slate-800 hover:text-white"
      >Add Movie
      </router-link
      >
      <router-link
          v-if="storedUserEmail === ''"
          to="/login"
          class="rounded-lg px-3 py-2 text-slate-100 font-medium hover:bg-slate-800 hover:text-white"
      >Login
      </router-link
      >
      <router-link
          v-else
          to="/rental"
          class="rounded-lg px-3 py-2 text-slate-100 font-medium hover:bg-slate-800 hover:text-white"
      >My Rentals
      </router-link
      >
    </div>
    <router-view/>
  </div>
</template>
