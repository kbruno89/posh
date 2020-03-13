##################################################################
##################################################################
############  FAILOVER  -  AD DNS ROUND-ROBIN  ###################
##################################################################
##################################################################
##  v 1.0 beta        @  Bruno Kammers R.  -  03/2020  ###########
##################################################################
##################################################################

cls

$DOMAIN = 'contoso.com'
$ADLOCAL = 'ad01.contoso.com'
$EXT = '8.8.8.8'
$DNS = 'xyz.com'
$IPA = '1.1.1.1'
...
$IPX = '9.9.9.9'

########## UNDER CONSTRUCTION ...

echo "External Validation/Consulta Externa"
$VAR = (nslookup '$DNS' '$EXT' 2> $null | findstr 'Address' | where { $_ -notmatch '$EXT' }) | ForEach-Object { $_.split(":")[1] } | ForEach-Object { $_.split(" ")[2] }
$VAR
echo "" ; echo ""


echo "Get/Consulta"
Get-DnsServerResourceRecord -ComputerName '$ADLOCAL' -ZoneName '$DOMAIN' -RRType A -ErrorAction:Ignore | Where-Object Hostname -eq '$DNS'


echo "Delete/Remove"
Remove-DnsServerResourceRecord -Name '$DNS' -ZoneName '$DOMAIN' -RRType A


echo "Insert/Insere"
Add-DnsServerResourceRecordA -Name '$DNS' -ZoneName '$DOMAIN' -IPv4Address '$VAR'
