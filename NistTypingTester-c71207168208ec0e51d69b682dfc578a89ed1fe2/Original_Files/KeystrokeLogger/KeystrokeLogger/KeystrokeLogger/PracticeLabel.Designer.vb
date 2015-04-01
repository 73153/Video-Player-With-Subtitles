<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class PracticeLabel
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
        Me.FlowLayoutPanel = New System.Windows.Forms.FlowLayoutPanel()
        Me.SuspendLayout()
        '
        'FlowLayoutPanel
        '
        Me.FlowLayoutPanel.AutoSize = True
        Me.FlowLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill
        Me.FlowLayoutPanel.Font = New System.Drawing.Font("Consolas", 18.0!)
        Me.FlowLayoutPanel.Location = New System.Drawing.Point(0, 0)
        Me.FlowLayoutPanel.Name = "FlowLayoutPanel"
        Me.FlowLayoutPanel.Size = New System.Drawing.Size(448, 152)
        Me.FlowLayoutPanel.TabIndex = 1
        '
        'PracticeLabel
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.Controls.Add(Me.FlowLayoutPanel)
        Me.Name = "PracticeLabel"
        Me.Size = New System.Drawing.Size(448, 152)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents FlowLayoutPanel As System.Windows.Forms.FlowLayoutPanel

End Class
