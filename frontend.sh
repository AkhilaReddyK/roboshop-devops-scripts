echo -e \\e[35m Installing Nginx\\e[0m
dnf install -y nginx

echo -e \\e[35m Copying Nginx Configuration\\e[0m
cp nginx.conf /etc/nginx/nginx.conf

echo -e \\e[35m Installing Nodejs \\e[0m
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs

echo -e \\e[35m Downloading Frontend Code\\e[0m
curl -L -o /tmp/frontend.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip
rm -rf /tmp/frontend
mkdir -p /tmp/frontend && cd /tmp/frontend

echo -e \\e[35m Extracting Frontend Code\\e[1m
unzip /tmp/frontend.zip

echo -e \\e[35m Compiling Frontend Code\\e[0m
npm install
npm run build

echo -e \\e[35m Copy Complied Code to Nginx\\e[0m
rm -rf /usr/share/nginx/html/*
cp -r out/* /usr/share/nginx/html/

echo -e \\e[35m Start Nginx Service\\e[0m
systemctl enable nginx
systemctl restart nginx