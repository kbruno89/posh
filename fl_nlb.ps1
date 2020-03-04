##################################################################
##################################################################
############  FAILOVER  -  AD DNS ROUND-ROBIN  ###################
##################################################################
##################################################################
##  v 1.0 beta        @  Bruno Kammers R.  -  03/2020  ###########
##################################################################
##################################################################

cls

$DOMAIN = ''
$ADLOCAL = ''
$DNSA = ''
$DNSB = ''
...
$DNSX = ''

########## UNDER CONSTRUCTION ...


echo "Get/Consulta"
Get-DnsServerResourceRecord -ComputerName '$ADLOCAL' -ZoneName '$DOMAIN' -RRType A -ErrorAction:Ignore | Where-Object Hostname -eq '$DNSX'


echo "Delete/Remove"
Remove-DnsServerResourceRecord -Name '$DNSX' -ZoneName '$DOMAIN' -RRType A


echo "Insert/Insere"
Add-DnsServerResourceRecordA -Name '$DNSX' -ZoneName '$DOMAIN' -IPv4Address 192.168.0.X



