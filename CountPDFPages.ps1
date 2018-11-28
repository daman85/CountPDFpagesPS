<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 320
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(13,41)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "0"
$Label1.AutoSize                 = $true
$Label1.TextAlign                = "MiddleCenter"
$Label1.width                    = 375
$Label1.height                   = 257
$Label1.location                 = New-Object System.Drawing.Point(14,122)
$Label1.Font                     = 'Microsoft Sans Serif,30'




$COUNT                           = New-Object system.Windows.Forms.Button
$COUNT.text                      = "COUNT"
$COUNT.width                     = 70
$COUNT.height                    = 30
$COUNT.location                  = New-Object System.Drawing.Point(160,74)
$COUNT.Font                      = 'Microsoft Sans Serif,10'

$Folder                          = New-Object system.Windows.Forms.Button
$Folder.text                     = "folder"
$Folder.width                    = 47
$Folder.height                   = 25
$Folder.location                 = New-Object System.Drawing.Point(338,40)
$Folder.Font                     = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox1,$Label1,$ListView1,$COUNT,$Folder))


$COUNT.Add_Click({ 

$total = 0
$result = @()

$path = $TextBox1.text
dir $path\*.pdf | foreach-object{

Try{

$pdf = pdftk.exe $_.FullName dump_data
$NumberOfPages = [regex]::match($pdf,'NumberOfPages: (\d+)').Groups[1].Value

$details = @{
NumberOfPages = $NumberOfPages 
Name = $_.Name
}
$result += New-Object PSObject -Property $details 
$total += $NumberOfPages
}

Catch{
    Write-Host $_.Exception.Message
}

}


$Label1.text = $total

 })
$Folder.Add_Click({ 
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    
    [void]$FolderBrowser.ShowDialog()
    $TextBox1.Text = $FolderBrowser.SelectedPath
 })


[void]$Form.ShowDialog()

