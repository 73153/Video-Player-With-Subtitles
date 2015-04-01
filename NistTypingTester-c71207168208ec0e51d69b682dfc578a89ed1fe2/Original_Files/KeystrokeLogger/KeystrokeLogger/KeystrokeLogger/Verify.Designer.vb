<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Verify
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
        Me.HeaderLabel = New System.Windows.Forms.Label()
        Me.FooterPanel = New System.Windows.Forms.Panel()
        Me.NextButton = New System.Windows.Forms.Button()
        Me.BackButton = New System.Windows.Forms.Button()
        Me.MainFlowLayoutPanel = New System.Windows.Forms.FlowLayoutPanel()
        Me.MainKeystokeLoggerTextBox = New KeystrokeLogger.KeystokeLoggerTextBox()
        Me.VerifyButton = New System.Windows.Forms.Button()
        Me.VerifyLabel = New System.Windows.Forms.Label()
        Me.MainTableLayoutPanel.SuspendLayout()
        Me.FooterPanel.SuspendLayout()
        Me.MainFlowLayoutPanel.SuspendLayout()
        Me.SuspendLayout()
        '
        'MainTableLayoutPanel
        '
        Me.MainTableLayoutPanel.Anchor = System.Windows.Forms.AnchorStyles.Bottom
        Me.MainTableLayoutPanel.ColumnCount = 1
        Me.MainTableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.MainTableLayoutPanel.Controls.Add(Me.HeaderLabel, 0, 0)
        Me.MainTableLayoutPanel.Controls.Add(Me.FooterPanel, 0, 2)
        Me.MainTableLayoutPanel.Controls.Add(Me.MainFlowLayoutPanel, 0, 1)
        Me.MainTableLayoutPanel.Location = New System.Drawing.Point(0, 0)
        Me.MainTableLayoutPanel.Margin = New System.Windows.Forms.Padding(10, 3, 3, 3)
        Me.MainTableLayoutPanel.Name = "MainTableLayoutPanel"
        Me.MainTableLayoutPanel.RowCount = 3
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 258.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.MainTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 44.0!))
        Me.MainTableLayoutPanel.Size = New System.Drawing.Size(584, 562)
        Me.MainTableLayoutPanel.TabIndex = 0
        '
        'HeaderLabel
        '
        Me.HeaderLabel.AutoSize = True
        Me.HeaderLabel.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.HeaderLabel.Font = New System.Drawing.Font("Calibri", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.HeaderLabel.Location = New System.Drawing.Point(3, 235)
        Me.HeaderLabel.Name = "HeaderLabel"
        Me.HeaderLabel.Padding = New System.Windows.Forms.Padding(10, 0, 0, 0)
        Me.HeaderLabel.Size = New System.Drawing.Size(578, 23)
        Me.HeaderLabel.TabIndex = 9
        Me.HeaderLabel.Text = "Please type in the character string without referring to the paper:"
        Me.HeaderLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'FooterPanel
        '
        Me.FooterPanel.Controls.Add(Me.NextButton)
        Me.FooterPanel.Controls.Add(Me.BackButton)
        Me.FooterPanel.Dock = System.Windows.Forms.DockStyle.Fill
        Me.FooterPanel.Location = New System.Drawing.Point(3, 521)
        Me.FooterPanel.Name = "FooterPanel"
        Me.FooterPanel.Size = New System.Drawing.Size(578, 38)
        Me.FooterPanel.TabIndex = 0
        '
        'NextButton
        '
        Me.NextButton.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.NextButton.Enabled = False
        Me.NextButton.Font = New System.Drawing.Font("Calibri", 14.25!)
        Me.NextButton.Location = New System.Drawing.Point(419, 2)
        Me.NextButton.Name = "NextButton"
        Me.NextButton.Size = New System.Drawing.Size(156, 33)
        Me.NextButton.TabIndex = 7
        Me.NextButton.Text = "Start the Test >"
        Me.NextButton.UseVisualStyleBackColor = True
        '
        'BackButton
        '
        Me.BackButton.Anchor = System.Windows.Forms.AnchorStyles.Left
        Me.BackButton.Font = New System.Drawing.Font("Calibri", 14.25!)
        Me.BackButton.Location = New System.Drawing.Point(3, 1)
        Me.BackButton.Name = "BackButton"
        Me.BackButton.Size = New System.Drawing.Size(156, 33)
        Me.BackButton.TabIndex = 6
        Me.BackButton.Text = "< Practice More"
        Me.BackButton.UseVisualStyleBackColor = True
        '
        'MainFlowLayoutPanel
        '
        Me.MainFlowLayoutPanel.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.MainFlowLayoutPanel.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.MainFlowLayoutPanel.Controls.Add(Me.MainKeystokeLoggerTextBox)
        Me.MainFlowLayoutPanel.Controls.Add(Me.VerifyButton)
        Me.MainFlowLayoutPanel.Controls.Add(Me.VerifyLabel)
        Me.MainFlowLayoutPanel.Location = New System.Drawing.Point(9, 278)
        Me.MainFlowLayoutPanel.Margin = New System.Windows.Forms.Padding(0, 20, 0, 0)
        Me.MainFlowLayoutPanel.Name = "MainFlowLayoutPanel"
        Me.MainFlowLayoutPanel.Size = New System.Drawing.Size(566, 115)
        Me.MainFlowLayoutPanel.TabIndex = 10
        '
        'MainKeystokeLoggerTextBox
        '
        Me.MainKeystokeLoggerTextBox.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.MainKeystokeLoggerTextBox.Font = New System.Drawing.Font("Consolas", 18.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.MainKeystokeLoggerTextBox.Location = New System.Drawing.Point(0, 3)
        Me.MainKeystokeLoggerTextBox.LogName = Nothing
        Me.MainKeystokeLoggerTextBox.Margin = New System.Windows.Forms.Padding(0)
        Me.MainKeystokeLoggerTextBox.Mask = False
        Me.MainKeystokeLoggerTextBox.Name = "MainKeystokeLoggerTextBox"
        Me.MainKeystokeLoggerTextBox.Size = New System.Drawing.Size(441, 33)
        Me.MainKeystokeLoggerTextBox.TabIndex = 0
        Me.MainKeystokeLoggerTextBox.TargetString = Nothing
        '
        'VerifyButton
        '
        Me.VerifyButton.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.VerifyButton.Font = New System.Drawing.Font("Calibri", 14.25!)
        Me.VerifyButton.Location = New System.Drawing.Point(451, 3)
        Me.VerifyButton.Margin = New System.Windows.Forms.Padding(10, 3, 10, 3)
        Me.VerifyButton.Name = "VerifyButton"
        Me.VerifyButton.Size = New System.Drawing.Size(104, 33)
        Me.VerifyButton.TabIndex = 8
        Me.VerifyButton.Text = "Verify"
        Me.VerifyButton.UseVisualStyleBackColor = True
        '
        'VerifyLabel
        '
        Me.VerifyLabel.Font = New System.Drawing.Font("Calibri", 20.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.VerifyLabel.Location = New System.Drawing.Point(10, 39)
        Me.VerifyLabel.Margin = New System.Windows.Forms.Padding(10, 0, 10, 0)
        Me.VerifyLabel.Name = "VerifyLabel"
        Me.VerifyLabel.Size = New System.Drawing.Size(545, 44)
        Me.VerifyLabel.TabIndex = 10
        Me.VerifyLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Verify
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(584, 562)
        Me.Controls.Add(Me.MainTableLayoutPanel)
        Me.Name = "Verify"
        Me.Text = "Verify"
        Me.MainTableLayoutPanel.ResumeLayout(False)
        Me.MainTableLayoutPanel.PerformLayout()
        Me.FooterPanel.ResumeLayout(False)
        Me.MainFlowLayoutPanel.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents MainTableLayoutPanel As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents FooterPanel As System.Windows.Forms.Panel
    Friend WithEvents NextButton As System.Windows.Forms.Button
    Friend WithEvents BackButton As System.Windows.Forms.Button
    Friend WithEvents HeaderLabel As System.Windows.Forms.Label
    Friend WithEvents MainFlowLayoutPanel As System.Windows.Forms.FlowLayoutPanel
    Friend WithEvents MainKeystokeLoggerTextBox As KeystrokeLogger.KeystokeLoggerTextBox
    Friend WithEvents VerifyButton As System.Windows.Forms.Button
    Friend WithEvents VerifyLabel As System.Windows.Forms.Label
End Class
