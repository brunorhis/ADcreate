# Importa o módulo ActiveDirectory
Import-Module ActiveDirectory

# Obtém todos os usuários do AD
$usuarios = Get-ADUser -Filter *

# Itera sobre cada usuário e os exclui
foreach ($usuario in $usuarios) {
    Remove-ADUser -Identity $usuario -Confirm:$false
}

Write-Host "Todos os usuários foram excluídos com sucesso."
