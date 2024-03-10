# 简介
记录一些命令行配置和开发工具配置

## Windows
### Windows下使用Zsh
- 需要一个Cygwin环境，使用git bash
- 下载 [Zsh][zsh package]
- 将下载的压缩包中的文件覆盖入Git根目录，重启git bash输入zsh命令查看是否安装Zsh
- 创建.bashrc键入已下内容
``` shell
if [ -t 1 ]; then
    exec zsh
fi
```
默认开启zsh


[zsh package]: https://packages.msys2.org
