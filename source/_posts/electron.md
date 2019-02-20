---
title: electron 开发
date: 2018-10-21 20:00:00
tags: 
- electron
- node
---

electron框架可以让你用JavaScript/Html/Css等网站相关技术，非常快速而容易地搭建一个原生应用。我们熟悉的Vscode，Atom，github desktop等常见软件都是使用electron搭建的，而且electron还是一个多平台框架，一份代码可以同时打包出适用于Mac, Windows 和 Linux三个平台的原生应用。目前electron的star数已经将近66k，生态已经非常成熟。
<!-- more -->

# Electron = node + chromium
electron使用web页面作为应用的GUI，其原理就是自己定制一个浏览器，让我们的web代码跑在这个定制的浏览器上面，electron使用的是chromium浏览器，我们写的页面就是跑在这个浏览器上的，所有的node api包括第三方模块都可以在electron中使用。这样子node + chromium就构成了我的的原生应用

# 主进程和渲染进程
![api](http://qiniu.orlearn.cn/electron/electron_api.png)
1. 主进程主要通过Node.js、Chromium和Native APIs来实现一些系统以及底层的操作，比如创建窗口，创建系统菜单等
2. 渲染进程主要通过Chromium来实现APP的图形界面——就是平时我们熟悉的前端开发的部分，不过得到了electron给予的加强，一些Node的模块（比如fs）和一些在Main进程里能用的东西（比如Clipboard）也能在Render进程里使用。
3. 主进程和渲染进程红可以使用的api

# 进程间通讯
## electron提供ipc模块进行进程间通讯
![api](http://qiniu.orlearn.cn/electron/electron_ipc2.png)
如上图所示，ipc是一个一对多的传播机制，具体传播机制如下
- 渲染进程订阅传播事件
- 主进程发送消息
- 渲染进程接收消息

```js
// 主进程中广播sayInfo事件，
const window = new BrowserWindow()
window.webContents.send('sayInfo', 'Hi')

// 在window中订阅sayInfo事件，并把返回值打印出来
ipcRenderer.on('sayInfo', info => {
  console.log(info) // Hi
})
```

## 渲染进程向主进程通讯
![api](http://qiniu.orlearn.cn/electron/electron_ipc1.png)
如上图所示：
- 渲染进程订阅传播事件
- 主进程发送消息
- 渲染进程接收消息

```js
  // 主进程中订阅sayInfo事件，处理回调
  ipcMain.on('sayInfo', (event, info) => {
      console.log(info) // Hi
    });
  // 渲染进程中广播sayInfo事件，传递参数
  ipcRenderer.send('sayInfo', 'Hi');
```

## 渲染进程之间通讯
  渲染进程之间不允许直接通讯，要通过主进程作为媒介，比如rendererA要向rendererB传递消息，只能先传给主进程，主进程再广播给rendererB

# 多任务并行
- 在渲染进程中可以使用web worker，但是可能会有崩溃，内存溢出等问题
- 可以使用child_process创建子进程，但是在子进程中不能使用electron中的api
- 可以新建一个隐藏的渲染进程，在里面处理逻辑

# 数据存储
因为electron的本质是chromium浏览器，所以浏览器自身的数据存储方式像Cookies，Local Storage，Session Storage，IndexedDB都可以使用，但是因为有node的加持，我们也可以使用第三方的嵌入式数据库，比如NeDB，LowDB等

# 应用更新
electron生态圈里有相应的更新模块，比如electron-updater， electron-custom-updater等，同时也可以有简单粗暴的方式，当有新版本的时候，直接下载然后退出安装，同时也可以通过更换asar包的方式，速度更快





