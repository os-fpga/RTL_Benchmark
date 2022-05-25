using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Ports;
namespace WindowsFormsApplication1
{
    class IOcomunicator
    {
        protected static SerialPort port1;



        public IOcomunicator(string portid, int speed)
        {
            port1 = new SerialPort(portid, speed, Parity.None, 8, StopBits.One);
            port1.Open();
            port1.ReadTimeout = 100000000;
            port1.DataReceived += new
            SerialDataReceivedEventHandler(port_DataReceived);
        }
         private void port_DataReceived(object sender,
         SerialDataReceivedEventArgs e) { // Show all the incoming data in the port's buffer 
             Console.WriteLine(port1.ReadExisting()); 
         }

         protected void WriteToPort(byte[] buffer,int lenght)
         {
             port1.Write(buffer, 0, lenght);
         }

        public void read(byte adress)
        {
            Byte[] buffer = new Byte[1];
            buffer[0] = adress;
            WriteToPort(buffer,1);
        }

        public Byte[] topc(int aantalReads)
        {
            Byte[] buffer = new Byte[aantalReads];
            buffer[0] = 0;
            WriteToPort(buffer, 1);
            for (int i = 0; i < aantalReads; i++)
                buffer[i] = Convert.ToByte(port1.ReadByte());
            return buffer;
        }
        public void write(byte adress, byte data)
        {
            Byte[] buffer = new Byte[2];
            buffer[1] = data;
            buffer[0] = Convert.ToByte(adress | 128);
            WriteToPort(buffer,2);
        }


        public void close()
        {
            port1.Close();
        }
    }
}