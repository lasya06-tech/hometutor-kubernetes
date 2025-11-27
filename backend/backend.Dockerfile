# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY mvnw .          
COPY .mvn/ .mvn

RUN chmod +x mvnw

COPY pom.xml ./
COPY src ./src

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY --from=build /app/target/hometutor-1.0.0.jar app.jar

EXPOSE 1202

ENTRYPOINT ["java", "-jar", "app.jar"]