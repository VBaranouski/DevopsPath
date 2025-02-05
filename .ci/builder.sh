#! bin/bash
cd ~/
echo “Creating Repository folder”
mkdir Repositories || cd Repositories
echo “Cloning Repo if not exist, or pulling latest changes“
git clone https://github.com/VBaranouski/DevopsPath.git
git clone https://github.com/VBaranouski/DevopsPath.git || cd DevopsPath/ || git pull
cd homepage/
Echo “Building docker image”
docker build -t dockerhellosdl .
echo “Running docker container”
docker run -d -p 8090:80 dockerhellosdl
