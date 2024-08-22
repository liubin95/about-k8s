## 给每一个node发送请求

> daemonset 重新加载configmap

```shell
# 排除master节点
# 获取所有ready的node的ip
# 生成curl请求
# 替换端口和路径
result=$(k get node -owide | grep -v 'control-plane' | awk '$2 == "Ready"&&NR>1 {print $6}' | cut -d"." -f 4 | paste -sd',' -) && echo "curl --remote-name-all -sS --max-time 5 172.16.20.{REPLACE_ME}:2020/api/v2/reload" | sed "s/REPLACE_ME/$result/"

```
