/**
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  FlatList,
  Button,
  SafeAreaView,
  StatusBar,
  StyleSheet,
  useColorScheme,
  View,
} from 'react-native';

import {Colors} from 'react-native/Libraries/NewAppScreen';

const Devices = [
  {
    id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
    name: 'BLEDevice1',
    batteryLevel: 34,
    manufacturer: 'Company A',
  },
  {
    id: 'bd7acbea-c1b1-46c2-aed5-asd',
    name: 'BLEDevice2',
    batteryLevel: 97,
    manufacturer: 'Company B',
  },
  {
    id: 'bd7acbea-c1b1-46c2-aed5-ds',
    name: 'BLEDevice3',
    batteryLevel: 64,
    manufacturer: 'Company C',
  },
  {
    id: 'bd7acbea-c1b1-46c2-aed5-er',
    name: 'BLEDevice4',
    batteryLevel: 12,
    manufacturer: 'Company D',
  },
];

const DeviceListView = ({navigation}) => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const onClick = item => {
    navigation.navigate('Detail', {device: item});
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <FlatList
        data={Devices}
        renderItem={({item}) => {
          return (
            <View style={styles.item}>
              <Button onClick={() => onClick(item)} title={item.name}></Button>
            </View>
          );
        }}
        keyExtractor={item => item.id}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight || 0,
  },
  item: {
    backgroundColor: '#f9c2ff',
    padding: 20,
    marginVertical: 8,
    marginHorizontal: 16,
  },
  title: {
    fontSize: 32,
  },
});

export default DeviceListView;
