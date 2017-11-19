using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace testDLLExport
{
    public static class Class1
    {

        [DllExport(CallingConvention = CallingConvention.Cdecl)]
        public static void TestReturnString([MarshalAs(UnmanagedType.BStr)]  ref string s_out)
        {
            s_out = "Hello from .Net !";// "Hello from .Net " + s;
        }



        [UnmanagedFunctionPointer(CallingConvention.StdCall)]
        public delegate void TProcCallback(int dane);

        [DllExport("DoSendCallbackFunction", CallingConvention = CallingConvention.StdCall)]
        public static int DoSendCallbackFunction(IntPtr callback)
        {
            TProcCallback myCallback = (TProcCallback)Marshal.GetDelegateForFunctionPointer(callback, typeof(TProcCallback));
            int testInt = 123;
            Console.WriteLine("C#->Before Callback");
            myCallback(testInt);
            Console.WriteLine("C#->After Callback");
            return 701;
        }


    }
}
