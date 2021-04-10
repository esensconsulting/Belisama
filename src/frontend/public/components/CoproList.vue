<template>
  <div>
    <v-list-item v-for="(copro, index) in copros" :key="index">
      <v-list-item-content>
        <v-list-item-title v-text="copro.address"></v-list-item-title>
      </v-list-item-content>

      <v-list-item-icon>
        <v-btn
          elevation="2"
          outlined
          color="pink"
          :loading="loading"
          v-on:click="joinCopro(copro)"
          >Join</v-btn
        >
      </v-list-item-icon>
    </v-list-item>
  </div>
</template>

<script>
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";

export default {
  components: {},
  data: () => {
    return {
      copros: [],
      loading: false,
    };
  },
  created() {
    belisama.getAllCopros().then((data) => (this.copros = data));
  },
  methods: {
    joinCopro: function(copro) {
      this.loading = true;
      console.log(copro);
      belisama.joinCopro(copro.coproId).then((data) => {
        this.loading = false;
        if (data != "not found") this.$router.push({ path: "home/main" });
      });
    },
  },
};
</script>
