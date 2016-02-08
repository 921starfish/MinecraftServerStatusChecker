using System;
using System.Collections.Generic;
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
        private ServerDataList _myList;
        private GridLayout[] _gridLayouts;
        private ImageView[] _imageViews;
        private TextView[] _textViews;

        protected override void OnCreate(Bundle bundle)
        {

            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView(Resource.Layout.Main);

            Button plusButton = FindViewById<Button>(Resource.Id.PlusButton);

            plusButton.Click += plusButton_Click;

        }

        protected override void OnResume()
        {
            base.OnResume();

            _myList = ServerDataList.GetInstance();
   
            // Addから戻ってきたときに追加する操作
            var intent = this.Intent;
            if (intent != null && intent.HasExtra("data"))
            {
                var serverData = intent.GetParcelableExtra("data") as ServerData;
                _myList.ServerDatas.Add(serverData);
            }

            int a = _myList.ServerDatas.Count;
            _gridLayouts = new GridLayout[a];
            _imageViews = new ImageView[a];
            _textViews = new TextView[a];

            LinearLayout linearLayout1 = FindViewById<LinearLayout>(Resource.Id.linearLayout1);

            for (int i = 0; i < a; i++)
            {
                _gridLayouts[i] = new GridLayout(this);

                _imageViews[i] = new ImageView(this);
                _imageViews[i].SetImageResource(Resource.Drawable.icon);
                _gridLayouts[i].AddView(_imageViews[i]);

                _textViews[i] = new TextView(this);
                _textViews[i].Text = _myList.ServerDatas[i].Name;
                _textViews[i].SetTextAppearance(10);
                _textViews[i].Gravity = GravityFlags.Fill;
                _gridLayouts[i].AddView(_textViews[i]);

                linearLayout1.AddView(_gridLayouts[i]);
            }

        }

        private void plusButton_Click(object sender, EventArgs e)
        {
            var intent = new Intent(this, typeof(AddActivity));
            StartActivity(intent);
        }
    }
}

