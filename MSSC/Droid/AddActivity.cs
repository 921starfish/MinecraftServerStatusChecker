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
    [Activity(Label = "AddActivity")]
    public class AddActivity : Activity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);

            // Set our view from the "Add" layout resource
            SetContentView(Resource.Layout.Add);

            Button doneButton = FindViewById<Button>(Resource.Id.doneButton);
            doneButton.Click += DoneButton_Click;
        }

        private void DoneButton_Click(object sender, EventArgs e)
        {
            var name1 = FindViewById<EditText>(Resource.Id.name1);
            var address1 = FindViewById<EditText>(Resource.Id.address1);
            var port1 = FindViewById<EditText>(Resource.Id.port1);

            var serverData = new ServerData(name1.Text, address1.Text, port1.Text);

            var intent = new Intent(this, typeof(MainActivity));
            intent.PutExtra("data", serverData);
            StartActivity(intent);
        }
    }
}