<template>
  <v-app>
    <link
      href="https://cdn.jsdelivr.net/npm/@mdi/font@4.x/css/materialdesignicons.min.css"
      rel="stylesheet"
    />
    
    <v-navigation-drawer app>
      <!-- -->
    </v-navigation-drawer>

    <v-app-bar app>
      <v-toolbar-title
        ><v-img
          contain
          class="mx-2"
          :src="logoImgSrc"
          max-height="40"
          max-width="200"
          alt="Belisama"
        >
        </v-img
      ></v-toolbar-title>
    </v-app-bar>

    <!-- Sizes your content based upon application components -->
    <v-main>
      <!-- Provides the application the proper gutter -->
      <v-container fluid>
        {{ principal }} {{ role }} {{ belisama }}
        <!-- If using vue-router -->
        <!-- <router-view></router-view> -->
        <v-form ref="form" @submit.prevent="createItem">
          <v-container>
            <v-row>
              <v-col cols="12" md="4">
                <v-text-field
                  v-model="name"
                  label="name"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <v-text-field
                  v-model="description"
                  label="description"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <v-btn type="submit" color="primary" :disabled="busy">
                  Ajouter
                </v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
        <v-data-table
          ref="stock-table"
          :items="items"
          :headers="headers"
          item-key="name"
          :items-per-page="5"
          :loading="busy"
          loading-text="Chargement du stock en cours..."
          sort-by="id"
        >
          <template v-slot:item.actions="{ item }">
            <v-icon
              v-if="isAvailable(item)"
              small
              class="mr-2"
              @click="borrowItem(item.id)"
              color="green"
              :disabled="busy"
            >
              mdi-arrow-down-circle-outline
            </v-icon>
            <v-icon
              v-else
              small
              @click="unborrowItem(item.id)"
              color="red"
              :disabled="busy"
            >
              mdi-arrow-up-circle-outline
            </v-icon>
          </template>
        </v-data-table>
        <!-- <loan-log /> -->
        <copro />
      </v-container>
    </v-main>

    <v-footer app>
      <!-- -->
    </v-footer>
  </v-app>
</template>

<script>
import frontend from "ic:canisters/frontend";
import stock from "ic:canisters/stock";
import auth from "ic:canisters/main";
import belisama from "ic:canisters/belisama";
// import LoanLog from "./LoanLog.vue";
import Copro from "./copro/Copro.vue";

export default {
  components: { 
    // LoanLog, 
    Copro 
  },
  data: () => {
    return {
      principal: "",
      belisama: "",
      role: "",
      name: "",
      description: "",
      items: [],
      loans: [],
      headers: [
        { text: "Id", value: "id" },
        { text: "Nom", value: "name" },
        { text: "Description", value: "description" },
        { text: "Emprunteur", value: "borrower" },
        { text: "Actions", value: "actions", sortable: false },
      ],
      busy: false,
      logoImgSrc: "",
    };
  },

  beforeCreate() {
  },
  created() {
    frontend.retrieve("Belisama-rose.png").then((bytes) => {
      this.logoImgSrc = URL.createObjectURL(
        new Blob([new Uint8Array(bytes)], {
          type: "image/png",
        })
      );
    });
    this.busy = true;
    this.getAllItems();
    auth.callerPrincipal().then((principal) => {
      this.principal = principal;
    });
    auth.my_role().then((role) => {
      this.role = Object.keys(role[0])[0];
    });
    belisama.getName().then(message => this.belisama = message);
  },
  methods: {
    createItem() {
      this.busy = true;
      stock
        .createOne({ name: this.name, description: this.description })
        .then(this.getAllItems);
    },

    borrowItem(id) {
      this.busy = true;
      stock.borrowItem(id).then(this.getAllItems);
    },
    unborrowItem(id) {
      this.busy = true;
      stock.unborrowItem(id).then(this.getAllItems);
    },
    isAvailable(item) {
      return !item.borrower || item.borrower == "";
    },
    getAllItems() {
      stock.getAllItems().then((items) => {
        console.log(items);
        this.items = items;
        this.busy = false;
      });
    },
  },
};
</script>
