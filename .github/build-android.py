from pathlib import Path
import os,subprocess,shutil,zipfile
source=Path('checkout/source');android=source/'MiapaxERP.Android';build=Path('android-build');build.mkdir(exist_ok=True)
sdk=Path(os.environ.get('ANDROID_HOME') or os.environ['ANDROID_SDK_ROOT']);tools=sdk/'build-tools/35.0.0';platform=sdk/'platforms/android-35/android.jar'
if not tools.is_dir() or not platform.is_file():raise RuntimeError('Android SDK 35 and build-tools 35.0.0 required')
java=Path(os.environ.get('JAVA_HOME_17_X64') or os.environ['JAVA_HOME'])/'bin'
def run(*args):subprocess.run([str(a) for a in args],check=True)
classes=build/'classes';dex=build/'dex';classes.mkdir(exist_ok=True);dex.mkdir(exist_ok=True)
drawable=android/'res/drawable';drawable.mkdir(exist_ok=True);shutil.copyfile(source/'MiapaxERP.Desktop/Assets/MiapaxERP_Amblem.png',drawable/'miapaxerp.png')
run(java/'javac','-encoding','UTF-8','-source','8','-target','8','-classpath',platform,'-d',classes,*android.rglob('*.java'))
run(java/'jar','cf',build/'classes.jar','-C',classes,'.')
run(tools/'d8','--min-api','26','--lib',platform,'--output',dex,build/'classes.jar')
run(tools/'aapt2','compile','--dir',android/'res','-o',build/'res.zip')
run(tools/'aapt2','link','-o',build/'unsigned.apk','-A',android/'assets','--manifest',android/'AndroidManifest.xml','-I',platform,build/'res.zip')
with zipfile.ZipFile(build/'unsigned.apk','a',zipfile.ZIP_DEFLATED) as z:z.write(dex/'classes.dex','classes.dex')
out=Path('release/android');out.mkdir(parents=True,exist_ok=True);apk=out/'MiaPaxERP-Mobil-v2.8.7-imzasiz.apk'
run(tools/'zipalign','-f','-p','4',build/'unsigned.apk',apk)
run(tools/'zipalign','-c','4',apk)
result=subprocess.check_output([str(tools/'aapt2'),'dump','badging',str(apk)],text=True)
assert "versionCode='20807'" in result and "versionName='2.8.7'" in result
print('Android 2.8.7 build and package verification passed; existing publisher signing remains required.')
signed=android/'MiaPaxERP-Mobil-v2.8.7.apk'
certs=subprocess.check_output([str(java/'java'),'-jar',str(tools/'lib/apksigner.jar'),'verify','--verbose','--print-certs',str(signed)],text=True)
assert '1b4c863df87d104a36744ab4587bd67ad0b185a0535e7a56d7ace3516e897f7a' in certs, 'Existing Android publisher identity mismatch'
with zipfile.ZipFile(apk) as fresh,zipfile.ZipFile(signed) as checked:
    assert fresh.read('classes.dex')==checked.read('classes.dex'),'Signed APK does not match freshly compiled source'
badging=subprocess.check_output([str(tools/'aapt2'),'dump','badging',str(signed)],text=True)
assert "versionCode='20807'" in badging and "versionName='2.8.7'" in badging
print('Existing publisher Android v2/v3 signature, compiled DEX and 2.8.7 version verified.')
