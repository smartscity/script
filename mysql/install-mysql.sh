# shell

version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`


rpm -qa | grep mysql


wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update
yum install mysql-server

mysqld --initialize

# 启动

if [ $version -eq 6 ]; then
	echo "start centos 6 mysql"
	service mysqld start

	service mysqld status
fi

if [ $version -eq 7 ]; then
	echo "int mysql at centos 7"
	mysqld --initialize
	echo "start mysql at centos 7"
	systemctl start mysqld

	systemctl status mysqld
fi

mysqladmin -u root password "123456";

echo "开启远程访问"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';"
mysql -u root -p123456


echo "端口开放"
if [ $version -eq 6 ]; then
	iptables -I INPUT -p tcp --dport 80 -j ACCEPT
	iptables -I INPUT -p tcp --dport 22 -j ACCEPT
	iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
	service iptables save
	service iptables restart
fi
