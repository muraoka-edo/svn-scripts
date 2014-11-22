# http://qiita.com/quattro_4/items/769f875baa17ce4725e8
DESC="Jenkins CI Server"
NAME=jenkins
PIDFILE=/tmp/jenkins.pid
JAR=/usr/local/opt/jenkins/libexec/jenkins.war
RUN_AS=edo
HTTP_HOST=0.0.0.0
HTTP_PORT=8080
LOG_PATH=/Users/$RUN_AS/.jenkins/access.log

nohup /usr/bin/java -Xms512m -Xmx512m -XX:PermSize=192m -XX:MaxPermSize=192m -jar $JAR --httpListenAddress=$HTTP_HOST --httpPort=$HTTP_PORT --accessLoggerClassName=winstone.accesslog.SimpleAccessLogger --simpleAccessLogger.format=combined --simpleAccessLogger.file=$LOG_PATH &> /tmp/jenkins_nohup.out &
