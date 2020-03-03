##################################################################
##################################################################
############  FAILOVER  -  DNS ROUND ROBIN  ######################
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
$DNSX = ''

########## UNDER CONTRUCTION ...


echo "PASSO 1 - Consulta"
Get-DnsServerResourceRecord -ComputerName '$ADLOCAL' -ZoneName '$DOMAIN' -RRType A -ErrorAction:Ignore | Where-Object Hostname -eq '$DNSX'


echo "PASSO 2 - Insere"
Add-DnsServerResourceRecordA -Name '$DNSX' -ZoneName '$DOMAIN' -IPv4Address 192.168.152.56


echo "PASSO 3 - Consulta"
Get-DnsServerResourceRecord -ComputerName '$ADLOCAL' -ZoneName '$DOMAIN' -RRType A -ErrorAction:Ignore | Where-Object Hostname -eq '$DNSX'


echo "PASSO 4 - Remove"
Remove-DnsServerResourceRecord -Name '$DNSX' -ZoneName '$DOMAIN' -RRType A
