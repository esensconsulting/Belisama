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
          title: "Josette Gaudin",
          subtitle: "55€",
        },
        {
          title: "Josette Gaudin",
          subtitle: "20€",
        },
        {
          title: "Alice Leblanc",
          subtitle: "120€",
        },
        {
          title: "Diane Rey-Coulon",
          subtitle: "10€",
        },
        {
          title: "Diane Rey-Coulon",
          subtitle: "25€",
        },
        {
          title: "Théodore du Barbier",
          subtitle: "12€",
        },
        {
          title: "Aurore Marion",
          subtitle: "36€",
        },
        {
          title: "Bruce Wayne",
          subtitle: "5225€",
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
