<template>
  <Page>
    <ActionBar>
      <Label text="Devices"></Label>
    </ActionBar>

    <WrapLayout orientation="horizontal">
      <ListView for="item in items" @itemTap="$navigateTo(detailPage)" height="80%" width="100%">
        <v-template>
          <StackLayout orientation="vertical">
            <Label :text="item.name" textWrap="true"></Label>
          </StackLayout>
        </v-template>
      </ListView>
      <Button class="my-button" text="Scan" @tap="scan" width="90%" />
    </WrapLayout>
  </Page>
</template>

<script lang="ts">
import Vue from "nativescript-vue";
import {getDevices} from "~/models/Device"
import Detail from "~/components/Detail.vue"

export default Vue.extend({
  computed: {},
  data() {
    return {
      items: getDevices(),
      detailPage: Detail
    }
  },
  methods: {
    scan: (ev: CustomEvent) => {
      console.log('Scanning...')
      setTimeout(() => {
        console.log('Scanning done')
      }, 3000);
    }
  },
});
</script>

<style scoped lang="scss">
@import '@nativescript/theme/scss/variables/blue';

.my-button {
  background-color: #7b7bff;
  color: #ffffff;
}
</style>
