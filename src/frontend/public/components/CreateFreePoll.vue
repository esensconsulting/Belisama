<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-container>
      <v-row>
        <v-col cols="12" md="12">
          <v-text-field
            v-model="proposal"
            :counter="255"
            :rules="proposalRules"
            label="Proposal"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field
            v-model="reply1"
            :counter="75"
            label="Reply one"
            :rules="replyRules"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field
            v-model="reply2"
            :counter="75"
            label="Reply two"
            :rules="replyRules"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="12">
          <v-btn
            class="ma-2 "
            style="float: right;"
            outlined
            :loading="loading"
            color="pink"
            v-on:click="CreatePoll"
          >
            Submite Proposal
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
      proposal: "",
      reply1: "",
      reply2: "",
      valid: true,
      proposalRules: [(v) => !!v || "proposal is required"],
      replyRules: [(v) => !!v || "reply is required"],
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
          .addProposal({ description: this.reply1, pollId: data.ok })
          .then((_) => {
            belisama
              .addProposal({ description: this.reply2, pollId: data.ok })
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
