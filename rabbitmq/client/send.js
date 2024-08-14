import client from "amqplib";

const user = process.env.RABBITMQ_USER
const pass = process.env.RABBITMQ_PASS
const ep = process.env.RABBITMQ_HOST
const queue = process.env.RABBITMQ_QUEUE

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const connect = await client.connect(`amqp://${user}:${pass}@${ep}/`)
console.log(`✅ Rabbit MQ Connection is ready`);
let channel = await connect.createChannel();
console.log(`🛸 Created RabbitMQ Channel successfully`);
channel.on('error', async (err) => {
  // recover or exit
  console.log(err);
  channel = await connect.createChannel();
  void sendMsg(channel);
});
void sendMsg(channel);

async function sendMsg(channel) {
  for (; ;) {
    await sleep(2000);
    const msg = new Date().toLocaleString();

    channel.sendToQueue(queue, Buffer.from(msg));
    console.log(" [x] Sent %s", msg);
  }

}
