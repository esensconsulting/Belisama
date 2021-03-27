import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

if (process.env.NODE_ENV === "development") {
  if (!(window).ic) {
    const { HttpAgent, IDL } = require("@dfinity/agent");
    const createAgent = require("./createAgent").default;
    (window).ic = { agent: createAgent(), HttpAgent, IDL };
  }

  if (!document.getElementById("app")) {
    document.write('<div id="app"></div>');
    const container = document.createElement("div");
    container.id = "app";
    document.body.appendChild(container);
  }
}


Vue.use(Vuetify)
const App = require("./App.vue").default;


new Vue({
  vuetify: new Vuetify({}),
  render: (h) => h(App)
}).$mount('#app')