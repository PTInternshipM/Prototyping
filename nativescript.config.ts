import { NativeScriptConfig } from '@nativescript/core';

export default {
  id: 'com.organization.nativeScriptPrototype',
  appPath: 'app',
  appResourcesPath: 'App_Resources',
  android: {
    v8Flags: '--expose_gc',
    markingMode: 'none'
  },
  ios: {
    id: 'com.organization.nativeScriptPrototype'
  }
} as NativeScriptConfig;
