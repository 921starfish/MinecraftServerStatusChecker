using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Codeplex.Data;
using Newtonsoft.Json;

namespace MSSC
{
    class MinecraftClient
    {
        private TcpClient client = new TcpClient();
        private List<byte> _buffer;
        private NetworkStream _stream;
        private int _offset;
        public string Url { get; set; }

        public MinecraftClient(string url)
        {
            Url = url;
        }

        public MinecraftClient()
        {
            Url = "localhost";
        }

        public bool Connect()
        {
            var task = client.ConnectAsync(Url, 25565);
            while (!task.IsCompleted)
            {
                Thread.Sleep(250);
            }
            return client.Connected;
        }

        public dynamic GetStatus()
        {
            _buffer = new List<byte>();
            _stream = client.GetStream();
            WriteVarInt(47);
            WriteString(Url);
            WriteShort(25565);
            WriteVarInt(1);
            Flush(0);
            Flush(0);
            var buffer = new byte[4096*2];
            _stream.Read(buffer, 0, buffer.Length);
            var jsonLength = ReadVarInt(buffer);
            var res = ReadString(buffer, jsonLength);
            while (res[0] != '{')
            {
               res = res.Remove(0,1);
            }
            return DynamicJson.Parse(res);
        }

        internal byte ReadByte(byte[] buffer)
        {
            var b = buffer[_offset];
            _offset += 1;
            return b;
        }

        internal byte[] Read(byte[] buffer, int length)
        {
            var data = new byte[length];
            Array.Copy(buffer, _offset, data, 0, length);
            _offset += length;
            return data;
        }

        internal int ReadVarInt(byte[] buffer)
        {
            var value = 0;
            var size = 0;
            int b;
            while (((b = ReadByte(buffer)) & 0x80) == 0x80)
            {
                value |= (b & 0x7F) << (size++ * 7);
                if (size > 5)
                {
                    throw new IOException("This VarInt is an imposter!");
                }
            }
            return value | ((b & 0x7F) << (size * 7));
        }

        internal string ReadString(byte[] buffer, int length)
        {
            var data = Read(buffer, length);
            return Encoding.UTF8.GetString(data);
        }

        internal void WriteVarInt(int value)
        {
            while ((value & 128) != 0)
            {
                _buffer.Add((byte)(value & 127 | 128));
                value = (int)((uint)value) >> 7;
            }
            _buffer.Add((byte)value);
        }

        internal void WriteShort(short value)
        {
            _buffer.AddRange(BitConverter.GetBytes(value));
        }

        internal void WriteString(string data)
        {
            var buffer = Encoding.UTF8.GetBytes(data);
            WriteVarInt(buffer.Length);
            _buffer.AddRange(buffer);
        }

        internal void Write(byte b)
        {
            _stream.WriteByte(b);
        }

        internal void Flush(int id = -1)
        {
            var buffer = _buffer.ToArray();
            _buffer.Clear();

            var add = 0;
            var packetData = new[] { (byte)0x00 };
            if (id >= 0)
            {
                WriteVarInt(id);
                packetData = _buffer.ToArray();
                add = packetData.Length;
                _buffer.Clear();
            }

            WriteVarInt(buffer.Length + add);
            var bufferLength = _buffer.ToArray();
            _buffer.Clear();

            _stream.Write(bufferLength, 0, bufferLength.Length);
            _stream.Write(packetData, 0, packetData.Length);
            _stream.Write(buffer, 0, buffer.Length);
        }
    }
}
