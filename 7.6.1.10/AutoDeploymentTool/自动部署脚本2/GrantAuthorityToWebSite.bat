@echo off
setlocal

set grantPath=%1
set grantUser=%2



echo granting web site folder Path %grantPath% User %grantUser

echo Y|cacls %grantPath% /T /E /G %grantUser%:F

echo end grant web site folder Path %grantPath% User %grantUser
