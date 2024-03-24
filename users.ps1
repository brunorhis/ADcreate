# Função para gerar senhas aleatórias
Function Gerar-Senha {
    param (
        [int]$Comprimento = 8
    )

    $caracteres = "abcdefghijklmnopqrstuvwxyz0123456789"
    $senha = ""
    for ($i = 0; $i -lt $Comprimento; $i++) {
        $senha += $caracteres[(Get-Random -Minimum 0 -Maximum $caracteres.Length)]
    }
    return $senha
}

# Função para criar usuários
Function Novo-Usuario {
    param (
        [string]$NomeUsuario,
        [string]$NomeCompleto,
        [string]$Email
    )

    $senha = Gerar-Senha -Comprimento 8
    Write-Host "Senha para $NomeUsuario: $senha"
    
    New-ADUser -Name $NomeUsuario -SamAccountName $NomeUsuario -GivenName $NomeUsuario.Split('.')[0] -Surname $NomeUsuario.Split('.')[1] `
        -UserPrincipalName "$NomeUsuario@chosen.local" -DisplayName $NomeCompleto -AccountPassword (ConvertTo-SecureString -AsPlainText $senha -Force) `
        -EmailAddress $Email -Enabled $true -PassThru
}

# Função para adicionar usuários aos grupos
Function Adicionar-UsuarioAoGrupo {
    param (
        [string]$NomeUsuario,
        [string]$NomeGrupo
    )

    Add-ADGroupMember -Identity $NomeGrupo -Members $NomeUsuario
}

# Criar usuários
Novo-Usuario -NomeUsuario "a.adams" -NomeCompleto "A. Adams" -Email "a.adams@chosen.local"
Novo-Usuario -NomeUsuario "j.taylor" -NomeCompleto "J. Taylor" -Email "j.taylor@chosen.local"
Novo-Usuario -NomeUsuario "j.anthony" -NomeCompleto "J. Anthony" -Email "j.anthony@chosen.local"
Novo-Usuario -NomeUsuario "t.carter" -NomeCompleto "T. Carter" -Email "t.carter@chosen.local"
Novo-Usuario -NomeUsuario "m.phillips" -NomeCompleto "M. Phillips" -Email "m.phillips@chosen.local"
Novo-Usuario -NomeUsuario "r.smith" -NomeCompleto "R. Smith" -Email "r.smith@chosen.local"
Novo-Usuario -NomeUsuario "s.chisholm" -NomeCompleto "S. Chisholm" -Email "s.chisholm@chosen.local"
Novo-Usuario -NomeUsuario "m.seitz" -NomeCompleto "M. Seitz" -Email "m.seitz@chosen.local"
Novo-Usuario -NomeUsuario "a.tarolli" -NomeCompleto "A. Tarolli" -Email "a.tarolli@chosen.local"
Novo-Usuario -NomeUsuario "z.dickens" -NomeCompleto "Z. Dickens" -Email "z.dickens@chosen.local"
Novo-Usuario -NomeUsuario "neo" -NomeCompleto "Neo" -Email "neo@chosen.local"

# Adicionar usuários aos grupos
Adicionar-UsuarioAoGrupo -NomeUsuario "a.adams" -NomeGrupo "Senior Management Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "a.adams" -NomeGrupo "Domain Administrators Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "j.taylor" -NomeGrupo "IT Admins Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "j.anthony" -NomeGrupo "Engineering Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "t.carter" -NomeGrupo "Engineering Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "m.phillips" -NomeGrupo "Engineering Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "r.smith" -NomeGrupo "Engineering Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "m.seitz" -NomeGrupo "Engineering Group"
Adicionar-UsuarioAoGrupo -NomeUsuario "s.chisholm" -NomeGrupo "Sales"
Adicionar-UsuarioAoGrupo -NomeUsuario "a.tarolli" -NomeGrupo "Sales"
Adicionar-UsuarioAoGrupo -NomeUsuario "z.dickens" -NomeGrupo "Sales"
Adicionar-UsuarioAoGrupo -NomeUsuario "neo" -NomeGrupo "Domain Users"
