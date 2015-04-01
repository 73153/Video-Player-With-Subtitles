

Public Class KeystokeLoggerTextBox

    Private mLogger As Logger

    Public Property LogName As String

    Public Property TargetString As String

    Public ReadOnly Property Match As Boolean
        Get
            Return TargetString = TextBox.Text
        End Get
    End Property

    Public Property Mask As Boolean
        Get
            Return TextBox.PasswordChar = "*"
        End Get
        Set(value As Boolean)
            If value = True Then
                TextBox.PasswordChar = "*"
            Else
                TextBox.PasswordChar = String.Empty
            End If
            TextBox.Refresh()
        End Set
    End Property

    Private mState As State
    Public Sub WireDependencies(ByVal logger As Logger, ByVal state As State)
        mLogger = logger
        mState = state
    End Sub

    Public Property Multiline As Boolean
        Get
            Return TextBox.Multiline
        End Get
        Set(value As Boolean)
            TextBox.Multiline = value
        End Set
    End Property


    Private Sub TextBox_TextChanged(sender As System.Object, e As System.EventArgs) Handles TextBox.TextChanged
        RaiseEvent TextChanged(Me, e)
    End Sub

    Private Sub TextBox_KeyPress(sender As Object, e As KeyPressEventArgs) Handles TextBox.KeyPress
        If e.KeyChar = Microsoft.VisualBasic.ChrW(Keys.Return) Then
            RaiseEvent EnterKeyPress(Me, e)
        End If
    End Sub

    Private Sub TextBox_KeyDown(sender As Object, e As KeyEventArgs) Handles TextBox.KeyDown
        Dim logString = mLogger.BuildString(LogName, "D", e.KeyCode.ToString, TextBox.Text, mState)
        mLogger.Log(logString)
    End Sub

    Private Sub TextBox_KeyUp(sender As Object, e As KeyEventArgs) Handles TextBox.KeyUp
        Dim logString = mLogger.BuildString(LogName, "U", e.KeyCode.ToString, TextBox.Text, mState)
        mLogger.Log(logString)
    End Sub

    Shadows Event TextChanged As EventHandler(Of EventArgs)
    Public Event EnterKeyPress As EventHandler(Of KeyPressEventArgs)
End Class
