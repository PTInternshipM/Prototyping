using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using xamarin_forms_prototype;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace xamarinformsprototype
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class InfoPage : ContentPage
    {
        public InfoPage(BTDevice btDevice)
        {
            this.Title = "Info";
            Label header = new Label
            {
                Text = btDevice.Name,
                FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Label)),
                HorizontalOptions = LayoutOptions.Center
            };
            
            // Build the page.
            Content = new StackLayout
            {
                Children =
                {
                    header,
                }
            };
        }
    }
}

