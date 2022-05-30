namespace WindowsFormsApplication1
{

    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.read = new System.Windows.Forms.Button();
            this.write = new System.Windows.Forms.Button();
            this.toPC = new System.Windows.Forms.Button();
            this.readadresstext = new System.Windows.Forms.TextBox();
            this.writeadresstext = new System.Windows.Forms.TextBox();
            this.returnData = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.writedata = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // read
            // 
            this.read.Location = new System.Drawing.Point(16, 48);
            this.read.Name = "read";
            this.read.Size = new System.Drawing.Size(75, 23);
            this.read.TabIndex = 0;
            this.read.Tag = "read";
            this.read.Text = "read";
            this.read.UseVisualStyleBackColor = true;
            this.read.Click += new System.EventHandler(this.read_Click);
            // 
            // write
            // 
            this.write.Location = new System.Drawing.Point(16, 94);
            this.write.Name = "write";
            this.write.Size = new System.Drawing.Size(75, 23);
            this.write.TabIndex = 1;
            this.write.Tag = "write";
            this.write.Text = "write";
            this.write.UseVisualStyleBackColor = true;
            this.write.Click += new System.EventHandler(this.write_Click);
            // 
            // toPC
            // 
            this.toPC.Location = new System.Drawing.Point(16, 140);
            this.toPC.Name = "toPC";
            this.toPC.Size = new System.Drawing.Size(75, 23);
            this.toPC.TabIndex = 4;
            this.toPC.Tag = "to_pc";
            this.toPC.Text = "to pc";
            this.toPC.UseVisualStyleBackColor = true;
            this.toPC.Click += new System.EventHandler(this.toPC_Click);
            // 
            // readadresstext
            // 
            this.readadresstext.Location = new System.Drawing.Point(118, 48);
            this.readadresstext.Name = "readadresstext";
            this.readadresstext.Size = new System.Drawing.Size(100, 20);
            this.readadresstext.TabIndex = 5;
            this.readadresstext.Tag = "readadresstext";
            this.readadresstext.TextChanged += new System.EventHandler(this.readadresstext_TextChanged);
            // 
            // writeadresstext
            // 
            this.writeadresstext.Location = new System.Drawing.Point(118, 96);
            this.writeadresstext.Name = "writeadresstext";
            this.writeadresstext.Size = new System.Drawing.Size(100, 20);
            this.writeadresstext.TabIndex = 8;
            this.writeadresstext.Tag = "writeadresstext";
            this.writeadresstext.TextChanged += new System.EventHandler(this.writeadresstext_TextChanged);
            // 
            // returnData
            // 
            this.returnData.Location = new System.Drawing.Point(258, 159);
            this.returnData.Name = "returnData";
            this.returnData.ReadOnly = true;
            this.returnData.Size = new System.Drawing.Size(100, 20);
            this.returnData.TabIndex = 13;
            this.returnData.Tag = "returndata";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(258, 140);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 14;
            this.label1.Text = "returned data";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(115, 21);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(47, 13);
            this.label4.TabIndex = 17;
            this.label4.Text = "register1";
            // 
            // writedata
            // 
            this.writedata.Location = new System.Drawing.Point(261, 94);
            this.writedata.Name = "writedata";
            this.writedata.Size = new System.Drawing.Size(100, 20);
            this.writedata.TabIndex = 11;
            this.writedata.Tag = "writedata";
            this.writedata.TextChanged += new System.EventHandler(this.writedata_TextChanged);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(401, 202);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.returnData);
            this.Controls.Add(this.writedata);
            this.Controls.Add(this.writeadresstext);
            this.Controls.Add(this.readadresstext);
            this.Controls.Add(this.toPC);
            this.Controls.Add(this.write);
            this.Controls.Add(this.read);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button read;
        private System.Windows.Forms.Button write;
        private System.Windows.Forms.Button toPC;
        private System.Windows.Forms.TextBox readadresstext;
        private System.Windows.Forms.TextBox writeadresstext;
        private System.Windows.Forms.TextBox returnData;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox writedata;
    }
}

