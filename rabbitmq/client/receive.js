import client from "amqplib";

const user = process.env.RABBITMQ_USER
const pass = process.env.RABBITMQ_PASS
const ep = process.env.RABBITMQ_HOST
const queue = process.env.RABBITMQ_QUEUE

const connect = await client.connect(`amqp://${user}:${pass}@${ep}/`)
console.log(`✅ Rabbit MQ Connection is ready`);

const channel = await connect.createChannel();
console.log(`🛸 Created RabbitMQ Channel successfully`);
channel.on('error', (err) => {
  // recover or exit
  console.log(err);
  channel.reply
});

console.log(" [*] Waiting for messages in %s. To exit press CTRL+C", queue);

void channel.consume(queue, function (msg) {
  console.log(" [x] Received %s", msg.content.toString());
}, {
  noAck: true
});

