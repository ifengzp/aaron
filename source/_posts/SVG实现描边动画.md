---
title: SVG实现描边动画
date: 2016-06-06 19:14:00
tags: css
---

说起SVG，我是恨它又爱它，恨它是因为刚开始接触的时候自己傻B地想用代码去写它，其实在web上我们用它做交互也只是用了几个常用的特性而已，其他的标签知道这么一回事就成了，其实说白了它就是一种图片格式，你得去画它，网站上最长用的SVG交互效果就是描边动画了，今天就来实现它
<!-- more -->

先上效果图：
![](http://qiniu.orlearn.cn/svg/svg_dash_animate_01.gif)
思路：要实现这种动画，我们要使用的是SVG的路径path标签，其中然后配合两个属性：stroke-dasharray和stroke-dashoffset，至于用什么方式实现动画效果就八仙过海了，我这里使用的是css3的animation

# 第一步：了解SVG的path
中文的意思就是路径，描边动画嘛，你得先给个路线我才能描边啊，路径就是这个路线：
![](http://qiniu.orlearn.cn/svg/svg_dash_animate_02.png)
先上网找个图片，放进AI里面，然后用钢笔勾勒路径，再把图片删掉，剩下路径，把它另存为svg，然后把它拖进编译器里，就能看到一堆代码，我们只要保留其中的path就好（不会用AI的给你个理由去勾搭设计师美眉）

# 第二步：了解stroke-dasharray和stroke-dashoffset
理解字面意思就好：
stroke-dasharray：就是把线条断开为虚线，下图就是我把stroke-dasharray设置为10的效果，它就变成虚线了，数值越大，线就越长
stroke-dashoffset：就是设置线条的偏移，设置了这个值后，线段就会偏移相应的值，我们要实现动画只要动态改变这个偏移值就好，那样线条就会动起来了
![](http://qiniu.orlearn.cn/svg/svg_dash_animate_03.png)


# 第三步：利用@keyframes实现动态描边
```css
@keyframes describe{
	from{
		stroke-dashoffset: 1000;
		opacity: 1;
	}
	to{
		stroke-dashoffset: 0;
		opacity: 0;
	}
}
```
![](http://qiniu.orlearn.cn/svg/svg_dash_animate_04.gif)
额~~有点快，没关系，明白意思就好，最后，描边完成之后再插入一个动画，让背景图片淡入，最终效果如下：
![](http://qiniu.orlearn.cn/svg/svg_dash_animate_05.gif)
下班了，不调了，如果再慢点效果估计更好

<details>
    <summary>完整代码：</summary>
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>super</title>
        <script src="vivus.js"></script>
        <style>
        .super_logo{
            position: absolute;
            opacity: 0;
            animation:fadeIn 1s ease-in  forwards;
                -webkit-animation:fadeIn 1s ease-in  forwards;
        }
        #super{
            position: absolute;
            z-index: 1;
            stroke-dasharray: 800;
            stroke-dashoffset: 1000;
            animation: describe 2s forwards;
                -webkit-animation: describe 2s forwards;
        }
        @keyframes fadeIn{
            from{opacity: 0;}
            80%{opacity: 0.5;}
            to{opacity: 1;}
        }
        @-webkit-keyframes fadeIn{
            from{opacity: 0;}
            80%{opacity: 0.5;}
            to{opacity: 1;}
        }
        @keyframes describe{
            from{
                stroke-dashoffset: 1000;
                opacity: 1;
            }
            to{
                stroke-dashoffset: 0;
                opacity: 0;
            }
        }
        @-webkit-keyframes describe{
            from{
                stroke-dashoffset: 1000;
                opacity: 1;
            }
            to{
                stroke-dashoffset: 0;
                opacity: 0;
            }
        }
        </style>
    </head>
    <body style="background:#0f1a3a;">
    <img src="http://images2015.cnblogs.com/blog/754767/201606/754767-20160606165217980-1558570494.gif" alt="super" class="super_logo">
    <svg id="super" x="0px" y="0px" width="293px" height="200px" viewBox="0 0 293 200">
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M67.667,39.667c0,0-33.334,17.333-46.667,36.667
            c0,0,33.007,40.458,43.331,50.018c19.419,17.982,65.002,55.316,82.169,59.982c0,0,27.834-11.334,49.834-30.667S249,113,261,100
            s9.334-12.333,15.334-22.333c0,0-21.333-29.333-44-38c0,0-162.001-5.334-163.334-2.667"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M169.667,50.333c0,0-71.334-2.667-74.667,8.667s42,14,42,14
            s55.333,4.667,60,6.667s32.668,7.254,43.334,31.627L255,93.667C255,93.667,217,59,169.667,50.333z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M75.667,123c0,0,42,8,78,8.667s32.667,10.667,32.667,10.667
            S185.333,155,146.5,153.667S75.667,123,75.667,123z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M45,93c0,0-12.667-24,34-48h-8.667c0,0-35.455,24.559-36,35.677L45,93
            z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M174.912,161c0,0-24.745,12.999-24.745,12.333
            s-15.25-4.249-20.583-10.416"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M130,162.667c0,0,1.75-3.083,13.667-1.25c0,0,30,0.836,30.75-0.582"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M177.75,43L224,45.5c0,0,7.5,12.125-13,8.625S177.75,43,177.75,43z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M237.25,52c0,0,2.75,20.375,21.875,35.625l5.75-6.948
            C264.875,80.677,249.273,55.266,237.25,52z"/>
    </svg>
    </body>
    </html>
    ```
</details>

恩恩~~写到这里我的肚子饿惨了，他们都下班去吃饭了，打字这么开心我干脆再介绍个插件，那就vivus.js

Vivus是一款可以执行SVG路径动画的轻量级Javascript库，github地址：https://github.com/maxwellito/vivus

扔个中文的介绍http://www.htmleaf.com/html5/SVG/201501261279.html

写的还可以，我就不重复码字了，直接上demo：
<details>
    <summary>完整代码：</summary>
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>super</title>
        <script src="vivus.js"></script>
        <style>
        .super_logo{
            position: absolute;
        }
        #super{
            position: absolute;
            z-index: 1;
        }
        </style>
    </head>
    <body style="background:#0f1a3a;">
    <img src="super.gif" alt="super" class="super_logo">
    <svg id="super" x="0px" y="0px" width="293px" height="200px" viewBox="0 0 293 200">
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M67.667,39.667c0,0-33.334,17.333-46.667,36.667
            c0,0,33.007,40.458,43.331,50.018c19.419,17.982,65.002,55.316,82.169,59.982c0,0,27.834-11.334,49.834-30.667S249,113,261,100
            s9.334-12.333,15.334-22.333c0,0-21.333-29.333-44-38c0,0-162.001-5.334-163.334-2.667"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M169.667,50.333c0,0-71.334-2.667-74.667,8.667s42,14,42,14
            s55.333,4.667,60,6.667s32.668,7.254,43.334,31.627L255,93.667C255,93.667,217,59,169.667,50.333z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M75.667,123c0,0,42,8,78,8.667s32.667,10.667,32.667,10.667
            S185.333,155,146.5,153.667S75.667,123,75.667,123z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M45,93c0,0-12.667-24,34-48h-8.667c0,0-35.455,24.559-36,35.677L45,93
            z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M174.912,161c0,0-24.745,12.999-24.745,12.333
            s-15.25-4.249-20.583-10.416"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M130,162.667c0,0,1.75-3.083,13.667-1.25c0,0,30,0.836,30.75-0.582"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M177.75,43L224,45.5c0,0,7.5,12.125-13,8.625S177.75,43,177.75,43z"/>
        <path fill="none" data-duration="60" stroke="#ffffff" stroke-width="1" d="M237.25,52c0,0,2.75,20.375,21.875,35.625l5.75-6.948
            C264.875,80.677,249.273,55.266,237.25,52z"/>
    </svg>
    <script>
    window.onload=function(){
        var toPlay= new Vivus('super', {
            type: 'delayed',
            duration: 50, 
            start: 'autostart', 
            forceRender: false, 
            dashGap: 20}
        );
        var oSuper=document.getElementById('super');
        oSuper.addEventListener('click',function(){
            toPlay.reset().play();
        });
    };
    </script>
    </body>
    </html>
    ```
</details>