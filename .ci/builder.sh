#! bin/bash

cd ~/
echo “Creating Repository folder”

mkdir Repositories || cd Repositories

echo “Cloning Repo if not exist, or pulling latest changes“
git clone https://github.com/VBaranouski/DevopsPath.git || cd DevopsPath/ || git pull  

echo '<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SDL</title>
</head>
<body>
    <h1>Привет SDL:))</h1>
</body>
</html>' > ApacheHomepage.html

git add -A && git commit -m “adding homepage” && git push origin main

echo “Building docker image”
docker build -t dockerhellosdl .

echo “Running docker container”
docker run -d -p 8090:80 dockerhellosdl





