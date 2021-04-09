<style scoped>
.v-card__title {
  background-color: #cf0063;
  background-image: linear-gradient(135deg, #dd1173, #350e47);
  color: white;
}
</style>

<template>
  <v-container>
    <v-row>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined class="mx-auto">
          <v-card-title
            >Welcome to Belisama for {{ this.copro.address }}</v-card-title
          >
          <v-container>
            <v-card-text>
              you will find here all the information of the
              Condominium</v-card-text
            >
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined class="mx-auto">
          <v-card-title>Members of condominium</v-card-title>
          <v-container>
            <v-card-text><FakeMembers /> </v-card-text>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined class="mx-auto">
          <v-card-title>News</v-card-title>
          <v-container>
            <FakeNews />
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined class="mx-auto">
          <v-card-title>Participate in the life of the community</v-card-title>
          <v-container>
            <v-card-text
              >You can vote and propose votes from this application in order to
              improve the quality of life of the condominium</v-card-text
            >
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";
import FakeMembers from "../components/FakeMembers.vue";
import FakeNews from "../components/FakeNews.vue";

export default {
  components: {
    FakeMembers,
    FakeNews,
  },
  data: () => {
    return {
      copro: "",
    };
  },
  created() {
    belisama.getMyCopro().then((data) => {
      this.copro = data[0];
    });
  },
  methods: {},
};
</script>
