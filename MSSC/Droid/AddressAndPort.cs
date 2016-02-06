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
using Java.Interop;

namespace MSSC.Droid
{
    public class AddressAndPort : Java.Lang.Object, IParcelable
    {
        public string Address { get; private set; }
        public string Port { get; private set; }

        public AddressAndPort(string address, string port)
        {
            this.Address = address;
            this.Port = port;
        }

        #region IParcelable implementation

        public int DescribeContents()
        {
            return 0;
        }

        public void WriteToParcel(Parcel dest, ParcelableWriteFlags flags)
        {
            dest.WriteString(this.Address);
            dest.WriteString(this.Port);
        }

        #endregion

        // public static final Parcelable.Creator ‚Ì‘ã‚í‚è
        [ExportField("CREATOR")]
        public static IParcelableCreator GetCreator()
        {
            return new CardParcelableCreator();
        }

        class CardParcelableCreator : Java.Lang.Object, IParcelableCreator
        {
            Java.Lang.Object IParcelableCreator.CreateFromParcel(Parcel source)
            {
                var address = source.ReadString();
                var age = source.ReadString();

                return new AddressAndPort(address, age);
            }

            Java.Lang.Object[] IParcelableCreator.NewArray(int size)
            {
                return new Java.Lang.Object[size];
            }
        }
    }
}