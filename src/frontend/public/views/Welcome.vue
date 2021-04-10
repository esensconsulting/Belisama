<style scoped>
.bottom {
  position: absolute;
  bottom: 0;
}
.belisima {
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
            <v-card elevation="0" class="mx-auto mt-10 text-center">
              <h1>Welcome to Belisama, condominium for all</h1>
              <v-container>
                <v-card-text
                  ><h3>
                    Condo management should be simple, transparent and
                    efficient.
                  </h3></v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" shaped outlined class="mx-auto">
              <v-img height="200px" :src="one">
                <v-card-title class="white--text bottom"
                  ><h3>
                    There's a better way to manage your Condominium
                  </h3></v-card-title
                >
              </v-img>
              <v-container>
                <v-card-text
                  ><h4>
                    condo management company is responsible for handling the day
                    to day needs of the property they’re managing. Belisama do
                    better for free with transparency and security!
                  </h4></v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" outlined shaped class="mx-auto">
              <v-img height="200px" :src="two">
                <v-card-title class="white--text bottom"
                  ><h3>Transparent and Secure</h3></v-card-title
                >
              </v-img>
              <v-container>
                <v-card-text
                  ><h4>
                    Our solution is build with DFINITY's Internet of the Future.
                    A new technology stack that is tamper-proof, fast, scales to
                    billions of users around the world, and supports a new kind
                    of autonomous software.
                  </h4></v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card elevation="1" outlined shaped class="mx-auto">
              <v-img height="200px" :src="three">
                <v-card-title class="white--text bottom"
                  ><h3>You're not alone anymore</h3></v-card-title
                >
              </v-img>
              <v-container>
                <v-card-text
                  ><h4>
                    Our solution allows you to manage your condo thanks to
                    secure features on a Dfinity blockchain. Exchange opinions
                    with other owners, prepare guidances, vote and monitor
                    common decisions!
                  </h4></v-card-text
                >
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="12">
            <v-card elevation="1" outlined shaped class="mx-auto">
              <v-card-title class="belisima"
                >Join now my condominium</v-card-title
              >
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
  data: () => {
    return {
      one: "",
      two: "",
      three: "",
    };
  },
  created() {
    frontend.retrieve("one.png").then((bytes) => {
      this.one = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
    frontend.retrieve("two.png").then((bytes) => {
      this.two = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
    frontend.retrieve("three.png").then((bytes) => {
      this.three = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
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
