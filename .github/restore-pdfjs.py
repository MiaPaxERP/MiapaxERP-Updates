from pathlib import Path
import urllib.request,json,hashlib,base64,tarfile,io
root=Path('checkout/source/MiapaxERP.Desktop/Assets/KrokiWeb/lib/pdfjs')
meta=json.loads((root/'DEPENDENCY.json').read_text())
assert meta['package']=='pdfjs-dist' and meta['version']=='6.5.438'
assert meta['source']=='https://registry.npmjs.org/pdfjs-dist/-/pdfjs-dist-6.5.438.tgz'
with urllib.request.urlopen(meta['source'],timeout=90) as r:data=r.read()
assert 'sha512-'+base64.b64encode(hashlib.sha512(data).digest()).decode()==meta['integrity']
with tarfile.open(fileobj=io.BytesIO(data),mode='r:gz') as tar:
 for m in tar.getmembers():
  rel=m.name.removeprefix('package/')
  if rel not in ['build/pdf.mjs','build/pdf.worker.mjs','LICENSE'] and not rel.startswith(('cmaps/','standard_fonts/','wasm/')):continue
  if not m.isfile():continue
  p=root/rel;assert '..' not in p.parts;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(tar.extractfile(m).read())
print('Pinned PDF.js restored; SHA512 integrity passed.')
