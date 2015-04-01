namespace TypingTester.controls
{
    partial class Verify
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Verify));
            this.tbEntry = new TypingTester.CueTextBox();
            this.btnNext = new System.Windows.Forms.Button();
            this.btnBack = new System.Windows.Forms.Button();
            this.lblIncorrect = new System.Windows.Forms.Label();
            this.imgIncorrect = new System.Windows.Forms.PictureBox();
            this.btnQuit = new System.Windows.Forms.Button();
            this.imageList1 = new System.Windows.Forms.ImageList(this.components);
            this.btnSkip = new System.Windows.Forms.Button();
            this.btnHidden = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.imgIncorrect)).BeginInit();
            this.SuspendLayout();
            // 
            // tbEntry
            // 
            this.tbEntry.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEntry.Cue = "Type here ...";
            this.tbEntry.EscapeCurrentValue = false;
            this.tbEntry.Id = null;
            this.tbEntry.Location = new System.Drawing.Point(23, 118);
            this.tbEntry.Name = "tbEntry";
            this.tbEntry.Size = new System.Drawing.Size(743, 20);
            this.tbEntry.TabIndex = 1;
            this.tbEntry.TargetString = "";
            this.tbEntry.UseSystemPasswordChar = true;
            this.tbEntry.TextChanged += new System.EventHandler(this.tbEntry_TextChanged);
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnNext.Enabled = false;
            this.btnNext.Location = new System.Drawing.Point(393, 168);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 3;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // btnBack
            // 
            this.btnBack.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnBack.Location = new System.Drawing.Point(312, 168);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(75, 23);
            this.btnBack.TabIndex = 2;
            this.btnBack.Text = "Back";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // lblIncorrect
            // 
            this.lblIncorrect.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblIncorrect.AutoSize = true;
            this.lblIncorrect.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIncorrect.ForeColor = System.Drawing.Color.Red;
            this.lblIncorrect.Location = new System.Drawing.Point(362, 144);
            this.lblIncorrect.Name = "lblIncorrect";
            this.lblIncorrect.Size = new System.Drawing.Size(81, 20);
            this.lblIncorrect.TabIndex = 11;
            this.lblIncorrect.Text = "Incorrect";
            this.lblIncorrect.Visible = false;
            // 
            // imgIncorrect
            // 
            this.imgIncorrect.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.imgIncorrect.Image = ((System.Drawing.Image)(resources.GetObject("imgIncorrect.Image")));
            this.imgIncorrect.Location = new System.Drawing.Point(338, 145);
            this.imgIncorrect.Name = "imgIncorrect";
            this.imgIncorrect.Size = new System.Drawing.Size(18, 18);
            this.imgIncorrect.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.imgIncorrect.TabIndex = 10;
            this.imgIncorrect.TabStop = false;
            this.imgIncorrect.Visible = false;
            this.imgIncorrect.Click += new System.EventHandler(this.imgIncorrect_Click);
            // 
            // btnQuit
            // 
            this.btnQuit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnQuit.AutoSize = true;
            this.btnQuit.ImageIndex = 0;
            this.btnQuit.ImageList = this.imageList1;
            this.btnQuit.Location = new System.Drawing.Point(23, 470);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(75, 34);
            this.btnQuit.TabIndex = 3;
            this.btnQuit.Text = "Quit";
            this.btnQuit.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Visible = false;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // imageList1
            // 
            this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
            this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
            this.imageList1.Images.SetKeyName(0, "717-flag.png");
            this.imageList1.Images.SetKeyName(1, "759-refresh-2.png");
            // 
            // btnSkip
            // 
            this.btnSkip.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnSkip.AutoSize = true;
            this.btnSkip.ImageIndex = 1;
            this.btnSkip.ImageList = this.imageList1;
            this.btnSkip.Location = new System.Drawing.Point(104, 470);
            this.btnSkip.Name = "btnSkip";
            this.btnSkip.Size = new System.Drawing.Size(75, 34);
            this.btnSkip.TabIndex = 4;
            this.btnSkip.Text = "Skip";
            this.btnSkip.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnSkip.UseVisualStyleBackColor = true;
            this.btnSkip.Visible = false;
            this.btnSkip.Click += new System.EventHandler(this.btnSkip_Click);
            // 
            // btnHidden
            // 
            this.btnHidden.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnHidden.Location = new System.Drawing.Point(691, 470);
            this.btnHidden.Name = "btnHidden";
            this.btnHidden.Size = new System.Drawing.Size(1, 1);
            this.btnHidden.TabIndex = 0;
            this.btnHidden.Text = "button1";
            this.btnHidden.UseVisualStyleBackColor = true;
            // 
            // Verify
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnHidden);
            this.Controls.Add(this.btnSkip);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.lblIncorrect);
            this.Controls.Add(this.imgIncorrect);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbEntry);
            this.Name = "Verify";
            this.Load += new System.EventHandler(this.Verify_Load);
            this.Controls.SetChildIndex(this.tbEntry, 0);
            this.Controls.SetChildIndex(this.btnNext, 0);
            this.Controls.SetChildIndex(this.btnBack, 0);
            this.Controls.SetChildIndex(this.imgIncorrect, 0);
            this.Controls.SetChildIndex(this.lblIncorrect, 0);
            this.Controls.SetChildIndex(this.btnQuit, 0);
            this.Controls.SetChildIndex(this.btnSkip, 0);
            this.Controls.SetChildIndex(this.btnHidden, 0);
            ((System.ComponentModel.ISupportInitialize)(this.imgIncorrect)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private CueTextBox tbEntry;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.Button btnBack;
        private System.Windows.Forms.Label lblIncorrect;
        private System.Windows.Forms.PictureBox imgIncorrect;
        private System.Windows.Forms.Button btnQuit;
        private System.Windows.Forms.ImageList imageList1;
        private System.Windows.Forms.Button btnSkip;
        private System.Windows.Forms.Button btnHidden;
    }
}
