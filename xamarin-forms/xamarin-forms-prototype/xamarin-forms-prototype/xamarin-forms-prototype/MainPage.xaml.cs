using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using xamarinformsprototype;

namespace xamarin_forms_prototype
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            // InitializeComponent();

            Label header = new Label
            {
                Text = "Devices",
                FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Label)),
                HorizontalOptions = LayoutOptions.Center
            };

            // Define some data.
            var devices = new List<BTDevice>
            {
                new BTDevice { Name = "Device A" },
                new BTDevice { Name = "Device B" },
                new BTDevice { Name = "Device C" },
                new BTDevice { Name = "Device D" },
            };

            // Create the ListView.
            ListView listView = new ListView
            {
                // Source of data items.
                ItemsSource = devices,

                // Define template for displaying each item.
                // (Argument of DataTemplate constructor is called for 
                //      each item; it must return a Cell derivative.)
                ItemTemplate = new DataTemplate(() =>
                    {
                        // Create views with bindings for displaying each property.
                        Label nameLabel = new Label();
                        nameLabel.SetBinding(Label.TextProperty, "Name");

                        // Return an assembled ViewCell.
                        var cell = new ViewCell
                        {
                            View = new StackLayout
                            {
                                Padding = new Thickness(0, 5),
                                Orientation = StackOrientation.Horizontal,
                                Children =
                                {
                                    new StackLayout
                                    {
                                        VerticalOptions = LayoutOptions.Center,
                                        Spacing = 0,
                                        Children =
                                        {
                                            nameLabel
                                        }
                                    }
                                }
                            }
                        };
                        return cell;
                    }
                )
            };

            listView.ItemTapped += HandleBTDeviceTapped;

            var scanButton = new Button
            {
                Text = "Scan",
                TextColor = Color.White,

                BackgroundColor = Color.DodgerBlue,
                VerticalOptions = LayoutOptions.CenterAndExpand,
                HorizontalOptions = LayoutOptions.Fill
            };

            // scanButton.Clicked += ShowInfoPage;

            // Accomodate iPhone status bar.
            Padding = new Thickness(10, Device.OnPlatform(20, 0, 0), 10, 5);

            // Build the page.
            Content = new StackLayout
            {
                Children =
                {
                    header,
                    listView,
                    scanButton
                }
            };
        }

        private async void HandleBTDeviceTapped(object sender, ItemTappedEventArgs e)
        {
            await Navigation.PushAsync(new InfoPage(((ListView)sender).SelectedItem as BTDevice));
        }
    }
}
