<template>
  <div>
    <v-list-item v-for="copro in copros" :key="copro.coproId.toString()">
      <v-list-item-content>
        <v-list-item-title v-text="copro.address"></v-list-item-title>
      </v-list-item-content>

      <v-list-item-icon>
        <v-btn
          elevation="2"
          outlined
          color="pink"
          :loading="loading && indexClicked === copro.coproId.toString()"
          v-on:click="joinCopro(copro, copro.coproId.toString())"
          >Join</v-btn
        >
      </v-list-item-icon>
    </v-list-item>
  </div>
</template>

<script>
import belisama from "ic:canisters/belisama";

export default {
  components: {},
  data: () => {
    return {
      copros: [],
      loading: false,
      indexClicked: undefined,
    };
  },
  created() {
    belisama.getAllCopros().then((data) => (this.copros = data));
  },
  methods: {
    joinCopro: function(copro, index) {
      this.indexClicked = index;
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
