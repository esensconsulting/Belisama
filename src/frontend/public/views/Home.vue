<template>
  <v-container>
    <Nav />
    <Header />
    <v-main>
      <v-container>
        <!-- ici le composant du millieux de page -->
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-container>
</template>

<script>
import belisama from "ic:canisters/belisama";
import Nav from "../components/Nav.vue";
import Header from "../components/Header.vue";

export default {
  components: {
    Nav,
    Header,
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
    belisama.getMyCopro().then((data) => {
      //si pas dans une copro
      if (data.length == 0) {
        this.$router.push({ path: "/" });
      }
    });
    belisama.callerPrincipal().then((principal) => {
      this.principal = principal;
    });
    belisama.getName().then((message) => (this.belisama = message));
  },
  methods: {},
};
</script>
