# 1. Utilise une version stable (évite les 'rc' - Release Candidate)
FROM python:3.15-rc-slim-trixie

# 2. Alpine utilise 'adduser -D' (pas useradd)
RUN adduser -D appuser

# 3. Définit le dossier de travail
WORKDIR /app

# 4. Installe les dépendances en tant que ROOT (nécessaire pour les permissions)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie le reste du code
COPY . .

# 6. Donne la propriété du dossier à ton utilisateur pour la sécurité
RUN chown -R appuser:appuser /app

# 7. Change d'utilisateur SEULEMENT à la fin
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
