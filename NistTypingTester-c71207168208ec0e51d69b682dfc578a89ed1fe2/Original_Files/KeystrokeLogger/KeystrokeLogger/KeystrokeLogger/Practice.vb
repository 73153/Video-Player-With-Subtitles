Public Class Practice

    Private mState As State
    Public Sub WireState(ByVal state As State)
        mState = state
    End Sub

    Private mLogger As Logger
    Public Sub WireLogger(ByVal logger As Logger)
        mLogger = logger
    End Sub

    Private Sub Practice_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Me.Text = String.Format("Practice | String {0} of {1}", mState.CurrentLoop, mState.MaximumLoops)
        HeaderLabel.Text = String.Format("Character string {0} of {1} memorization practice", mState.CurrentLoop, mState.MaximumLoops)
        TargetStringLabel.Text = My.Settings.TargetStrings(mState.CurrentLoop - 1)

        LoggerTextBox.WireDependencies(mLogger, mState)
        LoggerTextBox.LogName = "P"

    End Sub

    Private Sub NextButton_Click(sender As System.Object, e As System.EventArgs) Handles NextButton.Click
        Me.Close()
        mState.NextScreen()
        Util.ShowForm(mState, mLogger)
    End Sub
End Class