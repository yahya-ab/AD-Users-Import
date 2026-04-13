Import-Module ActiveDirectory

$csvPath = "C:\AD-Test\users.csv"
$users = Import-Csv $csvPath

$password = ConvertTo-SecureString "Azerty_2025!" -AsPlainText -Force

foreach ($user in $users) {
    $nom = $user.nom.Trim()
    $prenom = $user.prenom.Trim()
    $sam = ($prenom.Substring(0,1) + "." + $nom).ToLower().Replace(" ", "")
    $upn = "$sam@laplateforme.io"
    $displayName = "$prenom $nom"

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $displayName `
            -GivenName $prenom `
            -Surname $nom `
            -DisplayName $displayName `
            -SamAccountName $sam `
            -UserPrincipalName $upn `
            -AccountPassword $password `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -Path "CN=Users,DC=laplateforme,DC=io"
    }

    $groups = @(
        $user.groupe1,
        $user.groupe2,
        $user.groupe3,
        $user.groupe4,
        $user.groupe5,
        $user.groupe6
    ) | Where-Object { $_ -and $_.Trim() -ne "" } | ForEach-Object { $_.Trim() }

    foreach ($group in $groups) {
        if (-not (Get-ADGroup -Filter "Name -eq '$group'" -ErrorAction SilentlyContinue)) {
            New-ADGroup `
                -Name $group `
                -GroupScope Global `
                -GroupCategory Security `
                -Path "CN=Users,DC=laplateforme,DC=io"
        }

        Add-ADGroupMember -Identity $group -Members $sam -ErrorAction SilentlyContinue
    }
}
