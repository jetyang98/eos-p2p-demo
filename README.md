# EOS 测试多节点同步情况

## 一、下载并安装 EOSIO

```bash
wget https://github.com/eosio/eos/releases/download/v2.1.0/eosio_2.1.0-1-ubuntu-20.04_amd64.deb
sudo apt install ./eosio_2.1.0-1-ubuntu-20.04_amd64.deb
```

因为不涉及智能合约，所以不用安装 EOSIO.CDT。

## 二、创建钱包

### 1、创建钱包	

```shell
cleos wallet create --to-console
```

### 2、解锁钱包

```shell
cleos wallet unlock
```

解锁的钱包后会有一个星号（*）表明钱包处于解锁状态。

### 3、创建密钥

```shell
cleos wallet create_key
```

### 4、导入 eosio 用户的密钥

```shell
cleos wallet import 5J3CNYueS33xnX9yEspHjDG89WhWQRNfqRoo2b2cjSpyeK1CQyw
```

输入 eosio 用户的私钥导入该用户。

## 三、启动 keosd

```bash
keosd &
```

## 四、创建用户

### 1、a1 用户

```bash
cleos create account eosio a1 EOS5GYr1ysNHjoaDsKnGFHWzx3YSS5jNFTrtr4cECnNgyVJfkkAYe
```

OwnerKey 和 ActiveKey 相同。

### 2、a2 用户

```bash
cleos create account eosio a2 EOS5effqCyFit92RxGRpoyRg2aQfj67P1gNBzzT8HpoZ46pj6FC9T
```

## 五、测试多节点同步情况

有三个文件夹 genesis、a1、a2，对应三个节点和三个账户。这三个节点公用一个 genesis.json 文件，只有 genesis.json 文件相同，起点启动时的 chain_id 才相同，节点之间才能同步区块。

### 一、启动节点

依次（genesis、a1、a2）运行 genesis_start.sh 脚本。

```bash
cd genesis
./genesis_start.sh
```

### 二、查看区块同步情况

```bash
# genesis 节点
cleos -u http://localhost:8888 get info
# a1 节点
cleos -u http://localhost:8011 get info
# a2 节点
cleos -u http://localhost:8012 get info
```

### 三、查看节点连接情况

```bash
# genesis 节点
cleos -u http://localhost:8888 net peers
# a1 节点
cleos -u http://localhost:8011 net peers
# a2 节点
cleos -u http://localhost:8012 net peers
```

genesis 节点只设置了 p2p-listen-endpoint，没有设置 p2p-peer-address。

a1 节点设置了 p2p-peer-address=localhost:9010，即 a1 和 genesis 节点连接了。

a2 节点设置了 p2p-peer-address=localhost:9011，即 a2 和 a1 连接了。