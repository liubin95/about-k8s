-- 用户和权限 master
create user 'repl_user'@'%' identified by '123456';
Grant replication slave on *.* to 'repl_user'@'%';
-- 开启同步 salve
CHANGE REPLICATION SOURCE TO SOURCE_HOST = 'mysql_master',SOURCE_PORT = 3306,SOURCE_USER = 'repl_user',SOURCE_PASSWORD = '123456',SOURCE_AUTO_POSITION = 1;
start slave;