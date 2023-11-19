FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/szallas-0.0.1-SNAPSHOT.jar szallas.jar
EXPOSE 8080
# Környezeti változók a MySQL beállításokhoz
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV DATABASE_NAME="szallas"
ENV DATABASE_USERNAME="root"
ENV DATABASE_PASSWORD=""
ENTRYPOINT ["java","-jar","szallas.jar"]
