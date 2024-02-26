Instructions for running the automated test on Windows:
1. Open Windows PowerShell as an Administrator.
2. Change the directory to this folder.
3. Allow script execution:

> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

3. Run the warmup:

> .\warmup.ps1

4. Inside `test.ps1`, define the path to the EnergyBridge executable and the VLC executable.
5. Run the test:

> .\test.ps1