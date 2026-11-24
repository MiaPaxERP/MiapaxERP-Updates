param([string]$SourceDirectory='', [string]$ReleaseDirectory='', [string]$Compiler='')
$ErrorActionPreference = 'Stop'
$source = Join-Path $PSScriptRoot '../checkout/source'
if (!(Test-Path $source)) { $source = Join-Path $env:GITHUB_WORKSPACE 'checkout/source' }
if($SourceDirectory){$source=(Resolve-Path -LiteralPath $SourceDirectory).Path}
# Restore unchanged static files from the hash-verified previous release.
$legacy = Join-Path $env:RUNNER_TEMP 'MiapaxERP-2.8.1-static.zip'
Invoke-WebRequest -Uri 'https://github.com/MiaPaxERP/MiapaxERP-Updates/releases/download/v2.8.1/MiapaxERP-Ana-v2.8.1.zip' -OutFile $legacy
if ((Get-FileHash $legacy -Algorithm SHA256).Hash.ToLowerInvariant() -ne '1064692cf7ea2ade7a524fa4649307e81eaf4b2449ab60e60b2f943818c94345') { throw 'Static archive hash mismatch' }
Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [IO.Compression.ZipFile]::OpenRead($legacy)
try {
    foreach ($entry in $archive.Entries) {
        $relative = $entry.FullName.Replace([char]92,[char]47)
        if ($relative -notmatch '^Assets/(SahaWeb/(districts\.geojson|provinces\.geojson|places\.json)|Dashboard/[^/]+\.mp4)$') { continue }
        $destination = Join-Path "$source/MiapaxERP.Desktop" $relative
        New-Item -ItemType Directory -Force ([IO.Path]::GetDirectoryName($destination)) | Out-Null
        [IO.Compression.ZipFileExtensions]::ExtractToFile($entry,$destination,$true)
    }
} finally { $archive.Dispose() }
foreach ($file in @('districts.geojson','provinces.geojson','places.json')) {
    if (!(Test-Path "$source/MiapaxERP.Desktop/Assets/SahaWeb/$file")) { throw "Missing required map: $file" }
}
$out = Join-Path $env:GITHUB_WORKSPACE 'release'
if($ReleaseDirectory){$out=[IO.Path]::GetFullPath($ReleaseDirectory)}
New-Item -ItemType Directory -Force $out | Out-Null
foreach ($entry in @(@('MiapaxERP.Desktop','Masaustu'),@('MiapaxERP.MobileServer','Sunucu'))) {
    dotnet publish "$source/$($entry[0])/$($entry[0]).csproj" -c Release -r win-x64 --self-contained true --disable-build-servers -m:1 -p:NuGetAudit=false -o "$out/$($entry[1])"
    if ($LASTEXITCODE -ne 0) { throw 'Publish failed' }
}
Copy-Item "$source/MobilKurulum/*" "$out/" -Recurse -Force
Copy-Item "$source/DEVELOPMENT_STATUS.md" "$out/OKU-ONCE.md"
# Actual installers are required release assets; never install SQL Server or copy customer data.
if(!$Compiler){$Compiler = & "$source/Setup/Get-Compiler.ps1" -ToolDirectory (Join-Path $env:RUNNER_TEMP 'miapax-inno')}
& "$source/Setup/Build-Setup.ps1" -Payload $out -Output $out -ISCC $Compiler -Version '2.9.10' -Release
Compress-Archive -Path "$out/Masaustu","$out/Sunucu","$out/*.ps1","$out/*.cmd","$out/*.ornek","$out/OKU-ONCE.md" -DestinationPath "$out/MiaPaxERP-Ana-Kurulum-v2.9.10.zip"
# Separate Ana/Yan updater payloads. Keep customer settings, signing files and PDBs out.
$flat = "$out/MiaPaxERP-Yan-v2.9.10.zip"
$ana = "$out/MiaPaxERP-Ana-v2.9.10.zip"
$updateStage = Join-Path $out 'update-stage'
New-Item -ItemType Directory -Force $updateStage | Out-Null
foreach($file in (Get-ChildItem -LiteralPath "$out/Masaustu" -Recurse -File)){
 $relative=[IO.Path]::GetRelativePath("$out/Masaustu",$file.FullName).Replace([char]92,[char]47)
 if($file.Extension -in @('.pdb','.dpapi','.pem','.pfx','.db','.sqlite','.mdf','.ldf','.bak') -or $file.Name -in @('MiapaxERP.guncelleme.json','BoruERP.guncelleme.json','MiaSoft.guncelleme.json','ag-baglantisi.json') -or ($file.Name -match 'lisans' -and $file.Extension -cne '.dll')){continue}
 $destination=Join-Path $updateStage $relative;New-Item -ItemType Directory -Force ([IO.Path]::GetDirectoryName($destination)) | Out-Null;Copy-Item -LiteralPath $file.FullName -Destination $destination
}
# Role-specific instructions make independently downloadable artifacts explicit; channel setting stays on the PC.
'YAN PC 2.9.10: HTTPS ana sunucu adresi ile kullanÄ±lÄ±r. Mevcut baÄŸlantÄ± ve kanal ayarlarÄ± korunur.' | Set-Content "$updateStage/PAKET-ROLU.txt" -Encoding utf8
Compress-Archive -Path "$updateStage/*" -DestinationPath $flat
'ANA PC 2.9.10: Mevcut SQL ve kanal ayarlarÄ± korunur. HTTPS Windows hizmeti gÃ¼ncellemesi iÃ§in tam Ana kurulum paketini kullanÄ±n.' | Set-Content "$updateStage/PAKET-ROLU.txt" -Encoding utf8
Compress-Archive -Path "$updateStage/*" -DestinationPath $ana
& "$PSScriptRoot/validate-update-package.ps1" -Archive $flat -Desktop "$out/Masaustu/MiapaxERP.Desktop.exe"
& "$PSScriptRoot/validate-update-package.ps1" -Archive $ana -Desktop "$out/Masaustu/MiapaxERP.Desktop.exe"
$freshSource = "$out/MiaPaxERP-Kaynak-v2.9.10.zip"
$sourceArchive = [IO.Compression.ZipFile]::Open($freshSource,[IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($file in (Get-ChildItem -LiteralPath $source -Force -Recurse -File)) {
        $relative = [IO.Path]::GetRelativePath($source,$file.FullName).Replace([char]92,[char]47)
        if ($relative -match '(^|/)(bin|obj|\.git|\.vs|node_modules|TestResults|build|Teslim222)/') { continue }
        if ($file.Extension -in @('.zip','.exe','.dll','.pdb','.dpapi','.pfx','.p12','.key','.jks','.mdf','.ldf','.bak','.db','.sqlite','.log') -or $file.Name -match 'private|signing-key|secrets') { continue }
        [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($sourceArchive,$file.FullName,$relative,[IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
} finally { $sourceArchive.Dispose() }
$mobileStage=Join-Path $out 'Mobil'
New-Item -ItemType Directory -Force $mobileStage | Out-Null
Copy-Item "$source/MiapaxERP.Android/AndroidManifest.xml" "$mobileStage/"
Copy-Item "$source/MiapaxERP.Android/Imzala.ps1" "$mobileStage/"
Copy-Item "$source/MiapaxERP.Android/IMZALAMA-OKU.txt" "$mobileStage/"
if(!(Test-Path "$out/android/MiaPaxERP-Mobil-v2.9.10-imzasiz.apk")){throw 'Android build artifact missing'}
Copy-Item "$out/android/MiaPaxERP-Mobil-v2.9.10-imzasiz.apk" "$mobileStage/"
$signedApk="$source/MiapaxERP.Android/MiaPaxERP-Mobil-v2.9.10.apk"
if(!(Test-Path $signedApk)){throw "Signed Android release missing"}
Copy-Item $signedApk "$mobileStage/"
Compress-Archive -Path "$mobileStage/*" -DestinationPath "$out/MiaPaxERP-Mobil-v2.9.10.zip"
$assets = @($signedApk, $ana, $flat, $freshSource, "$out/MiaPaxERP-Ana-Kurulum-v2.9.10.zip", "$out/MiaPaxERP-Mobil-v2.9.10.zip", "$out/MiaPaxERP-Ana-Setup-2.9.10.exe", "$out/MiaPaxERP-Yan-Setup-2.9.10.exe")
$lines = foreach ($file in $assets) { $hash = Get-FileHash -LiteralPath $file -Algorithm SHA256; "$($hash.Hash.ToLowerInvariant())  $([IO.Path]::GetFileName($file))" }
$lines | Set-Content "$out/SHA256SUMS.txt" -Encoding utf8
if ($env:GITHUB_EVENT_NAME -ne 'push' -or $env:GITHUB_REF -ne 'refs/heads/main') { Write-Host 'Packages built and checksummed; release waits for main.'; exit 0 }
$headers = @{Authorization="Bearer $env:GH_TOKEN";Accept='application/vnd.github+json';'X-GitHub-Api-Version'='2022-11-28'}
$head=Invoke-RestMethod -Uri "https://api.github.com/repos/$env:GITHUB_REPOSITORY/git/ref/heads/main" -Headers $headers
if($head.object.sha -ne $env:GITHUB_SHA){Write-Host 'A newer source commit exists; this candidate will not be published.';exit 0}
$body = @{tag_name='v2.9.10';target_commitish=$env:GITHUB_SHA;name='MiaPaxERP 2.9.10 — Kroki: ada/parsel (TKGM), canlı konum, temizle; çeviri, hızlı satış ve basınç testi düzeltmeleri';draft=$true;prerelease=$false;body='MiaPaxERP 2.9.10. Arazi Stüdyosu: Temizle düğmesi (geri alınabilir), canlı konum takibi, TKGM Parsel Sorgu program içinde açılır ve indirilen KML/GeoJSON parsel sınırı krokiye otomatik aktarılır; KML/GeoJSON dosyası da açılabilir. Cam temalarında sol menü modül seçilince kapanır. Boru basınç testinde Yeni test, laboratuvar veya depo yetkisi olmayan kullanıcıda da açılır; tarih dilden bağımsız okunur ve hata mesajı hatalı alanı söyler. Hızlı satış ve SATIŞ ekranında tutarlar binlik ayıraçla gösterilir, genel toplam her değişiklikte güncellenir. Diller: tüm açık pencereler, bildirim ve öneri panelleri, menüler, yazdırılan belgeler, laboratuvar ve tablo PDF raporları ile kroki ve saha web ekranları seçili dile çevrilir; sözlüğe 195 yeni metin eklendi. Kurmadan önce veritabanını yedekleyin. 2.9.10 içeriği dahildir.'} | ConvertTo-Json
$api = "https://api.github.com/repos/$env:GITHUB_REPOSITORY/releases"
$candidate=$null
try{$candidate=Invoke-RestMethod -Uri "$api/tags/v2.9.10" -Headers $headers}catch{if([int]$_.Exception.Response.StatusCode -ne 404){throw}}
if($candidate){
 # Replace only our unannounced candidate, before enabling the signed update feeds.
 if($candidate.target_commitish -notin @('0cfe091a64ff4a65f3d46dd8d420234b9c80507b','eec2026e23f2b5453ba5e73e010e40708f7adf41') -and !($candidate.draft -and $candidate.target_commitish -eq $env:GITHUB_SHA)){throw 'Existing release is not this unannounced candidate; refusing replacement'}
 foreach($channel in @('ana','yan','mobil')){$feed=Invoke-RestMethod -Uri "https://raw.githubusercontent.com/MiaPaxERP/MiapaxERP-Updates/main/manifest-$channel.json";if($feed.Version -eq '2.9.10'){throw 'Candidate update feed already enabled; use a new version'}}
 Invoke-RestMethod -Method Patch -Uri "$api/$($candidate.id)" -Headers $headers -ContentType 'application/json' -Body '{"draft":true}' | Out-Null
 foreach($asset in $candidate.assets){Invoke-RestMethod -Method Delete -Uri "$api/assets/$($asset.id)" -Headers $headers | Out-Null}
 $refApi="https://api.github.com/repos/$env:GITHUB_REPOSITORY/git/refs/tags/v2.9.10"
 $tag=Invoke-RestMethod -Uri $refApi -Headers $headers
 if($tag.object.sha -notin @('0cfe091a64ff4a65f3d46dd8d420234b9c80507b','eec2026e23f2b5453ba5e73e010e40708f7adf41') -and $tag.object.sha -ne $env:GITHUB_SHA){throw 'Candidate tag changed; refusing replacement'}
 Invoke-RestMethod -Method Patch -Uri $refApi -Headers $headers -ContentType 'application/json' -Body (@{sha=$env:GITHUB_SHA;force=$true}|ConvertTo-Json) | Out-Null
 $release=Invoke-RestMethod -Method Patch -Uri "$api/$($candidate.id)" -Headers $headers -ContentType 'application/json; charset=utf-8' -Body ([Text.Encoding]::UTF8.GetBytes($body))
}else{$release = Invoke-RestMethod -Method Post -Uri $api -Headers $headers -ContentType 'application/json; charset=utf-8' -Body ([Text.Encoding]::UTF8.GetBytes($body))}
foreach ($file in ($assets + "$out/SHA256SUMS.txt")) {
    $name = [Uri]::EscapeDataString([IO.Path]::GetFileName($file))
    $upload = ($release.upload_url -replace '\{.*$','') + '?name=' + $name
    Invoke-RestMethod -Method Post -Uri $upload -Headers $headers -ContentType 'application/octet-stream' -InFile $file | Out-Null
}
Invoke-RestMethod -Method Patch -Uri "$api/$($release.id)" -Headers $headers -ContentType 'application/json' -Body '{"draft":false}' | Out-Null
Write-Host "Published $($release.html_url)"
