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
          <h1>
            Managing the finances of the condominium
          </h1>
          <v-container>
            <h3>
              you will find here all the information of the Condominium finances
            </h3>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border">Community money</v-card-title>
          <FakeFinance />
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border">Money donation</v-card-title>
          <v-container>
            <FakeDonation />
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border">why donated money ?</v-card-title>
          <v-container>
            <v-card-text
              >We carry out regular fundraising in order to improve our living
              environment. With this money we carry out various renovation
              works.</v-card-text
            >
            <v-card-text
              >If you have projects do not hesitate to propose a vote, any
              initiative is welcome</v-card-text
            >
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import belisama from "ic:canisters/belisama";
import FakeFinance from "../components/FakeFinance.vue";
import FakeDonation from "../components/FakeDonation.vue";

export default {
  components: {
    FakeFinance,
    FakeDonation,
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
