# HitArena

HitArena 是一套面向多人智能拳击比赛的 Android 应用及云端服务。

## 项目结构

- `hitrise-android/`：HitArena Android 客户端源码。
- `hitrise-server/`：云端 API、数据库模型、SQL 结构及部署脚本。
- `工程文件/`：产品及蓝牙协议文档。
- `HitArena app.png`：APP 图标原始图片。

## 核心功能

- 最多五个靶位分别连接蓝牙传感器，并记忆及自动重连。
- 横屏竞技场、多人选手昵称、倒计时和实时击打数据。
- 次数赛、力量赛及综合赛计分规则。
- 竞技结果、竞技排名和 HitArena Certified Device 可信比赛。
- 用户可选的认证比赛数据上传。
- 简体中文、English、Français、ไทย 四种界面语言。

## Android 构建

使用 Android Studio 打开 `hitrise-android`，或在该目录使用 Gradle 8.7 构建：

```powershell
gradle packageDebugApk
```

本机的 `local.properties`、Gradle 缓存和构建产物不会提交到仓库。

## 服务端

服务端位于 `hitrise-server`，使用 FastAPI、MySQL 和 Docker。先复制环境变量示例并填写部署环境自己的密钥：

```bash
cp .env.example .env
```

不要将 `.env`、数据库密码、SSH 凭据或管理令牌提交到仓库。

