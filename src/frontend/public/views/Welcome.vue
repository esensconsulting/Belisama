<style scoped>
.v-card__title {
  background-color: #cf0063;
  background-image: linear-gradient(135deg, #dd1173, #350e47);
  color: white;
}
</style>

<template>
  <v-container>
    <Header />
    <v-main>
      <v-container>
        <v-row>
          <v-col cols="12" md="12">
            <v-card elevation="1" outlined class="mx-auto">
              <v-card-title
                >Welcome to Belisama, condominium for all</v-card-title
              >
              <v-container>
                <v-card-text>
                  Condo management should be simple, transparent and
                  efficient.</v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" outlined class="mx-auto">
              <v-card-title
                >There's a better way to manage your Condominium</v-card-title
              >
              <v-container>
                <v-card-text
                  >A condo management company is responsible for handling the
                  day to day needs of the property they’re managing. Belisama do
                  better for free with transparency and security!</v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" outlined class="mx-auto">
              <v-card-title>Transparent and Secure</v-card-title>
              <v-container>
                <v-card-text
                  >Our solution is build with DFINITY's Internet of the Future.
                  A new technology stack that is tamper-proof, fast, scales to
                  billions of users around the world, and supports a new kind of
                  autonomous software.</v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" outlined class="mx-auto">
              <v-card-title>You're not alone anymore</v-card-title>
              <v-container>
                <v-card-text
                  >Our solution allows you to manage your condo thanks to secure
                  features on a Dfinity blockchain. Exchange opinions with other
                  owners, prepare guidances, vote and monitor common
                  decisions!</v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="12">
            <v-card elevation="1" outlined class="mx-auto">
              <v-card-title>Join now my condominium</v-card-title>
              <v-container>
                <v-list subheader>
                  <v-subheader>Available condominium </v-subheader>
                  <CoproList />
                </v-list>
              </v-container>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-container>
</template>

<script>
import Header from "../components/Header.vue";
import CoproList from "../components/CoproList.vue";
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";

export default {
  components: {
    Header,
    CoproList,
  },
  created() {
    belisama.getMyCopro().then((data) => {
      //si deja dans une copro
      if (data.length != 0) {
        this.$router.push({ path: "home/main" });
      }
    });
  },
  methods: {},
};
</script>
