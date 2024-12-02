# Используем официальный образ OpenJDK для Java 17
FROM openjdk:17-jdk-alpine

# Устанавливаем переменные окружения
ENV MINECRAFT_VERSION=1.20.1
ENV MINECRAFT_SERVER_PATH=/minecraft

# Создаем директорию для сервера
RUN mkdir -p ${MINECRAFT_SERVER_PATH}

# Переходим в директорию сервера
WORKDIR ${MINECRAFT_SERVER_PATH}

# Скачиваем Minecraft сервер
RUN apk add --no-cache curl && \
    curl -o minecraft_server.jar https://launcher.mojang.com/v1/objects/61db3786585988d56d2c4db42ae69f46c7e25138/server.jar && \
    apk del curl

# Принимаем EULA
RUN echo "eula=true" > eula.txt

# Открываем порты для Minecraft сервера
EXPOSE 25565

# Запуск сервера
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.jar", "nogui"]
