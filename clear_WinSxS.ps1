##########################################
# File:  clear_WinSxS.ps1
# Owner: Bruno Kammers Ribeiro
# Date: 10/09/2020
# Objective: Free Up Disk Space C:
##########################################

cd\ ; cls

$DSB = Get-PSDrive C | Select-Object @{L="FREE SPACE";E={"{0:N2}" -f ($_.Free /1GB)}}
$DISABLED = DISM.exe /Online /English /Get-Features /Format:Table | Select-String "Disabled" | Foreach {($_ -split '\s+',4)[0]}

echo "   C: Status (before script)"
echo $DSB
timeout 5 > $NULL
echo "" ; echo ""
echo "   Removing disabled features..."
echo ""

# Todos os recursos do windows que não estiverem habilitados, serão removidos da pasta WinSxS
# Caso precise instalar algum recurso, na hora de ativar, vai aparecer um aviso para fazer o download
# pois, o recurso não está mais localmente no disco

foreach ($i in $DISABLED) {
    DISM.exe /Online /Disable-Feature /featurename:$i /Remove > $NULL
    echo "Removed:   $i"
}

echo ""
echo "   Cleaning windows updates and service pack files..."
Dism.exe /online /Cleanup-Image /StartComponentCleanup > $NULL
echo ""
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase > $NULL
echo ""
Dism.exe /online /Cleanup-Image /SPSuperseded > $NULL
echo ""

$DSA = Get-PSDrive C | Select-Object @{L="FREE SPACE";E={"{0:N2}" -f ($_.Free /1GB)}}
echo "   C: Status (after script)"
echo $DSA
