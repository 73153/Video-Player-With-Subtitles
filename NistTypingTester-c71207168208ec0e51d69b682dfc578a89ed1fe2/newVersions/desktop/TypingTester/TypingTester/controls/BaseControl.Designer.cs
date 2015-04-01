namespace TypingTester.controls
{
    partial class BaseControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblHeaderBase = new System.Windows.Forms.Label();
            this.lblEntityProgressBase = new System.Windows.Forms.Label();
            this.lblRoundBase = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblHeaderBase
            // 
            this.lblHeaderBase.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblHeaderBase.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblHeaderBase.Location = new System.Drawing.Point(0, 15);
            this.lblHeaderBase.Name = "lblHeaderBase";
            this.lblHeaderBase.Size = new System.Drawing.Size(777, 20);
            this.lblHeaderBase.TabIndex = 3;
            this.lblHeaderBase.Text = "Header Text";
            this.lblHeaderBase.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblEntityProgressBase
            // 
            this.lblEntityProgressBase.AutoSize = true;
            this.lblEntityProgressBase.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.lblEntityProgressBase.Location = new System.Drawing.Point(20, 35);
            this.lblEntityProgressBase.Name = "lblEntityProgressBase";
            this.lblEntityProgressBase.Size = new System.Drawing.Size(85, 13);
            this.lblEntityProgressBase.TabIndex = 4;
            this.lblEntityProgressBase.Text = "Password # of #";
            // 
            // lblRoundBase
            // 
            this.lblRoundBase.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblRoundBase.AutoSize = true;
            this.lblRoundBase.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.lblRoundBase.Location = new System.Drawing.Point(695, 35);
            this.lblRoundBase.Name = "lblRoundBase";
            this.lblRoundBase.Size = new System.Drawing.Size(71, 13);
            this.lblRoundBase.TabIndex = 5;
            this.lblRoundBase.Text = "Round # of #";
            // 
            // BaseControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.lblRoundBase);
            this.Controls.Add(this.lblEntityProgressBase);
            this.Controls.Add(this.lblHeaderBase);
            this.Name = "BaseControl";
            this.Size = new System.Drawing.Size(780, 510);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblHeaderBase;
        private System.Windows.Forms.Label lblEntityProgressBase;
        private System.Windows.Forms.Label lblRoundBase;
    }
}
