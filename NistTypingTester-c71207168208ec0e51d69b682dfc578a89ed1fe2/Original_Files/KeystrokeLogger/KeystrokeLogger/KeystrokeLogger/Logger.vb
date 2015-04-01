Public Class Logger

    Public Property Filename As String
    Public Property ParticipantId As String


    Private mStopwatch As Stopwatch

    Public Sub WireStopwatch(ByVal sw As Stopwatch)
        mStopwatch = sw
    End Sub


    Public ReadOnly Property Timestamp As Integer
        Get
            Return mStopwatch.ElapsedMilliseconds
        End Get
    End Property

    Public Function BuildString(ByVal logName As String, ByVal updown As String, ByVal key As String, ByVal currentText As String, ByVal state As State)

        Dim ts = mStopwatch.ElapsedMilliseconds
        If state IsNot Nothing Then
            Return String.Format("{1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}",
                                 ts, ParticipantId, state.CurrentLoop, logName, updown, key, currentText, state.TargetString, currentText = state.TargetString)
        Else
            Return String.Format("{1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}",
                                 ts, ParticipantId, state.CurrentLoop, logName, updown, key, currentText, String.Empty, String.Empty)
        End If
        

    End Function

    Public Sub Log(ByVal toLog As String)
        Dim ts = mStopwatch.ElapsedMilliseconds
        My.Computer.FileSystem.WriteAllText(Filename, ts & ", " & toLog & vbNewLine, True)
    End Sub



End Class
