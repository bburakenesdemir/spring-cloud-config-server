FROM maven:3.8.3-eclipse-temurin-17 AS builder
WORKDIR /
COPY pom.xml .
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 ["mvn", "-T", "1C", "package", "-DskipTests"]

FROM openjdk:17-slim-buster as runtime
COPY --from=builder /target/*.jar /root/config-server.jar
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "/root/config-server.jar"]
