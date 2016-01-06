using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MSSCforConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            //サーバーのIPアドレス（または、ホスト名）とポート番号
            const string ipOrHost = "40.76.27.52";
            //string ipOrHost = "localhost";
            const int port = 25565;

            //TcpClientを作成し、サーバーと接続する
            System.Net.Sockets.TcpClient tcp = new System.Net.Sockets.TcpClient(ipOrHost, port);
            Console.WriteLine("サーバー({0}:{1})と接続しました({2}:{3})。",
                ((System.Net.IPEndPoint)tcp.Client.RemoteEndPoint).Address,
                ((System.Net.IPEndPoint)tcp.Client.RemoteEndPoint).Port,
                ((System.Net.IPEndPoint)tcp.Client.LocalEndPoint).Address,
                ((System.Net.IPEndPoint)tcp.Client.LocalEndPoint).Port);

            //NetworkStreamを取得する
            System.Net.Sockets.NetworkStream ns = tcp.GetStream();
            try
            {
                //読み取り、書き込みのタイムアウトを10秒にする
                //デフォルトはInfiniteで、タイムアウトしない
                //(.NET Framework 2.0以上が必要)
                ns.ReadTimeout = 10000;
                ns.WriteTimeout = 10000;

                //サーバーに送信するデータ
                byte[] num1 = BitConverter.GetBytes((char)ipOrHost.Length);
                if (BitConverter.IsLittleEndian)
                {
                    Array.Reverse(num1);
                }

                byte[] num2 = BitConverter.GetBytes((Int16)port);
                if (BitConverter.IsLittleEndian)
                {
                    Array.Reverse(num2);
                }

                string data = "\x00"; // packet ID = 0 (varint)
                data += "\x04"; // Protocol version (varint)
                data += Encoding.UTF8.GetString(num1) + ipOrHost; // Server (varint len + UTF-8 addr)
                data += Encoding.UTF8.GetString(num2); // Server port (unsigned short)
                data += "\x01"; // Next state: status (varint)  

                byte[] num3 = BitConverter.GetBytes((char)data.Length);
                if (BitConverter.IsLittleEndian)
                {
                    Array.Reverse(num3);
                }

                data = Encoding.UTF8.GetString(num3) + data; // prepend length of packet ID + data

                // ↑ここでphpのpackの部分を適当に変換しているけれど、たぶんそのせいで動かない

                Console.WriteLine(data);

                //サーバーにデータを送信する
                //文字列をByte型配列に変換
                System.Text.Encoding enc = System.Text.Encoding.UTF8;
                byte[] sendBytes = enc.GetBytes(data);
                //データを送信する
                ns.Write(sendBytes, 0, sendBytes.Length);// handshake

                //文字列をByte型配列に変換
                byte[] sendBytes2 = enc.GetBytes("\x01\x00");
                //データを送信する
                ns.Write(sendBytes2, 0, sendBytes2.Length);// status ping

                //サーバーから送られたデータを受信する
                System.IO.MemoryStream ms = new System.IO.MemoryStream();
                byte[] resBytes = new byte[256];
                int resSize = 0;
                do
                {
                    //データの一部を受信する
                    resSize = ns.Read(resBytes, 0, resBytes.Length);
                    //Readが0を返した時はサーバーが切断したと判断
                    if (resSize == 0)
                    {
                        Console.WriteLine("サーバーが切断しました。");
                        break;
                    }
                    //受信したデータを蓄積する
                    ms.Write(resBytes, 0, resSize);
                    //まだ読み取れるデータがあるか、データの最後が\nでない時は、
                    //受信を続ける
                } while (ns.DataAvailable/*|| resBytes[resSize - 1] != '\n'*/);
                //受信したデータを文字列に変換
                string resMsg = enc.GetString(ms.GetBuffer(), 0, (int)ms.Length);
                ms.Close();
                Console.WriteLine(resMsg);
                //JSONのデコード
                string result = (string)System.Web.Helpers.Json.Decode(resMsg);

                //末尾の\nを削除
                //resMsg = resMsg.TrimEnd('\n');
                Console.WriteLine(result);
            }
            catch (Exception e)
            {
                Debug.WriteLine("何らかの例外がありました。" + e);
            }
            finally
            {
                //閉じる
                ns.Close();
                tcp.Close();
                Console.WriteLine("切断しました。");

                // Console.ReadLine();
            }
        }
    }
}
