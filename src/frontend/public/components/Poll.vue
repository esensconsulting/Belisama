<template>
  <div>
    <v-list-item v-for="(pool, index) in pools" :key="index">
      <v-list-item-content>
        <v-list-item-title v-text="pool.description"></v-list-item-title>
      </v-list-item-content>

      <v-list-item-icon
        v-for="(proposal, pindex) in pool.proposals"
        :key="pindex"
      >
        <v-btn
          :disabled="alreadyvoted(pool)"
          elevation="2"
          outlined
          :loading="loading"
          color="pink"
          v-on:click="vote(proposal)"
          >{{ proposal.description }}({{ proposal.voteCount }})</v-btn
        >
      </v-list-item-icon>
    </v-list-item>
  </div>
</template>

<script>
import frontend from "ic:canisters/frontend";
import belisama from "ic:canisters/belisama";

export default {
  components: {},
  data: () => {
    return {
      pools: [],
      principal: "",
      loading: false,
    };
  },
  created() {
    this.getPolls();
  },
  methods: {
    vote: function(proposal) {
      this.loading = true;
      console.log(proposal);
      belisama.vote(proposal.proposalId).then((data) => {
        this.getPolls();
      });
    },
    getPolls: function() {
      belisama.callerPrincipal().then((principal) => {
        this.principal = principal;
        belisama.getMyPolls().then((data) => {
          console.log(data);
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
