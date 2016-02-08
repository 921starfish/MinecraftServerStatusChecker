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
    public class ServerDataList
    {
        public List<ServerData> ServerDatas;

        private static ServerDataList _singleInstance = new ServerDataList();

        public static ServerDataList GetInstance()
        {
            return _singleInstance;
        }

        private ServerDataList()
        {
            //TODO :デシリアライズ処理に書き換える
            ServerDatas = new List<ServerData> {new ServerData("サーバー名", "ArLEWorks.sytes.net", "25565")};
        }
    }
}