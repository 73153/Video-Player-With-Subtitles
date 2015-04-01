<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Practice
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
        Me.Label3 = New System.Windows.Forms.Label()
        Me.HeaderLabel = New System.Windows.Forms.Label()
        Me.FooterLabel = New System.Windows.Forms.Label()
        Me.NextButton = New System.Windows.Forms.Button()
        Me.TargetStringLabel = New System.Windows.Forms.Label()
        Me.LoggerTextBox = New KeystrokeLogger.KeystokeLoggerTextBox()
        Me.MainTableLayoutPanel.SuspendLayout()
        Me.SuspendLayout()
        '
        'MainTableLayoutPanel
        '
        Me.MainTableLayoutPanel.ColumnCount = 1
        Me.MainTableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50.0!))
        Me.MainTableLayoutPanel.Controls.Add(Me.Label3, 0, 2)
        Me.MainTableLayoutPanel.Controls.Add(Me.HeaderLabel, 0, 0)
        Me.MainTableLayoutPanel.Controls.Add(Me.FooterLabel, 0, 4)
        Me.MainTableLayoutPanel.Controls.Add(Me.NextButton, 0, 5)
        Me.MainTableLayoutPanel.Controls.Add(Me.LoggerTextBox, 0, 3)
        Me.MainTableLayoutPanel.Controls.Add(Me.TargetStringLabel, 0, 1)
        Me.MainTableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill
        Me.MainTableLayoutPanel.Location = New System.Drawing.Point(0, 0)
        Me.MainTableLayoutPanel.Name = "MainTableLayoutPanel"
        Me.MainTableLayoutPanel.RowCount = 6
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 47.22222!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 52.77778!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 58.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 330.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 47.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 41.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.MainTableLayoutPanel.Size = New System.Drawing.Size(584, 562)
        Me.MainTableLayoutPanel.TabIndex = 0
        '
        'Label3
        '
        Me.Label3.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Calibri", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(11, 91)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(561, 46)
        Me.Label3.TabIndex = 8
        Me.Label3.Text = "If you need some space to help you memorize the string, please use the space belo" & _
    "w:"
        '
        'HeaderLabel
        '
        Me.HeaderLabel.Anchor = System.Windows.Forms.AnchorStyles.Bottom
        Me.HeaderLabel.AutoSize = True
        Me.HeaderLabel.Font = New System.Drawing.Font("Calibri", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.HeaderLabel.Location = New System.Drawing.Point(100, 17)
        Me.HeaderLabel.Name = "HeaderLabel"
        Me.HeaderLabel.Size = New System.Drawing.Size(383, 23)
        Me.HeaderLabel.TabIndex = 6
        Me.HeaderLabel.Text = "Character string {0} of {1} memorization practice"
        '
        'FooterLabel
        '
        Me.FooterLabel.Anchor = System.Windows.Forms.AnchorStyles.Bottom
        Me.FooterLabel.AutoSize = True
        Me.FooterLabel.Font = New System.Drawing.Font("Calibri", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FooterLabel.Location = New System.Drawing.Point(12, 474)
        Me.FooterLabel.Name = "FooterLabel"
        Me.FooterLabel.Size = New System.Drawing.Size(560, 46)
        Me.FooterLabel.TabIndex = 5
        Me.FooterLabel.Text = "When you think you have memorized the string completely, please turn over the pag" & _
    "e and move to the next screen."
        '
        'NextButton
        '
        Me.NextButton.Dock = System.Windows.Forms.DockStyle.Right
        Me.NextButton.Font = New System.Drawing.Font("Calibri", 14.25!)
        Me.NextButton.Location = New System.Drawing.Point(506, 523)
        Me.NextButton.Name = "NextButton"
        Me.NextButton.Size = New System.Drawing.Size(75, 36)
        Me.NextButton.TabIndex = 3
        Me.NextButton.Text = "Next"
        Me.NextButton.UseVisualStyleBackColor = True
        '
        'TargetStringLabel
        '
        Me.TargetStringLabel.AutoSize = True
        Me.TargetStringLabel.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TargetStringLabel.Font = New System.Drawing.Font("Consolas", 18.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TargetStringLabel.Location = New System.Drawing.Point(3, 40)
        Me.TargetStringLabel.Name = "TargetStringLabel"
        Me.TargetStringLabel.Size = New System.Drawing.Size(578, 45)
        Me.TargetStringLabel.TabIndex = 12
        Me.TargetStringLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'LoggerTextBox
        '
        Me.LoggerTextBox.Font = New System.Drawing.Font("Consolas", 18.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LoggerTextBox.Location = New System.Drawing.Point(7, 149)
        Me.LoggerTextBox.LogName = Nothing
        Me.LoggerTextBox.Margin = New System.Windows.Forms.Padding(7, 6, 7, 6)
        Me.LoggerTextBox.Mask = False
        Me.LoggerTextBox.Multiline = True
        Me.LoggerTextBox.Name = "LoggerTextBox"
        Me.LoggerTextBox.Size = New System.Drawing.Size(570, 318)
        Me.LoggerTextBox.TabIndex = 11
        Me.LoggerTextBox.TargetString = Nothing
        '
        'Practice
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(584, 562)
        Me.Controls.Add(Me.MainTableLayoutPanel)
        Me.Name = "Practice"
        Me.Text = "Practice"
        Me.MainTableLayoutPanel.ResumeLayout(False)
        Me.MainTableLayoutPanel.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents MainTableLayoutPanel As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents NextButton As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents HeaderLabel As System.Windows.Forms.Label
    Friend WithEvents FooterLabel As System.Windows.Forms.Label
    Friend WithEvents LoggerTextBox As KeystrokeLogger.KeystokeLoggerTextBox
    Friend WithEvents TargetStringLabel As System.Windows.Forms.Label
End Class
