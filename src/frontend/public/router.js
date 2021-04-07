import Vue from "vue";
import Router from "vue-router";
import Home from "./views/Home.vue";
import Copro from "./views/Copro.vue";
import Other from "./views/Other.vue";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      name: "Home",
      component: Home,
    },
    {
      path: "/copro",
      name: "copro",
      component: Copro,
    },
    {
      path: "/other",
      name: "other",
      component: Other,
    },
  ],
});
