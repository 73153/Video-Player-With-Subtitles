using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Settings : TypingTester.controls.BaseControl
    {
        public Settings(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To ParticipantNumber", new commands.CommandGoToScreen(reciever, Constants.Screen.StartScreen));
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Reset settings to default?", "Reset Settings", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
            {
                Options.Instance.ResetToDefault();
                executeCommand(@"Go To ParticipantNumber");
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            executeCommand(@"Go To ParticipantNumber");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.validateOptions()) return;
            Options o = Options.Instance;
            o.NumberOfEntities = Convert.ToInt32(spnNumberOfEntities.Value);
            o.RepetitionPerEntity = Convert.ToInt32(spnRepetitions.Value);
            o.ForcedPracticeRounds = Convert.ToInt32(spnForcedPractice.Value);
            o.VerifyRounds = Convert.ToInt32(spnVerification.Value);
            o.RandomEntityOrder = cbRandomizeOrder.Checked;
            o.UseOrderSeed = cbUseOrderSeed.Checked;
            o.OrderSeed = Convert.ToInt32(tbOrderSeed.Text);
            o.RandomEntitySelection = cbRandomizeSelection.Checked;
            o.UseSelectionSeed = cbUseSelectionSeed.Checked;
            o.SelectionSeed = Convert.ToInt32(tbSelectionSeed.Text);
            o.UseGroupId = cbUseGroupFilter.Checked;
            o.GroupId = Convert.ToInt32(spnGroupId.Value);
            o.QuitString = tbQuitString.Text;
            o.SkipString = tbSkipString.Text;
            o.ShowHideButtonOnPractice = cbHideButton.Checked;
            o.ShowQuitButton = cbQuitButton.Checked;
            o.ShowSkipButton = cbSkipButton.Checked;
            o.disableFreePractice = cbDisableFreePractice.Checked;
            o.disableFreePracticeTextBox = cbDisableFPTextBox.Checked;
            o.save();
            executeCommand(@"Go To ParticipantNumber");
        }

        private bool validateOptions()
        {
            if (this.cbDisableFreePractice.Checked && (Convert.ToInt32(spnForcedPractice.Value) <= 0))
            {
                MessageBox.Show("Forced practice rounds must be > 0 when Free Practice is disabled.", "Invalid Options", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        private void ConfigureUi()
        { 
            Options o = Options.Instance;
            spnNumberOfEntities.Value = o.NumberOfEntities;
            spnForcedPractice.Value = o.ForcedPracticeRounds;
            spnGroupId.Value = o.GroupId;
            tbOrderSeed.Text = o.OrderSeed.ToString();
            spnRepetitions.Value = o.RepetitionPerEntity;
            tbSelectionSeed.Text = o.SelectionSeed.ToString();
            spnVerification.Value = o.VerifyRounds;
            tbQuitString.Text = o.QuitString;
            tbSkipString.Text = o.SkipString;
            cbHideButton.Checked = o.ShowHideButtonOnPractice;
            cbQuitButton.Checked = o.ShowQuitButton;
            cbRandomizeOrder.Checked = o.RandomEntityOrder;
            cbRandomizeSelection.Checked = o.RandomEntitySelection;
            cbSkipButton.Checked = o.ShowSkipButton;
            cbUseGroupFilter.Checked = o.UseGroupId;
            cbUseOrderSeed.Checked = o.UseOrderSeed;
            cbUseSelectionSeed.Checked = o.UseSelectionSeed;

            cbUseOrderSeed.Enabled = (o.RandomEntityOrder) ? true : false;
            tbOrderSeed.Enabled = (o.RandomEntityOrder && o.UseOrderSeed) ? true : false;
            cbUseSelectionSeed.Enabled = (o.RandomEntitySelection) ? true : false;
            tbSelectionSeed.Enabled = (o.RandomEntitySelection && o.UseSelectionSeed) ? true : false;
            spnGroupId.Enabled = (o.UseGroupId) ? true : false;

            cbDisableFreePractice.Checked = o.disableFreePractice;
            cbDisableFPTextBox.Checked = o.disableFreePracticeTextBox;
        }

        private void cbRandomizeOrder_CheckedChanged(object sender, EventArgs e)
        {
            cbUseOrderSeed.Enabled = (cbRandomizeOrder.Checked) ? true : false;
            tbOrderSeed.Enabled = (cbRandomizeOrder.Checked && cbUseOrderSeed.Checked) ? true : false;
        }

        private void cbUseOrderSeed_CheckedChanged(object sender, EventArgs e)
        {
            tbOrderSeed.Enabled = (cbRandomizeOrder.Checked && cbUseOrderSeed.Checked) ? true : false;
        }

        private void cbRandomizeSelection_CheckedChanged(object sender, EventArgs e)
        {
            cbUseSelectionSeed.Enabled = (cbRandomizeSelection.Checked) ? true : false;
            tbSelectionSeed.Enabled = (cbRandomizeSelection.Checked && cbUseSelectionSeed.Checked) ? true : false;
        }

        private void cbUseSelectionSeed_CheckedChanged(object sender, EventArgs e)
        {
            tbSelectionSeed.Enabled = (cbRandomizeSelection.Checked && cbUseSelectionSeed.Checked) ? true : false;
        }

        private void Settings_Load(object sender, EventArgs e)
        {
            setHeaderVisibility(false);
            SetRoundProgresssVisibility(false);
            SetEntityProgressVisibility(false);
            ConfigureUi();
        }

        private void cbUseGroupFilter_CheckedChanged(object sender, EventArgs e)
        {
            spnGroupId.Enabled = (cbUseGroupFilter.Checked);
        }




    }
}
