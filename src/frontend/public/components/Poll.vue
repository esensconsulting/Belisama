<template>
  <div>
    <v-list-item v-for="(pool, index) in pools" :key="index">
      <v-list-item-content>
        <v-list-item-title v-text="pool.description"></v-list-item-title>
      </v-list-item-content>

      <v-list-item-icon
        v-for="(proposal, pindex) in pool.proposals"
        :key="index + '/' + pindex"
      >
        <v-btn
          :disabled="alreadyvoted(pool)"
          elevation="2"
          outlined
          :loading="loading && indexClicked === index + '/' + pindex"
          color="pink"
          v-on:click="vote(proposal, index + '/' + pindex)"
          >{{ proposal.description }}({{ proposal.voteCount }})</v-btn
        >
      </v-list-item-icon>
    </v-list-item>
  </div>
</template>

<script>
import belisama from "ic:canisters/belisama";

export default {
  components: {},
  props: ["event"],
  data: () => {
    return {
      pools: [],
      principal: "",
      loading: false,
      indexClicked: undefined,
    };
  },
  created() {
    this.getPolls();
  },
  watch: {
    event: function(value) {
      console.log("parent event");
      console.log(value);
      this.getPolls();
    },
  },
  methods: {
    vote: function(proposal, index) {
      this.indexClicked = index;
      this.loading = true;
      belisama.vote(proposal.proposalId).then((data) => {
        console.log(data);
        this.getPolls();
      });
    },
    getPolls: function() {
      belisama.callerPrincipal().then((principal) => {
        this.principal = principal;
        belisama.getMyPolls().then((data) => {
          this.loading = false;
          this.pools = data;
        });
      });
    },
    alreadyvoted: function(pool) {
      for (let voter of pool.voters) {
        if (voter == this.principal) return true;
      }
      return false;
    },
  },
};
</script>
