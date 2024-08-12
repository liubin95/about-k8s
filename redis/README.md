## sentinel

## cluster

## replication

Redis 默认使用异步复制，具有低延迟和高性能的特点，是绝大多数 Redis 使用场景的自然复制模式。但是，Redis
副本会异步确认它们定期与主服务器接收的数据量。因此，主服务器不会每次都等待副本处理命令，但如果需要，它知道哪个副本已经处理了哪个命令。这允许具有可选的同步复制

### 持久化数据

- https://redis.io/docs/latest/operate/oss_and_stack/management/replication/#safety-of-replication-when-master-has-persistence-turned-off
