Public Class Participant

    Dim mState As New State
    Dim mLogger As New Logger
    Dim mStopwatch As Stopwatch

    Private Sub Button1_Click(sender As System.Object, e As System.EventArgs) Handles OKButton.Click

        mStopwatch = Stopwatch.StartNew
        mLogger.WireStopwatch(mStopwatch)

        mLogger.ParticipantId = ParticipantTextBox.Text


        Me.WindowState = FormWindowState.Minimized
        mState.NextScreen()
        Util.ShowForm(mState, mLogger)
    End Sub

    Protected Overrides Sub OnActivated(e As System.EventArgs)
        MyBase.OnActivated(e)
        OKButton.Enabled = mState.CurrentScreen = State.Screen.Participant
    End Sub


    Private WithEvents mKeyboardHook As KeyboardHook
    Private Sub Participant_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load

        If Not My.Computer.FileSystem.DirectoryExists(My.Settings.OutputDirectory) Then

            My.Computer.FileSystem.CreateDirectory(My.Settings.OutputDirectory)
            If My.Computer.FileSystem.DirectoryExists(My.Settings.OutputDirectory) Then
                Dim message As String = String.Format("The directory {0} didn't exist, so I made it for you.", My.Settings.OutputDirectory)
                MessageBox.Show(message, "You should know...")
            Else
                Dim message As String = String.Format("The directory {0} didn't exist. I tried to make it for you but I failed.", My.Settings.OutputDirectory)
                MessageBox.Show(message, "Oops")
                Application.Exit()
            End If

        End If

        Dim fonts = New Drawing.Text.InstalledFontCollection
        Dim foundConsolas As Boolean
        For Each family In fonts.Families
            If family.Name = "Consolas" Then
                foundConsolas = True
                Exit For
            End If
        Next

        If Not foundConsolas Then
            Dim message As String = "You're missing the Consolas font. You can download this from " &
                vbTab & vbNewLine & "http://www.microsoft.com/downloads/details.aspx?familyid=22e69ae4-7e40-4807-8a86-b3d36fab68d3." &
                vbTab & vbNewLine & "I put this URL in the clipboard for you."
            Clipboard.SetText("http://www.microsoft.com/downloads/details.aspx?familyid=22e69ae4-7e40-4807-8a86-b3d36fab68d3")
            MessageBox.Show(message, "Font needed")
            Application.Exit()
        End If



        mLogger.Filename = IO.Path.Combine(My.Settings.OutputDirectory, ParticipantTextBox.Text & "-" & DateTime.UtcNow.Ticks & ".log")


        If My.Settings.IncludeHooking Then
            mKeyboardHook = New KeyboardHook
            AddHandler KeyboardHook.KeyDown, AddressOf Hook_KeyDown
            AddHandler KeyboardHook.KeyUp, AddressOf Hook_KeyUp
        End If

        Clipboard.SetText(Application.LocalUserAppDataPath)

        ValidateTargetStringCount()
        ValidateOutputDirectory()
    End Sub

    Private Sub ValidateTargetStringCount()
        If My.Settings.TargetStrings.Count = State.TargetStringCount Then Return

        If My.Settings.TargetStrings.Count < State.TargetStringCount Then
            Dim errorMessage As String = String.Format("You need {0} strings in your config file. Only {1} were found.",
                                         State.TargetStringCount, My.Settings.TargetStrings.Count)
            MessageBox.Show(errorMessage, "Sorry, I can't proceed")
            Application.Exit()
        End If

        If My.Settings.TargetStrings.Count > State.TargetStringCount Then
            Dim errorMessage As String = String.Format("You need {0} strings in your settings file, but {1} were found. I'm just going to igore the extra ones.",
                                         State.TargetStringCount, My.Settings.TargetStrings.Count)
            MessageBox.Show(errorMessage, "This is a friendly warning")
        End If

       
    End Sub

    Private Sub Hook_KeyDown(ByVal key As Keys)
        mLogger.Log("(d) " & mStopwatch.ElapsedMilliseconds & " " & key.ToString)
    End Sub

    Private Sub Hook_KeyUp(ByVal key As Keys)
        mLogger.Log("(u) " & mStopwatch.ElapsedMilliseconds & " " & key.ToString)
    End Sub


    Private Sub ValidateOutputDirectory()
    End Sub

    Private Sub ParticipantTextBox_TextChanged(sender As System.Object, e As System.EventArgs) Handles ParticipantTextBox.TextChanged
        mLogger.Filename = IO.Path.Combine(My.Settings.OutputDirectory, ParticipantTextBox.Text & "-" & DateTime.UtcNow.Ticks & ".log")
    End Sub
End Class