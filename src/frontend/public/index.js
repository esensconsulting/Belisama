import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import Router from "vue-router";

if (process.env.NODE_ENV === "development") {
  if (!window.ic) {
    const { HttpAgent, IDL } = require("@dfinity/agent");
    const createAgent = require("./createAgent").default;
    window.ic = { agent: createAgent(), HttpAgent, IDL };
  }

  if (!document.getElementById("app")) {
    document.write('<div id="app"></div>');
    const container = document.createElement("div");
    container.id = "app";
    document.body.appendChild(container);
  }
}

const App = require("./App.vue").default;
const Home = require("./views/Home.vue").default;
const Copro = require("./views/Copro.vue").default;
const router = new Router({
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
    }
  ],
});

Vue.use(Vuetify);
Vue.use(Router);

new Vue({
  router,
  vuetify: new Vuetify({}),
  render: (h) => h(App),
}).$mount("#app");
