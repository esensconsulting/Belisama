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
const Info = require("./views/Information.vue").default;
const Welcome = require("./views/Welcome.vue").default;
const Finance = require("./views/Finance.vue").default;

const router = new Router({
  routes: [
    {
      path: "/home",
      name: "Home",
      component: Home,
      children: [
        {
          path: "main",
          component: Info,
        },
        {
          path: "finance",
          component: Finance,
        },
      ],
    },
    {
      path: "/",
      name: "welcome",
      component: Welcome,
    },
  ],
});

Vue.use(Vuetify);
Vue.use(Router);

new Vue({
  router,
  vuetify: new Vuetify({}),
  render: (h) => h(App),
}).$mount("#app");
