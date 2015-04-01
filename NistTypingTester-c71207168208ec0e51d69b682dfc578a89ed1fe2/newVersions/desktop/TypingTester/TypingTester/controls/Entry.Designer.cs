namespace TypingTester.controls
{
    partial class Entry
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
            this.tbEntry = new TypingTester.CueTextBox();
            this.btnNext = new System.Windows.Forms.Button();
            this.btnHidden = new System.Windows.Forms.Button();
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
            this.btnNext.Location = new System.Drawing.Point(353, 168);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 2;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // btnHidden
            // 
            this.btnHidden.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnHidden.Location = new System.Drawing.Point(691, 472);
            this.btnHidden.Name = "btnHidden";
            this.btnHidden.Size = new System.Drawing.Size(1, 1);
            this.btnHidden.TabIndex = 0;
            this.btnHidden.Text = "button1";
            this.btnHidden.UseVisualStyleBackColor = true;
            // 
            // Entry
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnHidden);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbEntry);
            this.Name = "Entry";
            this.Load += new System.EventHandler(this.Entry_Load);
            this.Controls.SetChildIndex(this.tbEntry, 0);
            this.Controls.SetChildIndex(this.btnNext, 0);
            this.Controls.SetChildIndex(this.btnHidden, 0);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private CueTextBox tbEntry;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.Button btnHidden;
    }
}
