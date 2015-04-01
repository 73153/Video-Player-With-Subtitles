Public Class Verify

    Private mState As State
    Public Sub WireState(ByVal state As State)
        mState = state
    End Sub

    Private mLogger As Logger
    Public Sub WireLogger(ByVal logger As Logger)
        mLogger = logger
    End Sub

    Private Sub NextButton_Click(sender As System.Object, e As System.EventArgs) Handles NextButton.Click
        Me.Close()
        mState.NextScreen()
        Util.ShowForm(mState, mLogger)
    End Sub


    Private Sub BackButton_Click(sender As System.Object, e As System.EventArgs) Handles BackButton.Click
        Me.Close()
        mState.Back()
        Util.ShowForm(mState, mLogger)
    End Sub

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        Me.Text = String.Format("Verify | String {0} of {1}", mState.CurrentLoop, mState.MaximumLoops)
        MainKeystokeLoggerTextBox.TargetString = mState.TargetString
        MainKeystokeLoggerTextBox.LogName = "V"
        MainKeystokeLoggerTextBox.WireDependencies(mLogger, mState)
    End Sub

    Private Sub VerifyButton_Click(sender As System.Object, e As System.EventArgs) Handles VerifyButton.Click
        If MainKeystokeLoggerTextBox.Match Then
            MainKeystokeLoggerTextBox.Mask = False
            VerifyLabel.Text = "OK"
            VerifyButton.Enabled = False
            NextButton.Enabled = True
        Else
            MainKeystokeLoggerTextBox.Mask = False
            VerifyLabel.Text = "Not OK"
        End If
        VerifyLabel.Refresh()
    End Sub



    Private Sub LoggerTextBox_Changed(sender As Object, e As EventArgs) Handles MainKeystokeLoggerTextBox.TextChanged
        VerifyLabel.Text = String.Empty
        MainKeystokeLoggerTextBox.Mask = False
        NextButton.Enabled = False
        VerifyButton.Enabled = True
    End Sub

    Private Sub MainFlowLayoutPanel_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles MainFlowLayoutPanel.Paint

    End Sub
End Class