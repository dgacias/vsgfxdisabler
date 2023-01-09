write-host "Loading, please wait..."
Add-Type -AssemblyName System.Windows.Forms

if (!(Test-Path -Path items_backup.json)) {
    Copy-Item "items.json" -Destination "items_backup.json"
}

if (!(Test-Path -Path vfx_backup.json)) {
    Copy-Item "vfx.json" -Destination "vfx_backup.json"
}

$items = Get-Content -Path .\items.json | ConvertFrom-Json
$image = [System.Drawing.Image]::FromFile("items.png")
$items2 = Get-Content -Path .\vfx.json | ConvertFrom-Json
$image2 = [System.Drawing.Image]::FromFile("vfx.png")
$units = [System.Drawing.GraphicsUnit]::Pixel
$winW = 1024
$winH = 768

#General Form
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size($winW,$winH)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.Text = "Vampire Survivors GFX disabler"

#Scrollable checkbox panel 1
$flowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$flowPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$flowPanel.AutoScroll = $true
$flowPanel.AutoSize = $true
$flowPanel.BackColor = “white”


#Scrollable checkbox panel 2
$flowPanel2 = New-Object System.Windows.Forms.FlowLayoutPanel
$flowPanel2.Dock = [System.Windows.Forms.DockStyle]::Fill
$flowPanel2.AutoScroll = $true
$flowPanel2.AutoSize = $true
$flowPanel2.BackColor = “white”

#LeftFrame1
$leftFrame = New-Object System.Windows.Forms.GroupBox
$leftFrame.Text = "Items"
$leftFrame.Size = New-Object System.Drawing.Size(($winW/2-10),($winH/2-40))
$leftFrame.Location = New-Object System.Drawing.Size(10,0)
$leftFrame.Controls.Add($flowPanel)
$form.Controls.Add($leftFrame)

#LeftFrame2
$leftFrame2 = New-Object System.Windows.Forms.GroupBox
$leftFrame2.Text = "VFX"
$leftFrame2.Size = New-Object System.Drawing.Size(($winW/2-10),($winH/2-40))
$leftFrame2.Location = New-Object System.Drawing.Size(10,($winH/2-20))
$leftFrame2.Controls.Add($flowPanel2)
$form.Controls.Add($leftFrame2)

#RightFrame
$rightFrame = New-Object System.Windows.Forms.GroupBox
$rightFrame.Text = "Actions"
$rightFrame.Size = New-Object System.Drawing.Size(($winW/2-10),($winH-60))
$rightFrame.Location = New-Object System.Drawing.Size(($winW/2),0)
$form.Controls.Add($rightFrame)

foreach ($texture in $items.textures.frames) {
    #Image
    $partialImage = New-Object System.Drawing.Bitmap @($texture.sourceSize.w, $texture.sourceSize.h)
    $graphics = [System.Drawing.Graphics]::FromImage($partialImage)
    $rect = New-Object System.Drawing.Rectangle $texture.frame.x,$texture.frame.y,($texture.spriteSourceSize.w),($texture.spriteSourceSize.h)
    $graphics.DrawImage($image, 0, 0, $rect, $units)
    $pictureBox = New-Object System.Windows.Forms.PictureBox
    $pictureBox.Image = $partialImage
    
    #Checkbox
    $checkBox = New-Object System.Windows.Forms.CheckBox
    $checkBox.Name = $texture.filename
    $checkBox.Size = New-Object System.Drawing.Size(80,80)
    $checkBox.BackgroundImage = $partialImage
    $checkbox.BackgroundImageLayout = "Zoom"
        if ($texture.frame.w -ne 0) {
        $checkBox.Checked = $true
    }
    else {
        $checkBox.Checked = $false
    }
    #Panel
    $Panel1 = New-Object System.Windows.Forms.Panel
    $Panel1.BorderStyle = "FixedSingle"
    $Panel1.AutoSize = $true
    $Panel1.Controls.Add($checkBox)
    $flowPanel.Controls.Add($Panel1)
}


foreach ($texture2 in $items2.textures.frames) {
    #Image
    $partialImage2 = New-Object System.Drawing.Bitmap @($texture2.sourceSize.w, $texture2.sourceSize.h)
    $graphics2 = [System.Drawing.Graphics]::FromImage($partialImage2)
    $rect2 = New-Object System.Drawing.Rectangle $texture2.frame.x,$texture2.frame.y,($texture2.spriteSourceSize.w),($texture2.spriteSourceSize.h)
    $graphics2.DrawImage($image2, 0, 0, $rect2, $units)
    $pictureBox2 = New-Object System.Windows.Forms.PictureBox
    $pictureBox2.Image = $partialImage2
    
    #Checkbox
    $checkBox2 = New-Object System.Windows.Forms.CheckBox
    $checkBox2.Name = $texture2.filename
    $checkBox2.Size = New-Object System.Drawing.Size(80,80)
    $checkBox2.BackgroundImage = $partialImage2
    $checkbox2.BackgroundImageLayout = "Zoom"
        if ($texture2.frame.w -ne 0) {
        $checkBox2.Checked = $true
    }
    else {
        $checkBox2.Checked = $false
    }
    #Panel
    $Panel2 = New-Object System.Windows.Forms.Panel
    $Panel2.BorderStyle = "FixedSingle"
    $Panel2.AutoSize = $true
    $Panel2.Controls.Add($checkBox2)
    $flowPanel2.Controls.Add($Panel2)
}



###BUTTONS###
#Select all items
$selectAllButton = New-Object System.Windows.Forms.Button
$selectAllButton.Text = "Select all items"
$selectAllButton.Location = New-Object System.Drawing.Size(10,50)
$selectAllButton.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$selectAllButton.Add_Click({
    $checkBoxes = $flowPanel.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox in $checkBoxes) {
        $checkBox.Checked = $true
    }
})
$rightFrame.Controls.Add($selectAllButton)

#Select none items
$selectNoneButton = New-Object System.Windows.Forms.Button
$selectNoneButton.Text = "Select none items"
$selectNoneButton.Location = New-Object System.Drawing.Size(10,100)
$selectNoneButton.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$selectNoneButton.Add_Click({
    $checkBoxes = $flowPanel.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox in $checkBoxes) {
        $checkBox.Checked = $false
    }
    $checkBoxes2 = $flowPanel2.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox2 in $checkBoxes2) {
        $checkBox2.Checked = $false
    }
})
$rightFrame.Controls.Add($selectNoneButton)


#Select all VFX
$selectAllButton2 = New-Object System.Windows.Forms.Button
$selectAllButton2.Text = "Select all VFX"
$selectAllButton2.Location = New-Object System.Drawing.Size(10,($winH/2))
$selectAllButton2.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$selectAllButton2.Add_Click({
    $checkBoxes2 = $flowPanel2.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox2 in $checkBoxes2) {
        $checkBox2.Checked = $true
    }
})
$rightFrame.Controls.Add($selectAllButton2)


#Select none VFX
$selectNoneButton2 = New-Object System.Windows.Forms.Button
$selectNoneButton2.Text = "Select none VFX"
$selectNoneButton2.Location = New-Object System.Drawing.Size(10,($winH/2+50))
$selectNoneButton2.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$selectNoneButton2.Add_Click({
    $checkBoxes2 = $flowPanel2.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox2 in $checkBoxes2) {
        $checkBox2.Checked = $false
    }
})
$rightFrame.Controls.Add($selectNoneButton2)


#Save
$saveButton = New-Object System.Windows.Forms.Button
$saveButton.Text = "Save (wait for notification)"
$saveButton.Location = New-Object System.Drawing.Size(10,($winH-200))
$saveButton.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$saveButton.Add_Click({
    $checkBoxes = $flowPanel.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox in $checkBoxes) {
        if (!$checkBox.Checked) {
            $texture = $items.textures.frames | Where-Object {$_.filename -eq $checkBox.Name}
            $texture.frame.w = 0
			$texture.frame.h = 0
        }
    }
    $items | ConvertTo-Json -Depth 100 | Set-Content -Path .\items.json

    $checkBoxes2 = $flowPanel2.Controls.Controls | Where-Object {$_.GetType().Name -eq "CheckBox"}
    foreach ($checkBox2 in $checkBoxes2) {
        if (!$checkBox2.Checked) {
            $texture2 = $items2.textures.frames | Where-Object {$_.filename -eq $checkBox2.Name}
            $texture2.frame.w = 0
			$texture2.frame.h = 0
        }
    }
    $items2 | ConvertTo-Json -Depth 100 | Set-Content -Path .\vfx.json

    #popup
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10,'Saved','Changes Saved correctly!',[system.windows.forms.tooltipicon]::None)

})
$rightFrame.Controls.Add($saveButton)


#Restore items
$restoreitemsButton = New-Object System.Windows.Forms.Button
$restoreitemsButton.Text = "Restore Original items.json file (wait for notification)"
$restoreitemsButton.Location = New-Object System.Drawing.Size(10,($winH-150))
$restoreitemsButton.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$restoreitemsButton.Add_Click({
    Copy-Item "items_backup.json" -Destination "items.json"
    #popup
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10,'Restored','items.json restored correctly!',[system.windows.forms.tooltipicon]::None)
})
$rightFrame.Controls.Add($restoreitemsButton)


#Restore VFX
$restorevfxButton = New-Object System.Windows.Forms.Button
$restorevfxButton.Text = "Restore Original vfx.json file (wait for notification)" 
$restorevfxButton.Location = New-Object System.Drawing.Size(10,($winH-100))
$restorevfxButton.Size = New-Object System.Drawing.Size(($winW/2-40),30)
$restorevfxButton.Add_Click({
    Copy-Item "vfx_backup.json" -Destination "vfx.json"
    #popup
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10,'Restored','vfx.json restored correctly!',[system.windows.forms.tooltipicon]::None)
})
$rightFrame.Controls.Add($restorevfxButton)


$form.ShowDialog()