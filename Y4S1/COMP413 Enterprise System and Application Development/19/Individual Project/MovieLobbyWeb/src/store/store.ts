import { createStore } from 'vuex'

export default createStore({
  state: {
    auth: false,
    userEmail: '',
    userToken: 0,
  },
  mutations: {
    setUser(state, userEmail) {
      state.auth = true
      state.userEmail = userEmail
    },
    setToken(state, userToken) {
      state.userToken = userToken
    }
  },
  actions: {}
})