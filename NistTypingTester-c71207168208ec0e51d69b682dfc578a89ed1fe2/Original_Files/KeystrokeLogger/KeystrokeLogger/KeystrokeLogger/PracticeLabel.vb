Public Class PracticeLabel


    Private mTargetString As String
    Public Property TargetString As String
        Get
            Return mTargetString
        End Get
        Set(ByVal value As String)
            mTargetString = value
            If value IsNot Nothing Then
                PopulateTargetString()
            End If
        End Set
    End Property

    Private Sub PopulateTargetString()
    End Sub


    'Private Sub PopulateTargetString()

    '    Dim charWidth As Integer = 14

    '    FlowLayoutPanel.Controls.Clear()
    '    For i As Integer = 0 To mTargetString.Length - 1


    '        Dim label As New Label()
    '        Dim character As Char = mTargetString(i)

    '        label.BackColor = Color.Transparent
    '        label.Name = "Label" & i.ToString
    '        label.Text = character
    '        label.Size = New Size(charWidth, 40)
    '        label.Margin = New Padding(0)
    '        label.BorderStyle = Windows.Forms.BorderStyle.None
    '        label.TextAlign = ContentAlignment.MiddleCenter
    '        FlowLayoutPanel.Controls.Add(label)

    '        If i <> 0 Then
    '            label.Margin = New Padding(0)
    '        Else
    '            Dim leftPadding = Math.Max(0, CInt((Me.Width - charWidth * mTargetString.Length) / 2))
    '            label.Margin = New Padding(leftPadding, 0, 0, 0)

    '        End If


    '        If Char.IsDigit(character) Then
    '            Dim tt As New ToolTip
    '            tt.InitialDelay = 0
    '            tt.SetToolTip(label, "Number '" & character & "'")
    '        End If

    '        If Char.IsLetter(character) Then
    '            Dim tt As New ToolTip
    '            tt.InitialDelay = 0
    '            tt.SetToolTip(label, "Letter '" & character & "'")

    '        End If







    '    Next



    'End Sub

End Class

