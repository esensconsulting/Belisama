<style>
.borrow {
  background-color: lightcoral;
}
.unborrow {
  background-color: lightgreen;
}
</style>

<template>
  <v-container>
    <v-row>
      <v-form ref="form" @submit.prevent="createCopro">
        <v-container>
          <v-row>
            <v-col cols="12" md="4">
              <v-text-field v-model="address" label="address" required></v-text-field>
            </v-col>
            <v-col cols="12" md="4">
              <v-btn type="submit" color="primary" :disabled="busy">
                Ajouter
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </v-row>
    <v-row>
      <v-data-table
        ref="copro-table"
        :items="items"
        :headers="headers"
        item-key="name"
        :items-per-page="20"
        :loading="busy"
        loading-text="Chargement de l'historique en cours..."
        sort-by="coproId"
      >
        <template v-slot:item.begin="{ item }">
          <span>{{ formatDate(item.begin) }}</span>
        </template>
        <template v-slot:item.end="{ item }">
          <span>{{ formatDate(item.end) }}</span>
        </template>
      </v-data-table>
    </v-row>
  </v-container>
</template>

<script>
import belisama from "ic:canisters/belisama";

export default {
  data: () => {
    return {
      items: [],
      headers: [
        { text: "Id", value: "coproId" },
        { text: "Address", value: "address" },
      ],
      address: "",
      busy: false,
    };
  },
  created() {},
  mounted() {
    this.recursiveGetAllItems();
  },
  methods: {
    createCopro() {
      this.busy = true;
      belisama.createCopro({ address: this.address }).then(this.getAllCopros);
    },
    recursiveGetAllItems() {
      this.busy = true;
      this.getAllCopros();
      setTimeout(() => this.recursiveGetAllItems(), 5000);
    },
    getAllCopros() {
      belisama.getAllCopros().then((items) => {
        console.log(items);
        this.items = items;
        this.busy = false;
      });
    },
  },
};
</script>
