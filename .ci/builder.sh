#!/bin/bash

# Устанавливаем переменные для Git
GIT_EMAIL="vladbars@gmail.com"
GIT_USER="vbaranovski"
WORK_DIR="/tmp/Repo"
REPO_URL="https://github.com/VBaranouski/DevopsPath.git"
REPO_DIR="$WORK_DIR/DevopsPath"
HTML_FILE="ApacheHomepage.html"
DOCKER_IMAGE="docker_hello"
DOCKER_CONTAINER="privet_sdl"

# Создаем папку для репозиториев, если её нет
echo "Создание папки для репозиториев..."
mkdir -p "$WORK_DIR"

# Переходим в папку
cd "$WORK_DIR"

# Клонируем репозиторий, если его нет, иначе обновляем
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Клонируем репозиторий..."
    git clone "$REPO_URL"
else
    echo "Обновляем репозиторий..."
    cd "$REPO_DIR"
    git pull
fi

# Переход в репозиторий
cd "$REPO_DIR"

# Создаем HTML-файл
echo "Создаем/обновляем $HTML_FILE..."
cat > "$HTML_FILE" <<EOF
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SDL</title>
</head>
<body>
    <h1>Привет SDL:))</h1>
</body>
</html>
EOF

# Настраиваем Git
echo "Настраиваем Git..."
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USER"

# Добавляем изменения и отправляем в репозиторий
echo "Добавляем и отправляем изменения в репозиторий..."
git add "$HTML_FILE"
git commit -m "Homepage" && git push origin main

# Останавливаем и удаляем старый контейнер
echo "Останавливаем и удаляем контейнер..."
docker ps -q --filter "name=$DOCKER_CONTAINER" | grep -q . && docker stop "$DOCKER_CONTAINER"
docker rm -f "$DOCKER_CONTAINER"
docker rmi -f "$DOCKER_IMAGE"

# Даем время на завершение процессов
sleep 5

# Собираем новый Docker-образ
echo "Собираем Docker-образ..."
docker build -t "$DOCKER_IMAGE" .

# Даем время перед запуском
sleep 5

# Запускаем контейнер
echo "Запускаем Docker-контейнер..."
docker run -d --name "$DOCKER_CONTAINER" -p 8090:80 "$DOCKER_IMAGE"
