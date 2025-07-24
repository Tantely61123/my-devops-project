FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copie le jar compilé (avec le bon nom de fichier)
COPY target/my-devops-project-*.jar app.jar

# Commande de lancement
ENTRYPOINT ["java", "-jar", "app.jar"]
