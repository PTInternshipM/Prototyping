using System.Collections.ObjectModel;
using Device = mauiPrototype.Models.Device;

namespace mauiPrototype;

public partial class MainPage : ContentPage
{
	private readonly ObservableCollection<Device> _devices = new ObservableCollection<Device>
	{
		new Device(Guid.NewGuid(), "BLEDevice1", "Company A", 12),
		new Device(Guid.NewGuid(), "BLEDevice2", "Company B", 35),
		new Device(Guid.NewGuid(), "BLEDevice3", "Company C", 76),
		new Device(Guid.NewGuid(), "BLEDevice4", "Company D", 99)
	};

	public ObservableCollection<Device> Devices => _devices;

	public MainPage()
	{
		InitializeComponent();
		DeviceListView.ItemsSource = _devices;
	}

	private void OnScanButtonClicked(object sender, EventArgs e)
	{
		Console.WriteLine("Scanning...");
	}

	private void OnItemSelected(Object sender, EventArgs e)
	{
		Navigation.PushAsync(new DevicePage
		{
			BindingContext = DeviceListView.SelectedItem
		});
	}
}


