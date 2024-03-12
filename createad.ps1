# Importa o módulo ActiveDirectory
Import-Module ActiveDirectory

# Caminho para o arquivo TXT
$caminhoArquivoTXT = "C:\Caminho\Para\Seu\Arquivo.txt"

# Verifica se o arquivo TXT existe
if (Test-Path $caminhoArquivoTXT) {
    # Lê o conteúdo do arquivo TXT
    $dadosUsuarios = Get-Content $caminhoArquivoTXT

    # Obtém a Unidade Organizacional padrão do domínio
    $ouPadrao = (Get-ADDomain).DistinguishedName

    # Itera sobre os dados do arquivo TXT para criar os usuários
    foreach ($linha in $dadosUsuarios) {
        # Divide a linha em nome e sobrenome
        $nomeSobrenome = $linha -split '\.'
        $nomeUsuario = $nomeSobrenome[0]
        $sobrenomeUsuario = $nomeSobrenome[1]
        
        # Gera uma senha aleatória de 5 dígitos
        $senhaUsuario = Get-Random -Minimum 10000 -Maximum 99999 | ConvertTo-SecureString -AsPlainText -Force
        
        # Define o SamAccountName combinando nome e sobrenome
        $samAccountName = "$nomeUsuario$sobrenomeUsuario"

        # Cria o novo usuário usando a Unidade Organizacional padrão
        New-ADUser -SamAccountName $samAccountName -UserPrincipalName "$samAccountName@dominio.com" -Name "$nomeUsuario $sobrenomeUsuario" -GivenName $nomeUsuario -Surname $sobrenomeUsuario -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires $false -OrganizationalUnit $ouPadrao -AccountPassword $senhaUsuario
    }

    Write-Host "Usuários criados com sucesso."
} else {
    Write-Host "O arquivo TXT não foi encontrado."
}
