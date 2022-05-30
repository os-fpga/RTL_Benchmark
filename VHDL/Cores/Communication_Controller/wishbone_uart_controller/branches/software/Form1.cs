using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        byte writeadress, data, readadress;
        IOcomunicator com;
        public Form1()
        {
            InitializeComponent();
            Form2 subForm = new Form2();
            subForm.Owner = this;
            subForm.ShowDialog();
            if (subForm.ShowDialog() == DialogResult.OK)
            {
                com = new IOcomunicator(subForm.portid, subForm.speed);
            }
        }
        private void Form1_FormClosing(object sender, EventArgs e)
        {
            com.close();
        }

        private void read_Click(object sender, EventArgs e)
        {
            com.read(readadress);
        }

        private void write_Click(object sender, EventArgs e)
        {
            com.write(writeadress, data);
        }


        private void toPC_Click(object sender, EventArgs e)
        {
            byte[] temp = new byte[4];
            temp=com.topc(4);
            for (int i = 0; i<4;i++ )
                Console.Write(temp[i]);

        }

        private void writedata_TextChanged(object sender, EventArgs e)
        {
            this.data = Convert.ToByte(writedata.Text);
        }

        private void writeadresstext_TextChanged(object sender, EventArgs e)
        {
            this.writeadress = Convert.ToByte(writeadresstext.Text);
        }

        private void readadresstext_TextChanged(object sender, EventArgs e)
        {
           this.readadress= Convert.ToByte(readadresstext.Text);
        }








    }
}
