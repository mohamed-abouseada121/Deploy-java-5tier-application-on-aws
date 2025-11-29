#!/bin/bash
# Update and install Java 11, Maven, Tomcat 9, and MySQL Client
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
sudo apt install tomcat9 -y
sudo apt install mysql-client -y

# Clone the repository
git clone https://github.com/abdelrahmanonline4/sourcecodeseniorwr.git
cd sourcecodeseniorwr

# Configure application.properties
cat <<EOF > src/main/resources/application.properties
jdbc.url=jdbc:mysql://db01.vprofile.in:3306/accounts?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
jdbc.username=admin
jdbc.password=admin123

# Memcached Configuration (ElastiCache)
memcached.active.host=mc01.vprofile.in
memcached.active.port=11211
# Memcached Standby Configuration
memcached.standBy.host=mc01.vprofile.in
memcached.standBy.port=11211
# RabbitMQ Configuration (Amazon MQ)
rabbitmq.address=rmq01.vprofile.in
rabbitmq.port=5672
rabbitmq.username=rabbit
rabbitmq.password=guest1234567

#Elasticesearch Configuration
elasticsearch.host =vprosearch01
elasticsearch.port =9300
elasticsearch.cluster=vprofile
elasticsearch.node=vprofilenode
EOF

# Build the artifact
mvn install

# Initialize Database
# Note: This assumes the RDS instance is reachable and ready. 
# In a real-world scenario, you might need a wait loop or separate initialization step.
mysql -h db01.vprofile.in -u admin -padmin123 accounts < src/main/resources/db_backup.sql

# Deploy Application
sudo systemctl stop tomcat9
sudo rm -rf /var/lib/tomcat9/webapps/ROOT
sudo cp target/vprofile-v2.war /var/lib/tomcat9/webapps/ROOT.war
sudo chown -R tomcat:tomcat /var/lib/tomcat9/webapps/
sudo systemctl start tomcat9
