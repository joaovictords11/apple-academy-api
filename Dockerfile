FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

FROM eclipse-temurin:21-jdk
WORKDIR /app
ENV SPRING_PROFILES_ACTIVE=prod
COPY --from=build /app/target/apple-academy-api.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]