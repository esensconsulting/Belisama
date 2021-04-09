<template>
  <div>
    <template v-for="(item, index) in items">
      <v-list-item three-line :key="item.title">
        <v-list-item-content>
          <v-list-item-title v-html="item.title"></v-list-item-title>
          <v-list-item-subtitle v-html="item.subtitle"></v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider :key="index" />
    </template>
  </div>
</template>

<script>
export default {
  components: {},
  data: () => {
    return {
      items: [
        {
          title: "New regulations",
          subtitle:
            "It is now forbidden to take out your trash on Monday evening",
        },
        {
          title: "Change of lights",
          subtitle:
            "The lights in the entrance hall will be changed within 3 days",
        },
        {
          title: "Elevator renovation",
          subtitle: "A renovation of assessors is being negotiated",
        },
        {
          title: "Neighbor party",
          subtitle:
            "A neighbors party will take place within a week in apartment 302",
        },
        {
          title: "Recycling party",
          subtitle: "A recycling festival is organized every month",
        },
        {
          title: "Orphan child fundraiser",
          subtitle:
            "A fundraiser for orphaned children has been organized, a letter box is at your disposal",
        },
        {
          title: "Changing wallpaper",
          subtitle:
            "A company has been commissioned to change the wallpaper in the hallways",
        },
        {
          title: "Renovation of the portal",
          subtitle:
            "The renovation of the south-south-east facing portal will begin on Tuesday morning",
        },
      ],
    };
  },
  created() {
    this.items = this.shuffle(this.items);
    this.items = this.items.slice(0, 3);
  },
  methods: {
    shuffle: function(array) {
      var currentIndex = array.length,
        temporaryValue,
        randomIndex;

      // While there remain elements to shuffle...
      while (0 !== currentIndex) {
        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
      }
      return array;
    },
  },
};
</script>
