using System;
using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

namespace MSSC.Droid
{
    [Activity(Label = "MSSC.Droid", MainLauncher = true, Icon = "@drawable/icon")]
    public class MainActivity : Activity
    {
        int count = 1;

        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView(Resource.Layout.Main);

            LinearLayout linearLayout1 = FindViewById<LinearLayout>(Resource.Id.linearLayout1);

            GridLayout gridLayout1 = new GridLayout(this);

            Space space1 = new Space(this);
            space1.SetMinimumWidth(25);
            gridLayout1.AddView(space1);

            ImageView imageView1 = new ImageView(this);
            imageView1.SetImageResource(Resource.Drawable.icon);
            gridLayout1.AddView(imageView1);

            TextView textView1 = new TextView(this);
            textView1.Text = "Server Name";
            textView1.SetTextAppearance(10);
            textView1.Gravity = GravityFlags.Fill;
            gridLayout1.AddView(textView1);

            ImageView imageView2 = new ImageView(this);
            imageView2.SetImageResource(Resource.Drawable.denpa);
            gridLayout1.AddView(imageView2);

            Space space2 = new Space(this);
            space1.SetMinimumWidth(25);
            gridLayout1.AddView(space2);

            linearLayout1.AddView(gridLayout1);


            // Get our button from the layout resource,
            // and attach an event to it
            Button button = FindViewById<Button>(Resource.Id.MyButton);

            button.Click += delegate { button.Text = string.Format("{0} clicks!", count++); };

            Button plusButton = FindViewById<Button>(Resource.Id.PlusButton);

            plusButton.Click += plusButton_Click;

        }

        private void plusButton_Click(object sender, EventArgs e)
        {
            var intent = new Intent(this, typeof(AddActivity));
            StartActivity(intent);
        }
    }
}

