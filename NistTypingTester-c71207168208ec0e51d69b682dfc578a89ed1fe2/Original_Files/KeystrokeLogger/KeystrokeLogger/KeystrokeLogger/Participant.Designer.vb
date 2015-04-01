<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Participant
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
        Me.MainTableLayoutPanel = New System.Windows.Forms.TableLayoutPanel()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ParticipantTextBox = New System.Windows.Forms.TextBox()
        Me.OKButton = New System.Windows.Forms.Button()
        Me.MainTableLayoutPanel.SuspendLayout()
        Me.SuspendLayout()
        '
        'MainTableLayoutPanel
        '
        Me.MainTableLayoutPanel.ColumnCount = 1
        Me.MainTableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.MainTableLayoutPanel.Controls.Add(Me.Label1, 0, 0)
        Me.MainTableLayoutPanel.Controls.Add(Me.ParticipantTextBox, 0, 1)
        Me.MainTableLayoutPanel.Controls.Add(Me.OKButton, 0, 2)
        Me.MainTableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill
        Me.MainTableLayoutPanel.Location = New System.Drawing.Point(0, 0)
        Me.MainTableLayoutPanel.Name = "MainTableLayoutPanel"
        Me.MainTableLayoutPanel.RowCount = 3
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 46.0076!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 53.9924!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 38.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.MainTableLayoutPanel.Size = New System.Drawing.Size(300, 302)
        Me.MainTableLayoutPanel.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.Anchor = System.Windows.Forms.AnchorStyles.Bottom
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Calibri", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(103, 98)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(94, 23)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Participant"
        '
        'ParticipantTextBox
        '
        Me.ParticipantTextBox.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.ParticipantTextBox.Font = New System.Drawing.Font("Consolas", 18.0!)
        Me.ParticipantTextBox.Location = New System.Drawing.Point(109, 124)
        Me.ParticipantTextBox.Name = "ParticipantTextBox"
        Me.ParticipantTextBox.Size = New System.Drawing.Size(82, 36)
        Me.ParticipantTextBox.TabIndex = 1
        Me.ParticipantTextBox.Text = "0"
        Me.ParticipantTextBox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'OKButton
        '
        Me.OKButton.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.OKButton.Font = New System.Drawing.Font("Calibri", 14.25!)
        Me.OKButton.Location = New System.Drawing.Point(112, 266)
        Me.OKButton.Name = "OKButton"
        Me.OKButton.Size = New System.Drawing.Size(75, 33)
        Me.OKButton.TabIndex = 2
        Me.OKButton.Text = "OK"
        Me.OKButton.UseVisualStyleBackColor = True
        '
        'Participant
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(300, 302)
        Me.Controls.Add(Me.MainTableLayoutPanel)
        Me.Name = "Participant"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Participant"
        Me.MainTableLayoutPanel.ResumeLayout(False)
        Me.MainTableLayoutPanel.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents MainTableLayoutPanel As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents ParticipantTextBox As System.Windows.Forms.TextBox
    Friend WithEvents OKButton As System.Windows.Forms.Button
End Class
