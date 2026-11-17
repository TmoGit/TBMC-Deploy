import pathlib,zipfile,xml.etree.ElementTree as E,json
p=pathlib.Path(pathlib.Path('C:/TBMC/Logs/TBMC-Current-Equipment-Run.txt').read_text().strip());z=zipfile.ZipFile('Digital Design Specification_TBMC_CO1 8_13_26 Final.docx');x=E.fromstring(z.read('word/document.xml'));ns={'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
removed=0
for parent in x.iter():
 for child in list(parent):
  if child.tag in ['{'+ns['w']+'}del','{'+ns['w']+'}moveFrom']:
   parent.remove(child);removed+=1
rows=[]
for t in x.findall('.//w:tbl',ns):
 a=[[' | '.join(''.join(n.text or '' for n in p.findall('.//w:t',ns)) for p in c.findall('w:p',ns)) for c in r.findall('w:tc',ns)] for r in t.findall('w:tr',ns)]
 if a and 'Ethernet Device' in str(a[0]):rows=a
(p/'DDS-equipment-accepted.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf8');print('Removed revision containers',removed)
for i,r in enumerate(rows):print(i,repr(r))
