#  SecureCloud-Health-API (DevSecOps PoC)

##  Présentation
Ce projet illustre la mise en place d'une chaîne **DevSecOps** complète pour une API de santé simulée. L'objectif est de garantir que chaque déploiement sur **Azure** respecte des standards de sécurité rigoureux, conformément aux exigences des infrastructures critiques et du secteur public.

Ce projet a été réalisé pour démontrer mes compétences techniques sur **Docker**, le **CI/CD** et la **Sécurité Cloud**.

##  Stack Technique
* **Langage :** Python (Flask)
* **Conteneurisation :** Docker (Optimisé Image Slim & Non-root user)
* **CI/CD :** GitHub Actions
* **Cloud :** Azure (Container Registry & Web App for Containers)
* **Sécurité :** Bandit (SAST) & Trivy (Container Scanning)

##  Fonctionnalités Sécurité
Pour répondre aux enjeux de confiance numérique, le pipeline intègre :
1.  **Analyse Statique (SAST) :** Utilisation de `Bandit` pour détecter les failles dans le code Python (ex: injections, secrets en clair).
2.  **Scan de Vulnérabilités Image :** Utilisation de `Trivy` pour scanner les couches de l'image Docker.
3.  **Hardening Docker :** * Utilisation d'images de base légères (Alpine/Slim) pour réduire la surface d'attaque.
    * Exécution du conteneur avec un utilisateur `appuser` (non-root) pour limiter les privilèges.
4.  **Gatekeeping :** Le pipeline échoue (`exit code 1`) si une vulnérabilité de niveau **CRITICAL** ou **HIGH** est détectée.

##  Architecture du Pipeline
1.  **Push** du code sur GitHub.
2.  **Linting & Security Scan** (Bandit).
3.  **Build Docker** de l'image.
4.  **Security Scan Image** (Trivy).
5.  **Push** vers **Azure Container Registry** (si tous les scans sont validés).
6.  **Déploiement** automatique sur **Azure Web Apps**.

<div align="center">
  <h3> Démonstration du Pipeline DevSecOps</h3>
  <p><i>Aperçu du cycle CI/CD : Scan Bandit -> Build Docker -> Scan Trivy -> Déploiement Azure</i></p>
  <video src="https://github.com/user-attachments/assets/9ff1a4d2-7be5-4e6d-9491-abf6414f1b78" width="100%" controls></video>
</div> 

##  Installation & Test Local
```bash
# Cloner le projet
git clone https://github.com/MOHAMEDBOUTALMAOUINE/DevSecOps

# Builder l'image localement
docker build -t health-api:latest .

# Lancer le conteneur
docker run -p 5000:5000 health-api:latest

