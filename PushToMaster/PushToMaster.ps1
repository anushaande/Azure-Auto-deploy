<#   
================================================================================ 
 Name:         PushToMaster.ps1 
 Purpose:      Replicate all the changes of dev-branch to master. 
 Author:       Anusha Ande – anushaande@health.usf.edu
 Description: 
 
 Syntax/Execution: Execute this script having all the powershell files in a single 
 folder 
 Disclaimer:      Follow all the instructions carefully. Else, there is a high chance 
                 that code gets spoiled.
 Limitations:  

# video of Script:
 
 ================================================================================ 
 #>
 #!/bin/bash
 
 Add-Type -Assembly System.Windows.Forms     ## Load the Windows Forms assembly 
 ## Create the main form 
 Write-Host "Create form" (Get-Date)  
 $form = New-Object Windows.Forms.Form 
$form.FormBorderStyle = "FixedToolWindow" 
$form.Text = "PowerShell Custom GUI Window" 
$form.StartPosition = "CenterScreen" 
$form.Width = 740 ; $form.Height = 380  # Make the form wider 