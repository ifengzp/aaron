---
title: js异步方案
tags: js
---

先理解什么是异步和同步：比如我要做一顿饭，我要先淘米煮饭，等饭好了才能去炒菜，一件事一件事地做，这个是同步；还是煮饭，但是我淘米然后按下电饭煲的开关后，我可以去炒菜，然后等到我炒完菜的时候饭也煮好了，这个是同步；可以简单地认为一个**不连续的任务执行过程**就是异步，而**异步编程的语法目标，就是怎样让它更像同步编程**，Js在处理异步方面有这几种方案：**callback、发布订阅模式、promise、generator、async/await**，我们下面就来具体分析深入这些方案的具体原理和实现细节
<!-- more -->

## callback

回调函数是异步编程的最基本方法，把回调的函数传给当前的异步执行函数，等待异步任务执行结束后后就去调用回调函数，比如👇

```js
    function fn1(callback) {
    	setTimeout(() => {
    		callback && callback()
    	}, 1000)
    }
    function fn2() {
    	console.log('fn2')
    }
    fn1(fn2)
```

回调函数本身没有问题，但是当你有一连串的回调操作的时候，不合理的代码组织可能就会出现问题：

```js
    fs.readdir(source, function (err, files) {
      if (err) {
        console.log('Error finding files: ' + err)
      } else {
        files.forEach(function (filename, fileIndex) {
          console.log(filename)
          gm(source + filename).size(function (err, values) {
            if (err) {
              console.log('Error identifying file size: ' + err)
            } else {
              console.log(filename + ' : ' + values)
              aspect = (values.width / values.height)
              widths.forEach(function (width, widthIndex) {
                height = Math.round(width / aspect)
                console.log('resizing ' + filename + 'to ' + height + 'x' + height)
                this.resize(width, height).write(dest + 'w' + width + '_' + filename, function(err) {
                  if (err) console.log('Error writing file: ' + err)
                })
              }.bind(this))
            }
          })
        })
      }
    })
```

上面就是一个很糟糕的的多重回调嵌套，在生产环境中，每个回调函数里面都是不一样的代码，多写几行你就分不清`})` 对应的是哪个函数了，它的代码会越来越臃肿，而且完全耦合在一起，你很难去维护这部分的代码，这种糟糕的代码组织方式被称为”回调地狱“，在[callback hell](http://callbackhell.com/)一文中，提到有三种优化回调地狱的方法：**具名函数、提取成模块、优先处理错误**。具名函数是指不要把回调函数写成匿名函数，而是它单独拎出来作为一个具名函数，然后再在回调里面取调用这个具名函数，它的具体逻辑就不会出现在嵌套的代码块里面了；提取模块也是差不多的道理，其实我可能根本就不需要知道回调函数里面的逻辑，那就把回调函数单独提到一个模块里面，我只要去调用模块就可以了，这个模块里面可能有一大堆逻辑，包括嵌套调用什么的，但是那是维护这个模块的工作，我只是调用这个模块暴露的方法，那我的代码组织里面自然就看不到那一坨嵌套的回调；以上两种规则主要是让你的代码更加可读，最后一条规则是优先处理错误，它其实也是一种约定的代码方式而且它还能够让你的代码更加可靠，在异步任务执行的时候，错误什么时候反生你是不知道的，你在回调中拿到异步返回的结果，所以在node中都是约定约定回调函数的第一个参数就是err，没有错误的时候就返回null，在异步回调中建议要**优先处理返回的每一个错误**，比如**👇**

```js
    var fs = require('fs')
    fs.readFile('/Does/not/exist', handleFile)
    
    function handleFile (error, file) {
      if (error) return console.error('Uhoh, there was an error', error)
      // otherwise, continue on and use `file` in your code
    }
```

## **发布订阅模式**

