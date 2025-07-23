# Utilise une image JDK 21
FROM eclipse-temurin:21-jdk

# Crée un dossier dans le conteneur
WORKDIR /app

# Copie le jar compilé
COPY target/MonProjetCI-1.0.0.jar app.jar

# Commande de lancement
ENTRYPOINT ["java", "-jar", "app.jar"]
