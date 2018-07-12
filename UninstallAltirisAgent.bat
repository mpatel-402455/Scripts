REM Uninstall All NS Agents

"C:\Program Files\Altiris\Altiris Agent\AeXAgentUtil.exe" /UninstallAgents
"C:\Program Files\Altiris\Altiris Agent\AeXAgentUtil.exe" /ResetGuid
"C:\Program Files\Altiris\Altiris Agent\AeXAgentUtil.exe" /Clean
RD "C:\Program Files\Altiris\Altiris Agent" /s /q
sc delete AltirisACSvc
