$script:PSModuleAutoLoadingPreference = "None"
Import-Module -Name AudioDeviceCmdlets
if (Get-Module -ListAvailable -Name AudioDeviceCmdlets) {
	switch ($args[0]) {
		list {
			$audiodevices = Get-AudioDevice -List

			Foreach($audiodevice in $audiodevices) {
				if ($audiodevice.Type -eq 'Playback') {
					Write-Host $audiodevice.Name
					Write-Host $audiodevice.Id
				}
			}
		}
		set {
			if ($args[1]) {
				$result = Set-AudioDevice -ID $args[1] -DefaultOnly
				Write-Host $result.Default
			}
		}

		get {
			$result = Get-AudioDevice -Playback
			Write-Host $result.Id
		}

		default {
			Write-Host "speakerSwitcher <get/set/list> [ID]"
		}
	}
}
else {
    Write-Warning "Module does not exist"
	if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
		Write-Warning "Please run this script as an administrator to install the module"
	} else {
		Write-Host "Installation du module en cours ..."
		Install-Module -Name AudioDeviceCmdlets
	}
}
