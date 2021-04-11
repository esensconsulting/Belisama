<template>
  <v-sheet>
    <v-sparkline
      :fill="fill"
      :gradient="gradient"
      :line-width="width"
      :padding="padding"
      :smooth="radius || false"
      :value="value"
      color="#dd1173"
      auto-draw
    >
      <template v-slot:label="item"> {{ item.value }}€ </template>
    </v-sparkline>
  </v-sheet>
</template>

<script>
const gradients = [
  ["#222"],
  ["#42b3f4"],
  ["red", "orange", "yellow"],
  ["purple", "violet"],
  ["#00c6ff", "#F0F", "#FF0"],
  ["#f72047", "#ffd200", "#1feaea"],
];

export default {
  components: {},
  data: () => ({
    value: [200, 325, 485, 555, 269, 225, 425, 596],
    fill: true,
    gradient: ["#350e47", "#dd1173"],
    padding: 15,
    radius: 5,
    width: 1,
  }),
};
</script>
