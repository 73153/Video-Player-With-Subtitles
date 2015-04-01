<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class PracticeLabelDesignTimeSandbox
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.PracticeLabel1 = New KeystrokeLogger.PracticeLabel()
        Me.SuspendLayout()
        '
        'PracticeLabel1
        '
        Me.PracticeLabel1.AutoSize = True
        Me.PracticeLabel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PracticeLabel1.Font = New System.Drawing.Font("Consolas", 18.0!)
        Me.PracticeLabel1.Location = New System.Drawing.Point(0, 0)
        Me.PracticeLabel1.Margin = New System.Windows.Forms.Padding(7, 6, 7, 6)
        Me.PracticeLabel1.Name = "PracticeLabel1"
        Me.PracticeLabel1.Size = New System.Drawing.Size(530, 174)
        Me.PracticeLabel1.TabIndex = 2
        Me.PracticeLabel1.TargetString = "abcd1234"
        '
        'PracticeLabelDesignTimeSandbox
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(530, 174)
        Me.Controls.Add(Me.PracticeLabel1)
        Me.Name = "PracticeLabelDesignTimeSandbox"
        Me.Text = "PracticeLabelDesignTimeSandbox"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents PracticeLabel1 As KeystrokeLogger.PracticeLabel
End Class
