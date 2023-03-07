import { createRouter, createWebHashHistory, Router } from "vue-router"
import Home from "../views/Home.vue";

const webHistory = createWebHashHistory()

export default createRouter({
  history: webHistory,
  routes: [
    { path: "/", component: Home },
    { path: "/library", component: () => import("../views/Library.vue") },
    { path: "/add/:id", component: () => import("../views/AddMovieConfirm.vue") },
    { path: "/edit/:id", component: () => import("../views/EditMovieConfirm.vue") },
    { path: "/update", component: () => import("../views/AddMovie.vue") },
    { path: "/login", component: () => import("../views/UserLogin.vue") },
    { path: "/rental", component: () => import("../views/Rental.vue") },
  ]
})