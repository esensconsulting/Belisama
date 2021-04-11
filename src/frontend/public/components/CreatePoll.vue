<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-container>
      <v-row>
        <v-col cols="12" md="9">
          <v-text-field
            v-model="proposal"
            :counter="255"
            :rules="proposalRules"
            label="Proposal"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="2">
          <v-btn
            class="ma-2"
            outlined
            :loading="loading"
            v-on:click="CreatePoll"
            color="pink"
          >
            Submit Proposal
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
import belisama from "ic:canisters/belisama";

export default {
  components: {},
  data: () => {
    return {
      valid: true,
      proposalRules: [(v) => !!v || "proposal is required"],
      proposal: "",
      loading: false,
    };
  },
  created() {},
  methods: {
    CreatePoll: function() {
      this.loading = true;
      if (!this.$refs.form.validate()) {
        this.loading = false;
        return;
      }
      belisama.createPoll({ description: this.proposal }).then((data) => {
        belisama
          .addProposal({ description: "Yes", pollId: data.ok })
          .then((_) => {
            belisama
              .addProposal({ description: "No", pollId: data.ok })
              .then((_) => {
                console.log(data);
                this.loading = false;
                this.$refs.form.reset();
                this.$emit("created", data);
              });
          });
      });
    },
  },
};
</script>
