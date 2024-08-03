function Scan-Ports {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [array]$Ports = @("443","80","90"),
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$Target = "ercanese.com"
    )

    begin 
    {
        $result = @()
        $Progress = 100 / $Ports.Count
    }
    process {
            $rProg = 0
        $Result += foreach($port in $Ports){
            $rProg += $Progress
            
            #Test-NetConnection -Port $port -ComputerName $Target
            $r = [System.Net.Sockets.TcpClient]::new()
            $null = $r.ConnectAsync($Target,$port).Wait(3000) 
            
            
            #Write-Progress -Activity "TCP Port Scanning host : $Target" -Status "Scanning : $port" -PercentComplete $rProg 

            
            #$r | Add-Member -MemberType NoteProperty -Name Target -Value $Target 
            #Write-Output $r


            Write-Output ([pscustomobject]@{
                HostName = $Target
                Result   = $r.Connected
                Port    = $Port 
            })
            Write-Progress -Activity "TCP Port Scanning host : $Target" -Status "Scanning : $port Status $($r.Connected)" -PercentComplete $rProg 
           
        }
    }
    end 
    {
        $result 
    }
    
}




"ercanese.com","bilgeadam.com" | Scan-Ports -Ports (@(@(79..89),@(441..444)).ForEach({$_}))
