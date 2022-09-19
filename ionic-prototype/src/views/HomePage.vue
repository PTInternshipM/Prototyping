<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar mode="ios">
        <ion-title>Devices</ion-title>
      </ion-toolbar>
    </ion-header>
    
    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ionRefresh="refresh($event)">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>
      
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Devices</ion-title>
        </ion-toolbar>
      </ion-header>
      
      <ion-list>
        <DeviceListItem v-for="device in devices" :key="device.id" :device="device" />
      </ion-list>
    </ion-content>

    <ion-footer>
      <ion-button @click="scan" expand="block" mode="ios">Scan</ion-button>
    </ion-footer>
  </ion-page>
</template>

<script lang="ts">
import { IonContent, IonHeader, IonList, IonPage, IonRefresher, IonRefresherContent, IonTitle, IonToolbar, IonFooter, IonButton } from '@ionic/vue';
import DeviceListItem from '@/components/DeviceListItem.vue';
import { defineComponent } from 'vue';
import {getDevices} from "@/data/devices";

export default defineComponent({
  name: 'HomePage',
  data() {
    return {
      devices: getDevices()
    }
  },
  methods: {
    refresh: (ev: CustomEvent) => {
      setTimeout(() => {
        ev.detail.complete();
      }, 3000);
    },
    scan: (ev: CustomEvent) => {
      console.log('Scanning...')
      setTimeout(() => {
        ev.detail.complete();
      }, 3000);
    }
  },
  components: {
    IonContent,
    IonHeader,
    IonFooter,
    IonButton,
    IonList,
    IonPage,
    IonRefresher,
    IonRefresherContent,
    IonTitle,
    IonToolbar,
    DeviceListItem
  },
});
</script>
