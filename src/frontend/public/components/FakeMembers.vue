<template>
  <v-list>
    <v-list-item v-for="(item, index) in items" :key="index">
      <v-list-item-content>
        <v-list-item-title v-text="item"></v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
export default {
  components: {},
  data: () => {
    return {
      items: [
        "Chantal Noel",
        "Aurore Marion",
        "Théodore du Barbier",
        "Thomas Gosselin",
        "Émilie Le Fleury",
        "Cécile-Maryse Bourgeois",
        "Diane Rey-Coulon",
        "Gilbert Deschamps",
        "Alice Leblanc",
        "Josette Gaudin",
        "Brigitte-Zoé Rousseau",
        "Édouard Barre",
        "Gérard Laine",
      ],
    };
  },
  created() {
    this.items = this.shuffle(this.items);
    this.items = this.items.slice(0, 5);
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
