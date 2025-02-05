#! bin/bash

git_email="vladbars@gmail.com"
git_user="vbaranovski"

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
    <h1>Привет SDL:)) еще раз 5 </h1>
</body>
</html>' > ApacheHomepage.html

git config --global user.email $git_email
git config --global user.name $git_user
git add -A && git commit -m 'adding homepage' && git push origin main

echo 'stop running containers'
docker stop privetsdl
docker rm privetsdl
docker rmi -f dockerhellosdl
sleep 10

echo 'Build docker image'
docker build -t dockerhellosdl .
sleep 5

echo 'Run docker container'
docker run -d -p 8090:80 --name privetsdl dockerhellosdl





