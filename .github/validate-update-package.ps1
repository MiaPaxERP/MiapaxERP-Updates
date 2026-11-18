param([Parameter(Mandatory=$true)][string]$Archive,[Parameter(Mandatory=$true)][string]$Desktop,[string]$Version='2.9.1.0')
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
if((Get-Item -LiteralPath $Archive).Length -gt 500MB){throw 'Updater package exceeds the old client 500 MiB limit'}
if([Diagnostics.FileVersionInfo]::GetVersionInfo($Desktop).FileVersion -ne $Version){throw 'Desktop EXE version mismatch'}
$zip=[IO.Compression.ZipFile]::OpenRead($Archive)
try{
 if(!$zip.GetEntry('MiapaxERP.Desktop.exe') -or !$zip.GetEntry('MiapaxERP.Updater.exe')){throw 'Desktop/updater must be at ZIP root'}
 $seen=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
 foreach($entry in $zip.Entries){
  $rel=$entry.FullName.Replace([char]92,[char]47);if($rel.EndsWith('/')){continue};$parts=$rel.Split('/');$name=$parts[-1];$ext=[IO.Path]::GetExtension($name)
  if(!$seen.Add($rel) -or [IO.Path]::IsPathRooted($rel) -or $rel.Length -gt 220 -or $rel.Contains(':') -or @($parts|Where-Object {$_ -in @('','..','.') -or $_.EndsWith('.') -or $_.EndsWith(' ') -or $_.IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0}).Count){throw "Unsafe or duplicate archive path: $rel"}
  # Keep the OLD updater policy unchanged: current package must install through existing clients.
  if(@($parts|Where-Object {$_ -in @('Data','UserData')}).Count -or $name -in @('MiapaxERP.guncelleme.json','BoruERP.guncelleme.json','MiaSoft.guncelleme.json','ag-baglantisi.json') -or ($name -match 'lisans' -and $ext -cne '.dll') -or $ext -in @('.db','.sqlite','.sqlite3','.mdf','.ldf','.bak','.pem','.pfx','.dpapi','.pdb')){throw "Old updater rejects payload: $rel"}
 }
 foreach($required in @('Assets/KrokiWeb/js/field-plan-designer.mjs','Assets/KrokiWeb/lib/pdfjs/build/pdf.mjs','Assets/KrokiWeb/lib/pdfjs/build/pdf.worker.mjs')){if(!$zip.GetEntry($required)){throw "Kroki payload missing: $required"}}
 Write-Host "PASS old updater archive rules, root EXE, version, PDF assets and size: $Archive"
}finally{$zip.Dispose()}
