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

    public partial class Form2 : Form
    {
        public int speed;
        public string portid;
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
           // int speed=int.Parse(speedsel.SelectedItem.Text);
           // Cominfo cominfo = new Cominfo(speed);
        }

        private void ok_Click(object sender, EventArgs e)
        {
           speed = int.Parse(speedsel.SelectedItem.ToString());
           portid = comportname.Text;
           this.DialogResult = DialogResult.OK;
        }

        private void cancel_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
        }


    }
}
