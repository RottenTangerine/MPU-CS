<script setup>
import {ref, computed, reactive} from 'vue'

import { useStore } from 'vuex'
const store = useStore()
const storedUserEmail = computed(() => store.state.userEmail)

import api from '../apiconfig.js'
import router from "../router/router";

const userEmail = ref('')
const password = ref('')


const login = () => {
  const loginRequestURL = api.config.url + '/user/login'

  const loginRequest = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      email: userEmail.value,
      hashedPassword: password.value
    })
  }

  fetch(loginRequestURL, loginRequest)
      .then(response => response.text())
      .then(response => {
        if (response === '{\'response\': no_user}') {
          alert('No user with that email, the email is automatically registered')
          const signUpRequestURL = api.config.url + '/user/signup'
          fetch(signUpRequestURL, loginRequest).then(response => response.text()).then(response => {
            if (response === '{\'response\': success}') {
              login()
            } else {
              alert('User creation failed')
            }
          })
        }
        if (response === '{\'response\': authenticated}') {
          store.commit('setUser', userEmail.value)
          router.push('/rental')
        }
        if (response === '{\'response\': invalid_password}') {
          alert('Invalid password')
        }
      })
      .catch(err => console.error(err))
}

</script>

<template>
  <div class="text-white">
    <div class="container text-center">
      <div class="my-2 leading-8 max-w-screen-lg text-left mx-auto">
        <div class="container py-12 px-6 h-full">
          <div class="flex justify-center items-center flex-wrap h-full g-6 text-gray-800">
            <div class="xl:w-10/12">
              <div class="block bg-black shadow-lg rounded-lg">
                <div class="lg:flex lg:flex-wrap g-0">
                  <div class="lg:w-6/12 px-4 md:px-0">
                    <div class="md:p-12 md:mx-6">
                      <div class="text-center">
                        <img
                            class="mx-auto w-48"
                            src="https://media.macosicons.com/parse/files/macOSicons/c8dcf7a1ce958cb19fc3bb37565e41e3_low_res_Movie_Explorer_Pro.png"
                            alt="logo"
                        />
                        <h4 class="text-xl text-white font-semibold mt-1 mb-12 pb-1">Login to MovieLobby</h4>
                      </div>
                      <form>
                        <div class="mb-4">
                          <input
                              type="text"
                              v-model="userEmail"
                              class="form-control block w-full px-3 py-1.5 text-base font-normal text-gray-100 bg-stone-800 bg-clip-padding border border-solid border-gray-700 rounded transition ease-in-out m-0 focus:text-gray-400 focus:bg-stone-700 focus:border-blue-600 focus:outline-none"
                              id="exampleFormControlInput1"
                              placeholder="Email"
                          />
                        </div>
                        <div class="mb-4">
                          <input
                              type="password"
                              v-model="password"
                              class="form-control block w-full px-3 py-1.5 text-base font-normal text-gray-100 bg-stone-800 bg-clip-padding border border-solid border-gray-700 rounded transition ease-in-out m-0 focus:text-gray-400 focus:bg-stone-700 focus:border-blue-600 focus:outline-none"
                              id="exampleFormControlInput1"
                              placeholder="Password"
                          />
                        </div>
                        <div class="text-center pt-1 mb-12 pb-1">
                          <button
                              class="inline-block px-6 py-2.5 text-white font-medium text-xs leading-tight uppercase rounded shadow-md bg-blue-700 hover:bg-blue-800 hover:shadow-lg focus:shadow-lg focus:outline-none focus:ring-0 active:shadow-lg transition duration-150 ease-in-out w-full mb-3"
                              type="button"
                              @click="login"
                              data-mdb-ripple="true"
                              data-mdb-ripple-color="light"
                              style="
                        background: linear-gradient(
                          to right,
                          #ee7724,
                          #d8363a,
                          #dd3675,
                          #b44593
                        );
                      "
                          >
                            Log in / SignUp
                          </button>
                          <a class="text-gray-500" href="#!">Forgot password?</a>
                        </div>
                      </form>
                    </div>
                  </div>
                  <div
                      class="lg:w-6/12 flex items-center lg:rounded-r-lg rounded-b-lg lg:rounded-bl-none"
                      style="
                background: linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);
              "
                  >
                    <div class="text-white px-4 py-6 md:p-12 md:mx-6">
                      <h4 class="text-xl font-semibold mb-6">Movie Lobby</h4>
                      <p class="text-sm">
                        Movie Lobby is a project designed for COMP413 Enterprise System and Application Development
                        as an Individual Assignment Project. The project is designed to be a movie rental system
                        that allows users to rent movies. Developed by <a class="text-blue-400" href="https://github.com/Ex10si0n">Ex10si0n</a>.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>