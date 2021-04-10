<template>
  <v-app>
    <link
      href="https://cdn.jsdelivr.net/npm/@mdi/font@5.9.55/css/materialdesignicons.min.css"
      rel="stylesheet"
    />
    <router-view></router-view>
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
  },
  methods: {},
};
</script>
