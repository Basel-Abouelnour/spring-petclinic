FROM eclipse-temurin:17.0.18_8-jre-ubi9-minimal
COPY target/*.jar app.jar
EXPOSE 8888
ENTRYPOINT [ "java", "-jar", "app.jar", "--server.port=8888" ]

