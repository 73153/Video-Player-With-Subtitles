Public Class State

    Public Const TargetStringCount As Integer = 10

    Public Enum Screen
        None
        Participant
        Practice
        Verify
        Memorize
        FreeEntry
        Done
    End Enum


    Private mCurrentScreen As Screen = Screen.Participant
    Public ReadOnly Property CurrentScreen As Screen
        Get
            Return mCurrentScreen
        End Get
    End Property

    Private mPreviousScreen As Screen = Screen.None
    Public ReadOnly Property PreviousScreen As Screen
        Get
            Return mPreviousScreen
        End Get
    End Property

    Public ReadOnly Property TargetString As String
        Get
            Return My.Settings.TargetStrings(mCurrentLoop - 1)
        End Get
    End Property

    'Private mMaximumLoops As Integer = 10
    Private mMaximumLoops As Integer = 10
    Public ReadOnly Property MaximumLoops As Integer
        Get
            If My.Settings.OnlyDoOneLoop Then
                Return 1
            Else
                Return mMaximumLoops
            End If
        End Get
    End Property

    Private mCurrentLoop As Integer = 1
    Public ReadOnly Property CurrentLoop As Integer
        Get
            Return mCurrentLoop
        End Get
    End Property

    Public Sub NextScreen()

        mPreviousScreen = mCurrentScreen
        Select Case mCurrentScreen
            Case Screen.Participant
                mCurrentScreen = Screen.Practice
            Case Screen.Practice
                mCurrentScreen = Screen.Verify
            Case Screen.Verify
                mCurrentScreen = Screen.Memorize
            Case Screen.Memorize
                If mCurrentLoop = MaximumLoops Then
                    mCurrentScreen = Screen.FreeEntry
                Else
                    mCurrentLoop += 1
                    mCurrentScreen = Screen.Practice
                End If

            Case Screen.FreeEntry
                mCurrentScreen = Screen.Done
            Case Screen.Done
                mCurrentScreen = Screen.None
        End Select

    End Sub

    Public Sub Back()
        mCurrentScreen = mPreviousScreen
    End Sub


End Class


Public Module Util



    Public Sub ShowForm(ByVal state As State, ByVal logger As Logger)


        If My.Settings.ClearClipboard Then
            Clipboard.Clear()
        End If

        logger.Log(state.CurrentScreen.ToString)

        Select Case state.CurrentScreen

            Case KeystrokeLogger.State.Screen.Practice
                Dim practice = New Practice
                practice.WireState(state)
                practice.WireLogger(logger)
                ShowForm(practice)

            Case KeystrokeLogger.State.Screen.Verify
                Dim verify = New Verify
                verify.WireState(state)
                verify.WireLogger(logger)
                ShowForm(verify)

            Case KeystrokeLogger.State.Screen.Memorize
                Dim memorize = New Memorize
                memorize.WireState(state)
                memorize.WireLogger(logger)
                ShowForm(memorize)

            Case KeystrokeLogger.State.Screen.FreeEntry
                Dim freeEntry = New FreeEntry
                freeEntry.WireState(state)
                freeEntry.WireLogger(logger)
                ShowForm(freeEntry)


        End Select
    End Sub


    Private Sub ShowForm(ByVal form As Form)
        form.StartPosition = FormStartPosition.CenterScreen
        form.Show()
        form.TopMost = True
        form.WindowState = FormWindowState.Normal
        form.BringToFront()
        form.Activate()
    End Sub

End Module
