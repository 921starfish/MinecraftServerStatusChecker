using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;

namespace MSSC.Droid
{
    [Activity(Label = "ServerInformationActivity")]
    public class ServerInformationActivity : Activity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);

            // Set our view from the "ServerInformation" layout resource
            SetContentView(Resource.Layout.ServerInformation);

            // Create your application here
        }
    }
}