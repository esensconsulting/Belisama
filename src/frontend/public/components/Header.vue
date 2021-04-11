<style scoped>
.belisima {
  background-color: #cf0063;
  background-image: linear-gradient(135deg, #dd1173, #350e47);
}
</style>

<template>
  <v-app-bar class="belisima" app>
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
    <v-spacer></v-spacer>
    <v-toolbar-title
      ><span class="white--text " style="font-size: 0.7rem;">{{
        principal
      }}</span></v-toolbar-title
    >
  </v-app-bar>
</template>

<script>
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";
export default {
  components: {},
  data: () => {
    return {
      principal: "",
      logoImgSrc: "",
    };
  },

  beforeCreate() {},
  created() {
    frontend.retrieve("logo-white.png").then((bytes) => {
      this.logoImgSrc = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
    belisama.callerPrincipal().then((principal) => {
      this.principal = principal;
    });
  },
  methods: {},
};
</script>
