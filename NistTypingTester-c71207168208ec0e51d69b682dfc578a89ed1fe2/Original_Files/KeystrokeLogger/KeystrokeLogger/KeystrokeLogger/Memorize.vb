Public Class Memorize



    Private mState As State
    Public Sub WireState(ByVal state As State)
        mState = state
    End Sub
    Public ReadOnly Property State As State
        Get
            Return mState
        End Get
    End Property

    Private mLogger As Logger
    Public Sub WireLogger(ByVal logger As Logger)
        mLogger = logger
    End Sub

    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

        
    End Sub


    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        Me.Text = String.Format("Memorize | String {0} of {1}", State.CurrentLoop, State.MaximumLoops)

        Dim LoggerBoxes As KeystokeLoggerTextBox() = {KeystrokeLoggerTextBox1, KeystrokeLoggerTextBox2, KeystrokeLoggerTextBox3,
                              KeystokeLoggerTextBox4, KeystokeLoggerTextBox5, KeystokeLoggerTextBox6,
                               KeystokeLoggerTextBox7, KeystokeLoggerTextBox8, KeystokeLoggerTextBox9,
                               KeystokeLoggerTextBox10}
        For i As Integer = 0 To LoggerBoxes.Length - 1
            With LoggerBoxes(i)
                .WireDependencies(mLogger, mState)
                .Mask = True
                .LogName = (i + 1).ToString
                .Refresh()
            End With
        Next


        Dim toEmphasize = "quickly and as accurately"
        HeaderRichTextBox.Select(HeaderRichTextBox.Text.IndexOf(toEmphasize), toEmphasize.Length)
        HeaderRichTextBox.SelectionFont = New Font(HeaderRichTextBox.Font, FontStyle.Bold Or FontStyle.Underline)

        RefreshNextButtonEnabled()

    End Sub

    Private Sub TextBoxChanged() Handles _
        KeystrokeLoggerTextBox1.TextChanged, KeystrokeLoggerTextBox2.TextChanged, _
        KeystrokeLoggerTextBox3.TextChanged, KeystokeLoggerTextBox4.TextChanged, _
        KeystokeLoggerTextBox5.TextChanged, KeystokeLoggerTextBox6.TextChanged, _
        KeystokeLoggerTextBox7.TextChanged, KeystokeLoggerTextBox8.TextChanged, _
        KeystokeLoggerTextBox9.TextChanged, KeystokeLoggerTextBox10.TextChanged

        If My.Settings.ClearClipboard Then
            Clipboard.Clear()
        End If

        RefreshNextButtonEnabled()
    End Sub


    Private Sub RefreshNextButtonEnabled()
        Dim LoggerBoxes As KeystokeLoggerTextBox() = {KeystrokeLoggerTextBox1, KeystrokeLoggerTextBox2, KeystrokeLoggerTextBox3,
                             KeystokeLoggerTextBox4, KeystokeLoggerTextBox5, KeystokeLoggerTextBox6,
                              KeystokeLoggerTextBox7, KeystokeLoggerTextBox8, KeystokeLoggerTextBox9,
                              KeystokeLoggerTextBox10}
        For i As Integer = 0 To LoggerBoxes.Length - 1
            If LoggerBoxes(i).TextBox.Text = String.Empty Then
                NextButton.Enabled = False
                Return
            End If
        Next
        NextButton.Enabled = True


    End Sub

    Private Sub NextButton_Click(sender As System.Object, e As System.EventArgs) Handles NextButton.Click
        Me.Close()
        mState.NextScreen()
        Util.ShowForm(mState, mLogger)
    End Sub
End Class