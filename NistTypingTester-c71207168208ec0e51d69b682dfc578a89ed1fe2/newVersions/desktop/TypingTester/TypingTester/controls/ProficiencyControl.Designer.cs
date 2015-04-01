namespace TypingTester.controls
{
    partial class ProficiencyControl
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
            this.lblProficiencyString = new System.Windows.Forms.Label();
            this.btnNext = new System.Windows.Forms.Button();
            this.tbEntry = new TypingTester.CueTextBox();
            this.btnHidden = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblProficiencyString
            // 
            this.lblProficiencyString.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblProficiencyString.Font = new System.Drawing.Font("Consolas", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblProficiencyString.Location = new System.Drawing.Point(23, 57);
            this.lblProficiencyString.Name = "lblProficiencyString";
            this.lblProficiencyString.Size = new System.Drawing.Size(743, 38);
            this.lblProficiencyString.TabIndex = 3;
            this.lblProficiencyString.Text = "The quick brown fox jumped over the lazy dogs.";
            this.lblProficiencyString.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
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
            // tbEntry
            // 
            this.tbEntry.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEntry.Cue = "Type here ...";
            this.tbEntry.EscapeCurrentValue = false;
            this.tbEntry.Id = "ProficiencyBox";
            this.tbEntry.Location = new System.Drawing.Point(23, 118);
            this.tbEntry.Name = "tbEntry";
            this.tbEntry.Size = new System.Drawing.Size(743, 20);
            this.tbEntry.TabIndex = 1;
            this.tbEntry.TargetString = "";
            this.tbEntry.TextChanged += new System.EventHandler(this.tbEntry_TextChanged);
            // 
            // btnHidden
            // 
            this.btnHidden.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnHidden.Location = new System.Drawing.Point(4, 474);
            this.btnHidden.Name = "btnHidden";
            this.btnHidden.Size = new System.Drawing.Size(1, 1);
            this.btnHidden.TabIndex = 0;
            this.btnHidden.Text = "button1";
            this.btnHidden.UseVisualStyleBackColor = true;
            // 
            // ProficiencyControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnHidden);
            this.Controls.Add(this.lblProficiencyString);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbEntry);
            this.Name = "ProficiencyControl";
            this.Load += new System.EventHandler(this.ProficiencyControl_Load);
            this.Controls.SetChildIndex(this.tbEntry, 0);
            this.Controls.SetChildIndex(this.btnNext, 0);
            this.Controls.SetChildIndex(this.lblProficiencyString, 0);
            this.Controls.SetChildIndex(this.btnHidden, 0);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblProficiencyString;
        private CueTextBox tbEntry;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.Button btnHidden;
    }
}
