<template>
  <v-app>
    <link
      href="https://cdn.jsdelivr.net/npm/@mdi/font@4.x/css/materialdesignicons.min.css"
      rel="stylesheet"
    />
    <Nav />
    <v-app-bar app>
      <v-toolbar-title
        ><v-img
          contain
          class="mx-2"
          :src="logoImgSrc"
          max-height="50"
          max-width="200"
          alt="Belisama"
        >
        </v-img
      ></v-toolbar-title>
      <span style="font-size: 0.7rem;"
        >{{ principal }} {{ role }} {{ belisama }}</span
      >
    </v-app-bar>
    <v-main>
      <v-container>
        <!-- ici le composant du millieux de page -->
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";
import Nav from "./components/Nav.vue";

export default {
  components: {
    Nav,
  },
  data: () => {
    return {
      principal: "",
      belisama: "",
      role: "",
      logoImgSrc: "",
    };
  },

  beforeCreate() {},
  created() {
    frontend.retrieve("logo-belisama.png").then((bytes) => {
      this.logoImgSrc = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
    belisama.callerPrincipal().then((principal) => {
      this.principal = principal;
    });
    belisama.getName().then((message) => (this.belisama = message));
  },
  methods: {},
};
</script>
