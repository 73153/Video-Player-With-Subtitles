<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class KeystokeLoggerTextBox
    Inherits System.Windows.Forms.UserControl

    'UserControl overrides dispose to clean up the component list.
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
        Me.TextBox = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'TextBox
        '
        Me.TextBox.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TextBox.Location = New System.Drawing.Point(0, 0)
        Me.TextBox.Name = "TextBox"
        Me.TextBox.Size = New System.Drawing.Size(196, 36)
        Me.TextBox.TabIndex = 0
        '
        'KeystokeLoggerTextBox
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(13.0!, 28.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.Controls.Add(Me.TextBox)
        Me.Font = New System.Drawing.Font("Consolas", 18.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Margin = New System.Windows.Forms.Padding(7, 6, 7, 6)
        Me.Name = "KeystokeLoggerTextBox"
        Me.Size = New System.Drawing.Size(196, 36)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TextBox As System.Windows.Forms.TextBox

End Class
