<template>
  <v-navigation-drawer class="pink darken-1" dark app>
    <v-list>
      <router-link
        style="text-decoration: none;"
        v-for="item in items"
        :key="item.title"
        :to="item.link"
      >
        <v-list-item link>
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </router-link>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data() {
    return {
      items: [
        { title: "Home", icon: "mdi-home", link: "/" },
        { title: "Copro", icon: "mdi-account-edit", link: "copro" },
      ],
    };
  },
};
</script>
