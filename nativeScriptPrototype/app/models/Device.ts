export interface Device {
  id: number,
  name: string,
  batteryLevel: number,
  manufacturer: string
}

const devices: Device[] = [
  {
    id: 0,
    name: "BLEDevice1",
    batteryLevel: 65,
    manufacturer: "Company A"
  },
  {
    id: 1,
    name: "BLEDevice2",
    batteryLevel: 23,
    manufacturer: "Company B"
  },
  {
    id: 2,
    name: "BLEDevice3",
    batteryLevel: 87,
    manufacturer: "Company C"
  },
  {
    id: 3,
    name: "BLEDevice4",
    batteryLevel: 50,
    manufacturer: "Company D"
  },
];

export const getDevices = () => devices;

