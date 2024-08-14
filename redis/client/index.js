import Redis from "ioredis";

const redis = new Redis({
  sentinels: [
    {host: "redis-master", port: 26379},
    {host: "redis-replication-1", port: 26379},
    {host: "redis-replication-2", port: 26379},
  ],
  name: "mymaster",
});
console.log("Connected to Redis", redis.status);

for (; ;) {
  await sleep(2000);
  let status = redis.status;
  console.log("Connected to Redis", redis.status);
  if (status === "ready") {
    break;
  }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

for (; ;) {
  console.log(await redis.get("time"));
  await sleep(2000);
  redis.set("time", new Date().toLocaleString());
}
