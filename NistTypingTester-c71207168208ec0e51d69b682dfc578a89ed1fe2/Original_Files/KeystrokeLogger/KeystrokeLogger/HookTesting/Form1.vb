Public Class Form1

    Private mStopwatch As Stopwatch = Stopwatch.StartNew

    Private WithEvents keyHook As New KeyboardHook
    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub KeyHook_Down(ByVal key As Keys) Handles keyHook.KeyDown
        My.Computer.FileSystem.WriteAllText("c:\tmp\out", "H " & key.ToString & " " & mStopwatch.ElapsedMilliseconds & vbNewLine, True)
    End Sub

    Private Sub TextBox1_KeyDown(sender As System.Object, e As KeyEventArgs) Handles TextBox1.KeyDown
        My.Computer.FileSystem.WriteAllText("c:\tmp\out", "N " & e.KeyCode.ToString & " " & mStopwatch.ElapsedMilliseconds & vbNewLine, True)
    End Sub
End Class
