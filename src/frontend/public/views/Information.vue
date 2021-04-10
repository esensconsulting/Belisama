<style scoped>
.v-card__title {
  color: #cf0063;
}
.bottom-border {
  border-bottom: inherit;
}
</style>

<template>
  <v-container>
    <v-row>
      <v-col cols="12" md="12">
        <v-card elevation="0" class="mx-auto mt-10 text-center">
          <h1>Welcome to Belisama for {{ this.copro.address }}</h1>
          <v-container>
            <h3>
              you will find here all the information of the Condominium
            </h3>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border"
            >Members of condominium</v-card-title
          >
          <v-container>
            <v-card-text><FakeMembers /> </v-card-text>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border">News</v-card-title>
          <v-container>
            <FakeNews />
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border"
            >Participate in the life of the community</v-card-title
          >
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
