# Active Directory – Import Utilisateurs

## Objectif

Créer des utilisateurs Active Directory à partir d’un fichier CSV en utilisant PowerShell.

---

## Domaine

laplateforme.io

---

## Fichiers

* users.csv : liste des utilisateurs
* import-ad-users.ps1 : script d’import

---

## Fonctionnement

Le script :

* lit le fichier CSV
* crée les utilisateurs
* crée les groupes si nécessaire
* ajoute les utilisateurs dans les groupes

---

## Commandes utilisées

```powershell
Set-ExecutionPolicy RemoteSigned
cd C:\AD-Test
.\import-ad-users.ps1
```

---

## Résultat

Les utilisateurs sont créés dans Active Directory avec :

* un mot de passe par défaut
* un changement obligatoire à la première connexion

---
