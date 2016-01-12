using System;
using System.Net.Mime;
using Xamarin.Forms;

namespace MSSC
{
    public class App : Application
    {
        public App()
        {
            //var client = new MinecraftClient();
            //client.Connect();
            //MinecraftStatus json = client.GetStatus();
            // The root page of your application

            MainPage = new MainPage();

            //MainPage = new ContentPage
            //{
            //     Content = new StackLayout
            //    {
            //        VerticalOptions = LayoutOptions.Center,
            //        Children = {
            //            new Label {
            //                XAlign = TextAlignment.Center,
            //                Text = json.version.name
            //            }
            //        }
            //    }
            //};
        }

        protected override void OnStart()
        {
            // Handle when your app starts
        }

        protected override void OnSleep()
        {
            // Handle when your app sleeps
        }

        protected override void OnResume()
        {
            // Handle when your app resumes
        }
    }
}

