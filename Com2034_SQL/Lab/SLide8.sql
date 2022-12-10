
---------back up duwx lieeuj
USE QLDA
GO
BACKUP DATABASE QLDA
	TO  DISK = N'D:\Com2034_SQL\QLDABackup.bak'

Backup database <TEN DATABASE>
To disk = '<DUONG DAN FILE BACKUP + TEN FILE>'
Backup database <TEN DATABASE>
To disk = '<DUONG DAN FILE BACK UP + TEN FILE>' with differential
Backup log <TEN DATABASE>
To disk = '<DUONG DAN FILE BACKUP + TEN FILE>'

Restore database QLDA from disk = N'D:\Com2034_SQL\QLDABackup.bak'