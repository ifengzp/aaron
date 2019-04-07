---
title: css实现逐帧动画
date: 2016-06-01 11:55:00
tags: css
---

css3里面的animation属性非常强大，但是自己用的比较少，最近有次面试就刚好被问到了，趁现在有时间就对animation做一个小总结。同时实现一个逐帧动画的demo作为练习
<!-- more -->

# animation属性一览
因为animation属性比较多，干脆也做了一份导图，以后想查看，就一目了然了
![](http://cdn.blog.ifengzp.com/animation/animation_attr.jpg)

# keyframes实现帧动画
熟悉了animation的属性之后，得找个简单的小项目实现下，逐帧动画好有意思，先跑一个满足下自己。思路很简单，就是给元素一个雪碧图的背景，然后添加的帧动画更改`background-position`，关键代码：
```css
    @keyframes run{
        from{
            background-position: 0 0;
        }
        to{
            background-position: -1540px 0 ;
        }
    }
    div{
        width:140px;
        height:140px;
        background: url(run.png);
        animation-name：run;
        animation-duration:1s;
        animation-iteration-count:infinite;
    }
```
![](http://cdn.blog.ifengzp.com/animation/step_gif_half.gif)

但是跑起来后我们发现，每帧动画之间帧动画都是滑动，并不是我们要的效果,为什么呢？
原来animation默认以ease方式过渡，它会在每个关键帧之间插入补间动画，所以动画效果是连贯性的，知道原因就好办了，解决思路就是：
```css
@keyframes run{
    0%, 8%{  /*动作一*/  }
    9.2%, 17.2%{  /*动作二*/  }
    ...
}
```
step1：动作之间停留8帧，0%设置动作一，动作一结束在8%
step2：动作之间过渡1.2帧，9.2%设置动作二，动作二结束在17.2%

<details>
    <summary>完整代码：</summary>
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>css3逐帧动画</title>
        <style>
        @keyframes run{
        0%, 8%{  background-position: 0 0;  }
        9.2%, 17.2%{  background-position: -140px 0;  }
        18.4%, 26.4%{  background-position: -280px 0 ;  }
        27.6%, 35.6%{  background-position: -420px 0 ;  }
        36.8%, 44.8%{  background-position: -560px 0 ;  }
        46%, 54%{  background-position: -700px 0 ;  }
        55.2%, 63.2%{  background-position: -840px 0 ;  }
        64.4%, 72.4%{  background-position: -980px 0 ;  }
        73.6%, 81.6%{  background-position: -1120px 0 ;  }
        82.8%, 90.8%{  background-position: -1400px 0 ;  }
        92%, 100%{  background-position: -1540px 0 ;  }
        }
        @-webkit-keyframes run{
        0%, 8%{  background-position: 0 0;  }
        9.2%, 17.2%{  background-position: -140px 0;  }
        18.4%, 26.4%{  background-position: -280px 0 ;  }
        27.6%, 35.6%{  background-position: -420px 0 ;  }
        36.8%, 44.8%{  background-position: -560px 0 ;  }
        46%, 54%{  background-position: -700px 0 ;  }
        55.2%, 63.2%{  background-position: -840px 0 ;  }
        64.4%, 72.4%{  background-position: -980px 0 ;  }
        73.6%, 81.6%{  background-position: -1120px 0 ;  }
        82.8%, 90.8%{  background-position: -1400px 0 ;  }
        92%, 100%{  background-position: -1540px 0 ;  }
        }
        div{
            width:140px;
            height:140px;
            background: url(http://images2015.cnblogs.com/blog/754767/201606/754767-20160601000042992-1734972084.png) ;
            animation:run 1s infinite;
                -webkit-animation:run 1s infinite;
            animation-fill-mode : backwards;
                -webkit-animation-fill-mode : backwards;
        }
        </style>
    </head>
    <body>
        <div></div>
    </body>
    </html>
    ```
</details>

# steps方法
还有另外一个实现方法，就是利用steps(),就是帧之间的阶跃动画，先贴个图
![](http://cdn.blog.ifengzp.com/animation/animation_step.png)

由上图可知:
steps(1,start):动画一开始就跳到 100% 直到这一帧（不是整个周期）结束
steps(1,end):保持 0% 的样式直到这一帧（不是整个周期）结束
另外也可以直接设置 `animation-timing-function:step-start/step-end`
step-start效果等同于steps(1,start)，step-end效果等同于steps(1,end)

最终效果，因为录制的问题可能有点卡顿，有兴趣的同学可以直接复制代码去跑下：
![](http://cdn.blog.ifengzp.com/animation/step_gif_finish.gif)

<details>
    <summary>完整代码：</summary>
    ```html
    <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>css3逐帧动画</title>
            <style>
            @keyframes run{
                0%{
                    background-position: 0 0;
                }
                8.333%{
                    background-position: -140px 0;
                }
                16.666%{
                    background-position: -280px 0 ;
                }
                25.0%{
                    background-position: -420px 0 ;
                }
                33.333%{
                    background-position: -560px 0 ;
                }
                41.666%{
                    background-position: -700px 0 ;
                }
                50.0%{
                    background-position: -840px 0 ;
                }
                58.333%{
                    background-position: -980px 0 ;
                }
                66.666%{
                    background-position: -1120px 0 ;
                }
                75.0%{
                    background-position: -1260px 0 ;
                }
                83.333%{
                    background-position: -1400px 0 ;
                }
                91.666%{
                    background-position: -1540px 0 ;
                }
                100%{
                    background-position: 0 0 ;
                }
            }
            @-webkit-keyframes run{
                0%{
                    background-position: 0 0;
                }
                8.333%{
                    background-position: -140px 0;
                }
                16.666%{
                    background-position: -280px 0 ;
                }
                25.0%{
                    background-position: -420px 0 ;
                }
                33.333%{
                    background-position: -560px 0 ;
                }
                41.666%{
                    background-position: -700px 0 ;
                }
                50.0%{
                    background-position: -840px 0 ;
                }
                58.333%{
                    background-position: -980px 0 ;
                }
                66.666%{
                    background-position: -1120px 0 ;
                }
                75.0%{
                    background-position: -1260px 0 ;
                }
                83.333%{
                    background-position: -1400px 0 ;
                }
                91.666%{
                    background-position: -1540px 0 ;
                }
                100%{
                    background-position: 0 0 ;
                }
            }
            div{
                width:140px;
                height:140px;
                background: url(http://images2015.cnblogs.com/blog/754767/201606/754767-20160601000042992-1734972084.png) ;
                animation:run 1s steps(1, start) infinite;
                    -webkit-animation:run 1s steps(1, start) infinite;
            }
            </style>
        </head>
        <body>
            <div></div>
        </body>
    ```
</details>
