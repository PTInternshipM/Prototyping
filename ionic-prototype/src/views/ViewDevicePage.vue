<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar mode="ios">
        <ion-buttons slot="start">
          <ion-back-button :text="getBackButtonText()" default-href="/"></ion-back-button>
        </ion-buttons>
        <ion-title>Details</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" v-if="device">
      <div class="ion-padding">
        <h1>{{ device.name }}</h1>
      </div>
      <ion-card>
        <ion-card-content>
          <ion-list>
            <ion-item>
<!--              <ion-icon name="menu-outline"></ion-icon>-->
              {{ device.id }}
            </ion-item>
            <ion-item>
<!--              <ion-icon name="battery-half-outline"></ion-icon>-->
              {{ device.batteryLevel }}
            </ion-item>
            <ion-item>
<!--              <ion-icon name="home-outline"></ion-icon>-->
              {{ device.manufacturer }}
            </ion-item>
          </ion-list>
        </ion-card-content>
      </ion-card>
    </ion-content>
  </ion-page>
</template>

<script lang="ts">
import {useRoute} from 'vue-router';
import {
  IonBackButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonTitle,
  IonList,
  IonItem,
  IonCard,
  IonCardContent,
  IonPage,
  IonToolbar
} from '@ionic/vue';
import {personCircle} from 'ionicons/icons';
import {getDevice} from '@/data/devices';
import {defineComponent} from 'vue';

export default defineComponent({
  name: 'ViewMessagePage',
  data() {
    return {
      personCircle,
      getBackButtonText: () => {
        const win = window as any;
        const mode = win && win.Ionic && win.Ionic.mode;
        return mode === 'ios' ? 'Inbox' : '';
      }
    }
  },
  setup() {
    const route = useRoute();
    const device = getDevice(parseInt(route.params.id as string, 10));

    return {device}
  },
  components: {
    IonBackButton,
    IonButtons,
    IonContent,
    IonHeader,
    IonTitle,
    IonPage,
    IonToolbar,
    IonList,
    IonItem,
    IonCard,
    IonCardContent
  },
});
</script>

<style scoped>
ion-item {
  --inner-padding-end: 0;
  --background: transparent;
}

ion-label {
  margin-top: 12px;
  margin-bottom: 12px;
}

ion-item h2 {
  font-weight: 600;
}

ion-item .date {
  float: right;
  align-items: center;
  display: flex;
}

ion-item ion-icon {
  font-size: 42px;
  margin-right: 8px;
}

ion-item ion-note {
  font-size: 15px;
  margin-right: 12px;
  font-weight: normal;
}

h1 {
  margin: 0;
  font-weight: bold;
  font-size: 22px;
}

p {
  line-height: 22px;
}
</style>
