# Requires https://msixhero.net/ 
# Create Classic MSIX
dotnet publish   -f net7.0-windows10.0.19041.0 -c Release   /p:configuration=release /p:GenerateAppxPackageOnBuild=true /p:AppxPackageSigningEnabled=true /p:PackageCertificateThumbprint="YOURCertificateThumbrint"

# Unpack MSIX
msixherocli.exe unpack --directory C:\PATHTOWHEREYOUWANTTOPUTIT --package C:\PATHTOYOURMSIX\PUBLISHCREATEDMSIX.msix

# Sign EXE
SignTool sign /fd SHA256 /a /t http://timestamp.digicert.com  /n "Your Certificates Thumbprint" C:\PATHTOWHEREYOUWANTTOPUTIT\APPNAME.exe
SignTool sign /fd SHA256 /a /t http://timestamp.digicert.com  /n "Your Certificates Thumbprint" C:\PATHTOWHEREYOUWANTTOPUTIT\APPNAME.dll

# Pack and Sign Again
MSIXHeroCLI.exe pack -d "C:\PATHTOWHEREYOUWANTTOPUTIT" -p ".\bin\APPNAME.msix"
msixherocli.exe sign --sha1 YOURCERTTHUMBPRINTALLCAPSORITWILLFAIL --timestamp http://timestamp.digicert.com ".\bin\APPNAME.msix"