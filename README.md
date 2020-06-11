leeAdmin
===============
演示地址：http://leeadmin.leelink.top/admin/
> 运行环境要求PHP7.1+。

## 主要新特性

* ThinkPhp6
* LayUi2
* 多应用支持
* 模块分组开发
* api开发实例
* apidoc 生成api文档
* 中间件处理
* 后台日志自动生成
* 顶部导航菜单分组
* 微信开发实例
* 接口基于JWT的access_token无状态登录
* 开箱即用易扩展

## 安装

~~~
1.将下载好的leeAdmin源码放入你的localhost环境中；

2.运行目录指向public；

3.导入leeadmin_leelink.sql (加群获取 347255313 <a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=4a1d4f3e1d2c9a0cb344f4a86a5673bd4418c1eda77f7e4cb1ba50eee9c96135"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="leeAdmin框架交流群" title="leeAdmin框架交流群"></a>)。

4.根目录下执行 composer install
~~~

如何使用apidoc
~~~
1.安装apidoc(不做赘述)
2.根目录下 apidoc -i ./app/api -o ./public/port
3.访问 (你的项目地址)/port
~~~

## 版权信息

leeAdmin遵循Apache2开源协议发布，并提供免费使用。

本项目包含的第三方源码和二进制文件之版权信息另行标注。

版权所有Copyright © 2006-2020 by leeAdmin (http://blog.leelink.top)

##感谢（排名不分先后）

ThinkPHP：https://github.com/top-think/framework

Layuimini：https://github.com/zhongshaofa/layuimini

Layui：https://github.com/sentsin/layui

Jquery：https://github.com/jquery/jquery

vaeThink: https://github.com/tingyuu/vaeThink2

Echarts：https://github.com/apache/incubator-echarts
