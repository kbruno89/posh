# BOT FOR YOUTUBE VIEWS
# YOU NEED CURL.EXE + ANY VPN APP THAT ACCEPTS COMMAND LINE OPTIONS
# ENJOY  :)

cls ; $MYIP = C:\curl\bin\curl.exe ifconfig.me 2> $NULL ; timeout 2 > $NULL

while ($TRUE){ cls ;
    echo "  KILL MSEDGE..." ; taskkill /im msedge.exe /f > $NULL 2>&1 ; echo "     OK"
    echo ""
    echo "  KILL VPN..." ; C:\"Program Files"\NordVPN\nordvpn -d ; timeout 1 > $NULL ; echo "     OK"
    echo ""
    echo "  START VPN..." ; C:\"Program Files"\NordVPN\nordvpn -c -g "United States" ; timeout 20 > $NULL ; echo "     OK"
    echo ""
    echo "  REAL IP IS..." ; echo "    $MYIP"
    echo ""
    echo "  VPN IP IS..." ; $IPVPN = C:\curl\bin\curl.exe ifconfig.me 2> $NULL ; timeout 2 > $NULL ; echo "    $IPVPN"
    
    if ($IPVPN -match $MYIP -or $IPVPN -eq $NULL){ timeout 60 > $NULL ; continue }
    
    for ($i=1; $i -le 10; $i++){ start C:\video$i.lnk > $NULL 2>&1 } ; timeout 270 > $NULL
}
