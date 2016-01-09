using System;
using System.Collections.Generic;
using System.Text;

namespace MSSC
{
    public class Players
    {
        public int max { get; set; }
        public int online { get; set; }
    }

    public class Version
    {
        public string name { get; set; }
        public int protocol { get; set; }
    }

    public class ModList
    {
        public string modid { get; set; }
        public string version { get; set; }
    }

    public class Modinfo
    {
        public string type { get; set; }
        public List<ModList> modList { get; set; }
    }

    public class MinecraftStatus
    {
        public string description { get; set; }
        public Players players { get; set; }
        public Version version { get; set; }
        public Modinfo modinfo { get; set; }
    }
}
