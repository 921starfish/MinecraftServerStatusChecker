using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Util;
using Android.Views;
using Android.Widget;

namespace MSSC.Droid
{
    public class Class1 : Android.Views.View
    {
        // 下記二つのコンストラクタが必要
        public Class1(Context context, IAttributeSet attrs) :
          base(context, attrs)
        {
        }

        public Class1(Context context, IAttributeSet attrs, int defStyle) :
          base(context, attrs, defStyle)
        {

        }

        
    }
}