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
          <h1>Decision making</h1>
          <v-container>
            <h3>
              Here you can vote or propose various things for the condominium
            </h3>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border">Proposal</v-card-title>
          <v-container>
            <v-card-text><Poll :event="event" /> </v-card-text>
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border"
            >Create a proposal (Yes/No)</v-card-title
          >
          <v-container>
            <CreatePoll @created="onCreated" />
          </v-container>
        </v-card>
      </v-col>
      <v-col cols="12" md="12">
        <v-card elevation="1" outlined shaped class="mx-auto">
          <v-card-title class="bottom-border"
            >Create a proposal (free field)</v-card-title
          >
          <v-container> <CreateFreePoll @created="onCreated" /> </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Poll from "../components/Poll.vue";
import CreatePoll from "../components/CreatePoll.vue";
import CreateFreePoll from "../components/CreateFreePoll.vue";

export default {
  components: {
    Poll,
    CreatePoll,
    CreateFreePoll,
  },
  data: () => {
    return {
      event: {},
      proposals: [0, 0],
    };
  },
  created() {},
  methods: {
    onCreated: function(data) {
      this.event = data;
    },
  },
};
</script>
