Add-Type -AssemblyName System.Web

# Caminho para o arquivo TXT contendo nomes
$Global:PathToNamesFile = "C:\Caminho\Para\Seu\Arquivo.txt"

# Verifica se o arquivo TXT existe
if (Test-Path $Global:PathToNamesFile) {
    # Lê o conteúdo do arquivo TXT
    $Global:HumansNames = Get-Content $Global:PathToNamesFile
} else {
    Write-Error "O arquivo TXT de nomes não foi encontrado."
    return
}

# Definindo o limite de usuários a serem criados
$limit = 10

# Definindo o domínio
$Global:Domain = "dominio.com"  # Substitua pelo seu domínio

# Função para obter um item aleatório da lista
function VulnAD-GetRandom {
    param (
        [string[]]$InputList
    )
    Get-Random -InputObject $InputList
}

# Loop para criar usuários
for ($i=1; $i -le $limit; $i=$i+1) {
    $firstname = (VulnAD-GetRandom -InputList $Global:HumansNames)
    $lastname = (VulnAD-GetRandom -InputList $Global:HumansNames)
    $fullname = "{0} {1}" -f ($firstname , $lastname)
    $SamAccountName = ("{0}.{1}" -f ($firstname, $lastname)).ToLower()
    $principalname = "{0}.{1}" -f ($firstname, $lastname)
    
    # Gerando uma senha aleatória de 12 caracteres
    $generated_password = [System.Web.Security.Membership]::GeneratePassword(12, 2)
    
    Write-Info "Creating $SamAccountName User"
    
    # Tentativa de criar o usuário
    Try {
        New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName "$principalname@$Global:Domain" -AccountPassword (ConvertTo-SecureString $generated_password -AsPlainText -Force) -PassThru | Enable-ADAccount
        $Global:CreatedUsers += $SamAccountName
    } Catch {
        Write-Error "Error creating user $SamAccountName"
    }
}
