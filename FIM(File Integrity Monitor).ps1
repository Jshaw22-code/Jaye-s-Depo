


Write-Host ""
Write-Host "What would you like to do?"
Write-Host "A) Collect New Baseline?"
Write-Host "B) Begin  monitoring files with saved Baseline?"

$response = Read-Host -Prompt "Please enter 'A' or 'B'"
Write-Host ""

Function Calculate-File-Hash($filepath){
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

Function Erase-Baseline-If-Already-Exists() {
 $baselineExists = Test-Path -Path .\baseline.txt

 if ($baselineExists) {
 Remove-Item -Path .\baseline.txt
 }
}


if ($response -eq "A") {
    Erase-Baseline-If-Already-Exists
    $files =  Get-ChildItem -Path .\Documents
    foreach ($f in $files) {
       $hash = Calculate-File-Hash $f.FullName
       "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}

elseif ($response -eq "B") {
    $fileHashDictionary = @{}
    
    $filePathAndHashes = Get-Content -Path .\baseline.txt

    foreach ($f in $filePathAndHashes){
       $fileHashDictionary.add($f.Split("|")[0] , $f.Split("|")[1])
        }
    $fileHashDictionary 
    }
    while ($true) {
        Start-Sleep -Seconds 1
        $files =  Get-ChildItem -Path .\Documents
    foreach ($f in $files) {
       $hash = Calculate-File-Hash $f.FullName
        
        if ($hash.Path -ne $null) {
        if ($fileHashDictionary[$hash.Path] -eq $null){
        Write-Host "$($hash.Path) has been created!" -ForegroundColor Yellow
        }
        else {
        if ($fileHashDictionary[$hash.Path] -eq $hash.Hash) {
        }

        else {
            Write-Host "$($hash.Path) has changed!!!!" -ForegroundColor Black

            }
            }
    }
    }
    $key = "C:\Users\nikeh\Onedrive\baseline,txt"
    foreach($key in $fileHashDictionary.Keys){
                $baselineFileStillExists = Test-Path -Path $key
                if (-Not $baselineFileStillExists){
                Write-Host "$($key) has been deleted!!!" -ForegroundColor Red
                }
                else {
    Write-Host "Invalid path: The path is empty."
}
                }
    }