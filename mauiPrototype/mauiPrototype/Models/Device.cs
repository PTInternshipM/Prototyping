using System;
namespace mauiPrototype.Models;

public class Device
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public int BatteryLevel { get; set; }
    public string Manufacturer { get; set; }

    public Device(Guid id, string name, string manufacturer, int batteryLevel)
    {
        Id = id;
        Name = name;
        Manufacturer = manufacturer;
        BatteryLevel = batteryLevel;
    }
}
