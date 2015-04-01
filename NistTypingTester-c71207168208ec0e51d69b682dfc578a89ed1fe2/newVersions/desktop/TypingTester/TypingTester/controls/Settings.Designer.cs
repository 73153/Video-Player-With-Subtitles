namespace TypingTester.controls
{
    partial class Settings
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.spnVerification = new System.Windows.Forms.NumericUpDown();
            this.spnForcedPractice = new System.Windows.Forms.NumericUpDown();
            this.spnRepetitions = new System.Windows.Forms.NumericUpDown();
            this.spnNumberOfEntities = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.spnGroupId = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.cbUseGroupFilter = new System.Windows.Forms.CheckBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.tbSkipString = new TypingTester.CueTextBox();
            this.tbQuitString = new TypingTester.CueTextBox();
            this.cbHideButton = new System.Windows.Forms.CheckBox();
            this.cbQuitButton = new System.Windows.Forms.CheckBox();
            this.cbSkipButton = new System.Windows.Forms.CheckBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.cbRandomizeOrder = new System.Windows.Forms.CheckBox();
            this.cbUseOrderSeed = new System.Windows.Forms.CheckBox();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.tbOrderSeed = new TypingTester.CueTextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.cbRandomizeSelection = new System.Windows.Forms.CheckBox();
            this.tbSelectionSeed = new TypingTester.CueTextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.cbUseSelectionSeed = new System.Windows.Forms.CheckBox();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.cbDisableFreePractice = new System.Windows.Forms.CheckBox();
            this.cbDisableFPTextBox = new System.Windows.Forms.CheckBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spnVerification)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnForcedPractice)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnRepetitions)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnNumberOfEntities)).BeginInit();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spnGroupId)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.cbDisableFPTextBox);
            this.groupBox1.Controls.Add(this.cbDisableFreePractice);
            this.groupBox1.Controls.Add(this.label11);
            this.groupBox1.Controls.Add(this.label10);
            this.groupBox1.Controls.Add(this.spnVerification);
            this.groupBox1.Controls.Add(this.spnForcedPractice);
            this.groupBox1.Controls.Add(this.spnRepetitions);
            this.groupBox1.Controls.Add(this.spnNumberOfEntities);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(18, 53);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(303, 176);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Quantities";
            // 
            // spnVerification
            // 
            this.spnVerification.Location = new System.Drawing.Point(170, 140);
            this.spnVerification.Name = "spnVerification";
            this.spnVerification.Size = new System.Drawing.Size(120, 20);
            this.spnVerification.TabIndex = 5;
            this.spnVerification.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // spnForcedPractice
            // 
            this.spnForcedPractice.Location = new System.Drawing.Point(170, 114);
            this.spnForcedPractice.Name = "spnForcedPractice";
            this.spnForcedPractice.Size = new System.Drawing.Size(120, 20);
            this.spnForcedPractice.TabIndex = 4;
            this.spnForcedPractice.Value = new decimal(new int[] {
            3,
            0,
            0,
            0});
            // 
            // spnRepetitions
            // 
            this.spnRepetitions.Location = new System.Drawing.Point(170, 88);
            this.spnRepetitions.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.spnRepetitions.Name = "spnRepetitions";
            this.spnRepetitions.Size = new System.Drawing.Size(120, 20);
            this.spnRepetitions.TabIndex = 3;
            this.spnRepetitions.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            // 
            // spnNumberOfEntities
            // 
            this.spnNumberOfEntities.Location = new System.Drawing.Point(170, 16);
            this.spnNumberOfEntities.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.spnNumberOfEntities.Name = "spnNumberOfEntities";
            this.spnNumberOfEntities.Size = new System.Drawing.Size(120, 20);
            this.spnNumberOfEntities.TabIndex = 0;
            this.spnNumberOfEntities.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(65, 142);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(99, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Verification Rounds";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(42, 116);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(122, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Forced Practice Rounds";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(52, 90);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(112, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Rounds Per Password";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(54, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(110, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Number of Passwords";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.spnGroupId);
            this.groupBox3.Controls.Add(this.label5);
            this.groupBox3.Controls.Add(this.cbUseGroupFilter);
            this.groupBox3.Location = new System.Drawing.Point(510, 248);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(200, 79);
            this.groupBox3.TabIndex = 3;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Filtering";
            // 
            // spnGroupId
            // 
            this.spnGroupId.Location = new System.Drawing.Point(69, 37);
            this.spnGroupId.Name = "spnGroupId";
            this.spnGroupId.Size = new System.Drawing.Size(120, 20);
            this.spnGroupId.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(13, 39);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(50, 13);
            this.label5.TabIndex = 1;
            this.label5.Text = "Group ID";
            // 
            // cbUseGroupFilter
            // 
            this.cbUseGroupFilter.AutoSize = true;
            this.cbUseGroupFilter.Location = new System.Drawing.Point(16, 19);
            this.cbUseGroupFilter.Name = "cbUseGroupFilter";
            this.cbUseGroupFilter.Size = new System.Drawing.Size(109, 17);
            this.cbUseGroupFilter.TabIndex = 0;
            this.cbUseGroupFilter.Text = "Filter By Group ID";
            this.cbUseGroupFilter.UseVisualStyleBackColor = true;
            this.cbUseGroupFilter.CheckedChanged += new System.EventHandler(this.cbUseGroupFilter_CheckedChanged);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.tbSkipString);
            this.groupBox4.Controls.Add(this.tbQuitString);
            this.groupBox4.Controls.Add(this.cbHideButton);
            this.groupBox4.Controls.Add(this.cbQuitButton);
            this.groupBox4.Controls.Add(this.cbSkipButton);
            this.groupBox4.Controls.Add(this.label9);
            this.groupBox4.Controls.Add(this.label8);
            this.groupBox4.Location = new System.Drawing.Point(18, 347);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(743, 100);
            this.groupBox4.TabIndex = 4;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Misc";
            // 
            // tbSkipString
            // 
            this.tbSkipString.Cue = "SKIP THIS";
            this.tbSkipString.EscapeCurrentValue = false;
            this.tbSkipString.Id = null;
            this.tbSkipString.Location = new System.Drawing.Point(80, 35);
            this.tbSkipString.Name = "tbSkipString";
            this.tbSkipString.Size = new System.Drawing.Size(612, 20);
            this.tbSkipString.TabIndex = 1;
            this.tbSkipString.TargetString = "";
            // 
            // tbQuitString
            // 
            this.tbQuitString.Cue = "I QUIT";
            this.tbQuitString.EscapeCurrentValue = false;
            this.tbQuitString.Id = null;
            this.tbQuitString.Location = new System.Drawing.Point(80, 13);
            this.tbQuitString.Name = "tbQuitString";
            this.tbQuitString.Size = new System.Drawing.Size(611, 20);
            this.tbQuitString.TabIndex = 0;
            this.tbQuitString.TargetString = "";
            // 
            // cbHideButton
            // 
            this.cbHideButton.AutoSize = true;
            this.cbHideButton.Location = new System.Drawing.Point(520, 62);
            this.cbHideButton.Name = "cbHideButton";
            this.cbHideButton.Size = new System.Drawing.Size(171, 17);
            this.cbHideButton.TabIndex = 4;
            this.cbHideButton.Text = "Enable hide on forced practice";
            this.cbHideButton.UseVisualStyleBackColor = true;
            // 
            // cbQuitButton
            // 
            this.cbQuitButton.AutoSize = true;
            this.cbQuitButton.Location = new System.Drawing.Point(268, 62);
            this.cbQuitButton.Name = "cbQuitButton";
            this.cbQuitButton.Size = new System.Drawing.Size(109, 17);
            this.cbQuitButton.TabIndex = 3;
            this.cbQuitButton.Text = "Show Quit Button";
            this.cbQuitButton.UseVisualStyleBackColor = true;
            // 
            // cbSkipButton
            // 
            this.cbSkipButton.AutoSize = true;
            this.cbSkipButton.Location = new System.Drawing.Point(14, 62);
            this.cbSkipButton.Name = "cbSkipButton";
            this.cbSkipButton.Size = new System.Drawing.Size(111, 17);
            this.cbSkipButton.TabIndex = 2;
            this.cbSkipButton.Text = "Show Skip Button";
            this.cbSkipButton.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(13, 38);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(58, 13);
            this.label9.TabIndex = 1;
            this.label9.Text = "Skip String";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(13, 16);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(56, 13);
            this.label8.TabIndex = 0;
            this.label8.Text = "Quit String";
            // 
            // cbRandomizeOrder
            // 
            this.cbRandomizeOrder.AutoSize = true;
            this.cbRandomizeOrder.Location = new System.Drawing.Point(15, 19);
            this.cbRandomizeOrder.Name = "cbRandomizeOrder";
            this.cbRandomizeOrder.Size = new System.Drawing.Size(79, 17);
            this.cbRandomizeOrder.TabIndex = 0;
            this.cbRandomizeOrder.Text = "Randomize";
            this.cbRandomizeOrder.UseVisualStyleBackColor = true;
            this.cbRandomizeOrder.CheckedChanged += new System.EventHandler(this.cbRandomizeOrder_CheckedChanged);
            // 
            // cbUseOrderSeed
            // 
            this.cbUseOrderSeed.AutoSize = true;
            this.cbUseOrderSeed.Enabled = false;
            this.cbUseOrderSeed.Location = new System.Drawing.Point(15, 42);
            this.cbUseOrderSeed.Name = "cbUseOrderSeed";
            this.cbUseOrderSeed.Size = new System.Drawing.Size(150, 17);
            this.cbUseOrderSeed.TabIndex = 1;
            this.cbUseOrderSeed.Text = "Use Specified Seed Value";
            this.cbUseOrderSeed.UseVisualStyleBackColor = true;
            this.cbUseOrderSeed.CheckedChanged += new System.EventHandler(this.cbUseOrderSeed_CheckedChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 62);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(62, 13);
            this.label6.TabIndex = 2;
            this.label6.Text = "Seed Value";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.tbOrderSeed);
            this.groupBox5.Controls.Add(this.cbRandomizeOrder);
            this.groupBox5.Controls.Add(this.label6);
            this.groupBox5.Controls.Add(this.cbUseOrderSeed);
            this.groupBox5.Location = new System.Drawing.Point(18, 248);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(210, 92);
            this.groupBox5.TabIndex = 1;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Entity Order";
            // 
            // tbOrderSeed
            // 
            this.tbOrderSeed.Cue = "0";
            this.tbOrderSeed.EscapeCurrentValue = false;
            this.tbOrderSeed.Id = null;
            this.tbOrderSeed.Location = new System.Drawing.Point(80, 59);
            this.tbOrderSeed.Name = "tbOrderSeed";
            this.tbOrderSeed.Size = new System.Drawing.Size(124, 20);
            this.tbOrderSeed.TabIndex = 2;
            this.tbOrderSeed.TargetString = "";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.cbRandomizeSelection);
            this.groupBox2.Controls.Add(this.tbSelectionSeed);
            this.groupBox2.Controls.Add(this.label7);
            this.groupBox2.Controls.Add(this.cbUseSelectionSeed);
            this.groupBox2.Location = new System.Drawing.Point(272, 248);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(210, 92);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Entity Selection";
            // 
            // cbRandomizeSelection
            // 
            this.cbRandomizeSelection.AutoSize = true;
            this.cbRandomizeSelection.Location = new System.Drawing.Point(15, 19);
            this.cbRandomizeSelection.Name = "cbRandomizeSelection";
            this.cbRandomizeSelection.Size = new System.Drawing.Size(79, 17);
            this.cbRandomizeSelection.TabIndex = 0;
            this.cbRandomizeSelection.Text = "Randomize";
            this.cbRandomizeSelection.UseVisualStyleBackColor = true;
            this.cbRandomizeSelection.CheckedChanged += new System.EventHandler(this.cbRandomizeSelection_CheckedChanged);
            // 
            // tbSelectionSeed
            // 
            this.tbSelectionSeed.Cue = "0";
            this.tbSelectionSeed.EscapeCurrentValue = false;
            this.tbSelectionSeed.Id = null;
            this.tbSelectionSeed.Location = new System.Drawing.Point(80, 59);
            this.tbSelectionSeed.Name = "tbSelectionSeed";
            this.tbSelectionSeed.Size = new System.Drawing.Size(124, 20);
            this.tbSelectionSeed.TabIndex = 2;
            this.tbSelectionSeed.TargetString = "";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(12, 62);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(62, 13);
            this.label7.TabIndex = 2;
            this.label7.Text = "Seed Value";
            // 
            // cbUseSelectionSeed
            // 
            this.cbUseSelectionSeed.AutoSize = true;
            this.cbUseSelectionSeed.Enabled = false;
            this.cbUseSelectionSeed.Location = new System.Drawing.Point(15, 42);
            this.cbUseSelectionSeed.Name = "cbUseSelectionSeed";
            this.cbUseSelectionSeed.Size = new System.Drawing.Size(150, 17);
            this.cbUseSelectionSeed.TabIndex = 1;
            this.cbUseSelectionSeed.Text = "Use Specified Seed Value";
            this.cbUseSelectionSeed.UseVisualStyleBackColor = true;
            this.cbUseSelectionSeed.CheckedChanged += new System.EventHandler(this.cbUseSelectionSeed_CheckedChanged);
            // 
            // btnReset
            // 
            this.btnReset.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnReset.Location = new System.Drawing.Point(434, 470);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(75, 23);
            this.btnReset.TabIndex = 7;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnCancel.Location = new System.Drawing.Point(353, 470);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 6;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnSave.Location = new System.Drawing.Point(272, 470);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 5;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(54, 42);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(108, 13);
            this.label10.TabIndex = 4;
            this.label10.Text = "Disable Free Practice";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(11, 65);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(153, 13);
            this.label11.TabIndex = 5;
            this.label11.Text = "Disable Free Practice Text Box";
            // 
            // cbDisableFreePractice
            // 
            this.cbDisableFreePractice.AutoSize = true;
            this.cbDisableFreePractice.Location = new System.Drawing.Point(170, 42);
            this.cbDisableFreePractice.Name = "cbDisableFreePractice";
            this.cbDisableFreePractice.Size = new System.Drawing.Size(15, 14);
            this.cbDisableFreePractice.TabIndex = 1;
            this.cbDisableFreePractice.UseVisualStyleBackColor = true;
            // 
            // cbDisableFPTextBox
            // 
            this.cbDisableFPTextBox.AutoSize = true;
            this.cbDisableFPTextBox.Location = new System.Drawing.Point(170, 65);
            this.cbDisableFPTextBox.Name = "cbDisableFPTextBox";
            this.cbDisableFPTextBox.Size = new System.Drawing.Size(15, 14);
            this.cbDisableFPTextBox.TabIndex = 2;
            this.cbDisableFPTextBox.UseVisualStyleBackColor = true;
            // 
            // Settings
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox1);
            this.Name = "Settings";
            this.Load += new System.EventHandler(this.Settings_Load);
            this.Controls.SetChildIndex(this.groupBox1, 0);
            this.Controls.SetChildIndex(this.groupBox3, 0);
            this.Controls.SetChildIndex(this.groupBox4, 0);
            this.Controls.SetChildIndex(this.groupBox5, 0);
            this.Controls.SetChildIndex(this.groupBox2, 0);
            this.Controls.SetChildIndex(this.btnReset, 0);
            this.Controls.SetChildIndex(this.btnCancel, 0);
            this.Controls.SetChildIndex(this.btnSave, 0);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spnVerification)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnForcedPractice)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnRepetitions)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnNumberOfEntities)).EndInit();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spnGroupId)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.CheckBox cbUseGroupFilter;
        private CueTextBox tbSkipString;
        private CueTextBox tbQuitString;
        private System.Windows.Forms.CheckBox cbHideButton;
        private System.Windows.Forms.CheckBox cbQuitButton;
        private System.Windows.Forms.CheckBox cbSkipButton;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.CheckBox cbRandomizeOrder;
        private System.Windows.Forms.CheckBox cbUseOrderSeed;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckBox cbRandomizeSelection;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.CheckBox cbUseSelectionSeed;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.NumericUpDown spnVerification;
        private System.Windows.Forms.NumericUpDown spnForcedPractice;
        private System.Windows.Forms.NumericUpDown spnRepetitions;
        private System.Windows.Forms.NumericUpDown spnNumberOfEntities;
        private System.Windows.Forms.NumericUpDown spnGroupId;
        private CueTextBox tbOrderSeed;
        private CueTextBox tbSelectionSeed;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.CheckBox cbDisableFPTextBox;
        private System.Windows.Forms.CheckBox cbDisableFreePractice;
    }
}
