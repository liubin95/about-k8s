## 宿主机

```shell
echo 'vm.max_map_count=262144' >>/etc/sysctl.conf
sysctl -w vm.max_map_count=262144

```

## ECK

### 简介

ECK，全称Elastic Cloud on Kubernetes，是Elastic公司为Kubernetes环境提供的官方Elasticsearch和Kibana部署运维解决方案。ECK基于Kubernetes
Operator模式设计，可以帮助用户在Kubernetes环境中轻松部署和管理Elasticsearch集群和Kibana实例。

ECK提供了以下主要功能：

1. **简化部署**
   ：ECK提供了一种简单的方式来部署Elasticsearch和Kibana。用户只需要创建一个简单的YAML文件，描述所需的Elasticsearch集群或Kibana实例的配置，然后使用`kubectl apply`
   命令将其应用到Kubernetes集群。

2. **自动运维**：ECK可以自动处理Elasticsearch和Kibana的运维任务，如版本升级、配置调整、故障恢复等。这极大地简化了Elasticsearch和Kibana的管理工作。

3. **集成Kubernetes特性**：ECK充分利用了Kubernetes的特性，如Pods、StatefulSets、PersistentVolumes、Services等，提供了高可用、可扩展、持久化存储等特性。

4. **安全**：ECK支持Elasticsearch的安全特性，如TLS加密、基于角色的访问控制（RBAC）、API密钥等。

要在Kubernetes环境中部署Elasticsearch集群，你需要首先安装ECK
Operator，然后创建一个Elasticsearch资源的YAML文件，描述你所需的集群配置，如节点数、版本、存储大小等，最后使用`kubectl apply`
命令将其应用到Kubernetes集群。ECK Operator会自动创建和配置Elasticsearch集群，并确保其正常运行。

### 安装

在Kubernetes集群中部署ECK（Elastic Cloud on Kubernetes）Operator的步骤如下：

1. **安装自定义资源定义（CRD）**
   ：ECK使用Kubernetes的自定义资源定义（CRD）来描述Elasticsearch和Kibana的配置。首先，你需要从Elastic的官方网站下载并安装这些CRD。可以使用以下命令：

   ```bash
   kubectl create -f https://download.elastic.co/downloads/eck/2.8.0/crds.yaml
   ```

2. **安装ECK Operator**：然后，你可以从Elastic的官方网站下载并安装ECK Operator。可以使用以下命令：

   ```bash
   kubectl apply -f https://download.elastic.co/downloads/eck/2.8.0/operator.yaml
   ```

   这个命令会在`elastic-system`命名空间中创建一个StatefulSet，运行ECK Operator。

3. **监控ECK Operator的日志**：你可以使用以下命令来查看ECK Operator的日志，以确保它正在正常运行：

   ```bash
   kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
   ```

请注意，这些步骤假设你的Kubernetes集群已经正常运行，并且你有足够的权限来创建CRD和StatefulSet。如果你使用的是GKE或Amazon
EKS，你可能需要额外的配置来确保ECK Operator可以正常工作。具体的配置步骤可以参考Elastic的官方文档。

### 使用
