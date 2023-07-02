# 11 用 uint 来节省重入保护的 gas

## 运行

根据[Foundry 官方文档](https://getfoundry.sh/)配置好运行环境后，于本项目下执行下列命令，即可看到实际 gas 差异对比。

```bash
forge test --contracts 11_ReentrancyGuard/ReentrancyGuard.T.sol --gas-report
```

## 功能简述

利用 modifier 来验证合约的重入调用。设置一个 Bool 变量，每次调用的时候都验证当前是否为锁定状态。只有未锁定时，才会执行函数调用，函数结束时再次恢复锁的状态，同样，我们也可以用 Uint 变量来解决重入调用。

## DemoCode

下面分别用 Bool、Uint01 和 Uint12(使用默认值 0 和非 0 初始化)三种形式解决重入调用，来观察其 gas 差异。

```solidity
contract ReentrancyGuardBool{
    bool private locked  = false;
    modifier nonReentrant(){
        require(locked == false,"REENTRANCY");
        locked = true;
        _;
        locked = false;
    }
}

contract ReentrancyGuardUint01{
    uint256 private locked = 0;
    modifier nonReentrant(){
        require(locked == 0,"REENTRANCY");
        locked = 1;
        _;
        locked = 0;
    }
}

contract ReentrancyGuardUint12{
    uint256 private locked = 1;
    modifier nonReentrant(){
        require(locked == 1,"REENTRANCY");
        locked = 2;
        _;
        locked = 1;
    }
}

```

以下是测试后的情况说明，gas 优化建议如下：

因为部署产生的 gas 是一次性的，开发者一般会关注日常交易产生的 gas，所以需要在不考虑部署 gas 的情况下分开说明：

1. 使用 Bool：EVM 将布尔值存储为 uint8 类型，占用两个字节，因此访问该值实际上更昂贵。这是因为 EVM 单词长度为 32 字节，所以需要额外的逻辑来告诉虚拟机解析小于标准大小的值；
2. 使用 Uint01：在每次调用时将 0 更改到非 0 时会产生 ≈ 20k 的 gas；
3. 使用 Uint12：在每次调用时将非 0 值更改为非 0 值时，只会产生 2900 的 gas。

因为一般重入保护函数是会被多次调用的，所以建议使用 Uint12 这种方式。

| 重入保护 | gas 消耗 | 节省  | 结果    |
| -------- | -------- | ----- | ------- |
| Bool     | 27757    |       |         |
| Uint01   | 27604    | 153   |         |
| Uint12   | 13908    | 13849 | ✅ 建议 |

有点好奇，为啥要帮重入攻击者节省 gas，后来仔细一下，每个用户都要调用这个函数，重入保护在某些情况下又必不可少，所以需要考虑优化 gas。
