FROM gradle:7.6-jdk17-alpine AS build

WORKDIR /app

COPY build.gradle settings.gradle ./

COPY src ./src

RUN gradle build --no-daemon --parallel --configure-on-demand

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/app.jar

EXPOSE 8899

ENTRYPOINT ["java", "-jar", "app.jar"]
