import openpyxl,pymupdf,pathlib,json,zipfile,xml.etree.ElementTree as E
root=pathlib.Path.cwd(); out=pathlib.Path(pathlib.Path('C:/TBMC/Logs/TBMC-Current-Equipment-Run.txt').read_text().strip())
w=openpyxl.load_workbook(root/'TBMC PAD Ignition Equipment list.xlsx',data_only=False)
rows=[]
for s in w:
 print('SHEET',s.title,s.sheet_state)
 for row in s:
  vals=[c.value for c in row]
  if any(v is not None for v in vals):
   rows.append({'sheet':s.title,'row':row[0].row,'hidden':s.row_dimensions[row[0].row].hidden,'cells':vals});print(row[0].row,vals)
(out/'workbook-raw.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf8')
p=pymupdf.open(root/'TBMC Network Architecture RevC_8_13_26 Final.pdf')
for i,page in enumerate(p):
 (out/f'architecture-page-{i+1}.txt').write_text(page.get_text(),encoding='utf8');page.get_pixmap(matrix=pymupdf.Matrix(2,2)).save(out/f'architecture-page-{i+1}.png')
 print('PDF',i+1,page.get_text())
z=zipfile.ZipFile(root/'Digital Design Specification_TBMC_CO1 8_13_26 Final.docx');x=E.fromstring(z.read('word/document.xml'));ns={'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
tables=[]
for t in x.findall('.//w:tbl',ns):
 a=[[''.join(c.itertext()) for c in []]]
 a=[[' | '.join(''.join(p.itertext()) for p in c.findall('w:p',ns)) for c in r.findall('w:tc',ns)] for r in t.findall('w:tr',ns)]
 tables.append(a)
(out/'DDS-tables.json').write_text(json.dumps(tables,ensure_ascii=False,indent=2),encoding='utf8')
