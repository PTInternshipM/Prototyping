<template>
  <ion-item v-if="device" :routerLink="'/device/' + device.id" :detail="false" class="list-item" mode="ios">
    <div slot="start"></div>
    <ion-label class="ion-text-wrap">
      <h2>
        {{ device.name }}
        <span class="trash-icon">
          <ion-icon :icon="trashBin" size="small"></ion-icon>
        </span>
      </h2>
    </ion-label>
  </ion-item>
</template>

<script lang="ts">
import { IonIcon, IonItem, IonLabel } from '@ionic/vue';
import { trashBin } from 'ionicons/icons';
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'DeviceListItem',
  components: {
    IonIcon,
    IonItem,
    IonLabel
  },
  props: {
    device: Object,
  },
  methods: {
    isIos: () => {
      const win = window as any;
      return win && win.Ionic && win.Ionic.mode === 'ios';
    }
  },
  data() {
    return { trashBin }
  }
});
</script>

<style scoped>
.list-item {
  --padding-start: 0;
  --inner-padding-end: 0;
}

.list-item ion-label {
  margin-top: 12px;
  margin-bottom: 12px;
}

.list-item  h2 {
  font-weight: 600;
  margin: 0;
}

.list-item p {
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
  width: 95%;
}

.list-item .trash-icon {
  float: right;
  align-items: center;
  display: flex;
}

.list-item ion-icon {
  color: #c9c9ca;
}

.list-item ion-note {
  font-size: 15px;
  margin-right: 8px;
  font-weight: normal;
}

</style>