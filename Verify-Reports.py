import pathlib,json,csv,zipfile,collections,hashlib,openpyxl,sys
p=pathlib.Path(sys.argv[1]);w=openpyxl.load_workbook(p/'TBMC-Commission-Results.xlsx',read_only=True,data_only=True)
assert w.sheetnames==['Summary','Equipment Results','Source Reconciliation','Database-Ignition Results']
assert w['Equipment Results'].max_row==36
assert w['Source Reconciliation'].max_row==36
records=json.loads((p/'equipment-register.json').read_text(encoding='utf8'));assert len(records)==35
work=[r for r in records if r['Record Type']=='Workbook'];assert len(work)==31
assert sum(bool(r['Workbook IP Original']) for r in work)==22
assert len({r['Workbook IP Original'] for r in work if r['Workbook IP Original']})==22
net=list(csv.DictReader((p/'endpoint-results.csv').open(encoding='utf-8-sig')));assert len(net)==29
raw=list(csv.DictReader((p/'icmp-raw.csv').open(encoding='utf-8-sig')));assert len(raw)==208
for n in net:
 attempts=[r for r in raw if r['IP']==n['IP']];assert len(attempts)==int(n['Requests']);assert len(attempts)==(4 if int(n['Replies']) else 8)
assert len([n for n in net if n['Status']=='responding'])==6
credentials=[pathlib.Path('C:/TBMC/Secure/gateway-admin-reset-20261110.json'),pathlib.Path('C:/TBMC/Secure/corrected-backup-20261105-042546/gateway-admin-credentials.json')]
passwords=[]
for f in credentials:
 if f.exists():
  c=json.loads(f.read_text(encoding='utf-8-sig'));v=c.get('Password');
  if isinstance(v,str) and len(v)>6:passwords.append(v)
for f in p.iterdir():
 if not f.is_file():continue
 if f.suffix=='.xlsx':
  with zipfile.ZipFile(f) as z:text='\n'.join(z.read(n).decode('utf8',errors='ignore') for n in z.namelist() if n.endswith('.xml'))
 else:text=f.read_text(encoding='utf8',errors='ignore')
 assert all(v not in text for v in passwords),'Sensitive value detected; filename withheld'
cleanup=json.loads((p/'cleanup.json').read_text(encoding='utf-8-sig'));assert cleanup['RemainingDebugListeners']==0
result={'ExcelReadback':'PASS','WorkbookRows':31,'RegisterRecords':35,'UniqueEquipmentEndpoints':28,'DatabaseEndpoints':1,'RawICMPRequests':len(raw),'Baseline':'31 / 22 populated / 9 blank: PASS','KnownGatewayPasswordsAbsent':'PASS','OwnedDebugListenersRemaining':0,'ProductionReady':False}
(p/'verification.json').write_text(json.dumps(result,indent=2),encoding='utf8')
index=[{'File':f.name,'SHA256':hashlib.sha256(f.read_bytes()).hexdigest(),'Bytes':f.stat().st_size} for f in sorted(p.iterdir()) if f.is_file() and f.name!='evidence-hashes.json']
(p/'evidence-hashes.json').write_text(json.dumps(index,indent=2),encoding='utf8');print(json.dumps(result))
