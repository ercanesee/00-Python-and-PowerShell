using namespace Net.Codecrete.QrCodeGenerator
function Create-QR {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$QrString,
        [int]$Border=1,
        [int]$Scale=10,
        [string]$OutPath= $pwd
    )
    begin {
        Add-Type -Path "$(Split-Path -Parent $MyInvocation.PSCommandPath)\QrCodeGenerator.dll"
        [System.Collections.Generic.List[object]]$Qrs = @()
    }

    process {
        $qr = [Net.Codecrete.QrCodeGenerator.QrCode]::EncodeText(
            $QrString,
            [Net.Codecrete.QrCodeGenerator.QrCode+Ecc]::Medium
        )
        $Qrs.Add([pscustomobject]@{
            Name = $QrString.Split("//")[-1]
            QR = $qr.ToBmpBitmap(
                $Border,
                $Scale
            )
        })


    }

    end {
        foreach($qrr in $Qrs){
            [System.Drawing.Image]$Image = $qrr.qr
            $Image.Save("$OutPath\$($qrr.Name).png")
        }
    }
    
}



"https://ercanese.com","https://x.com" | 
    Create-QR -Border 1 -Scale 10 -OutPath "C:\Users\EE\My Drive\Python Project\Barcode Scanner"