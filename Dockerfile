# Stage 1: Build the JAR using Maven
FROM maven:3.8.6-eclipse-temurin-8 AS builder
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the app (skip tests)
RUN mvn clean package -DskipTests

# Stage 2: Run the app using Java 8 JRE
FROM eclipse-temurin:8-jre
WORKDIR /app

# Copy built JAR from builder stage
COPY --from=builder /app/target/*.jar ./app.jar

# Run the JAR (adjust if your main class requires arguments)
CMD ["java", "-jar", "app.jar"]
