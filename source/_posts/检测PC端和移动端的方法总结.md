---
title: 检测PC端和移动端的方法总结
date: 2016-06-02 12:24:00
tags:
- 适配
---

正在苦逼的实习中，昨天公司让做一个页面，涉及到检测终端的问题，如果是手机设备，就跳转到指定的网页上，以前写响应式布局只要用`@media screen`来实现布局的差异化适应，但是现在不仅仅是布局，还要针对移动端做一些别的动作，所以看了点资料，做个总结
<!-- more -->

# 还是用@media screen
思路：css使用媒体查询，当屏幕小于760px时，使某个元素的样式发生改变，然后通过js检测到这个改变，就可以知道现在切换到移动端了
css代码：
```css
/* 检测小屏幕- */
@media only screen and (max-width: 760px) {
　　#some-element { display: none; }
}
```
js代码：
```js
$( document ).ready(function() {     
　　var isMobile = false;//默认是pc端
　　if( $('#some-element').css('display')=='none') {
    is_mobile = true;      
　　}
　　if (isMobile == true) {
    //对移动端进行处理
　　}
});
```

# 通过navigator.userAgent字符串检测
思路：`Navigator`对象包含有关浏览器的信息，通过检测`userAgent`字符串，然后使用正则表达式进行匹配，我们自然就能知道用户是否在使用移动端的浏览器啦
先上个简化版的，意思意思下：
```js
var isMobile = false;
// 检测userAgent
if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
　　isMobile = true;
}
if(isMobile){
　　//移动端的处理逻辑
}
```
其实还可以用jQuery,但是jQuery从1.9版开始，移除了`$.browser`和`$.browser.version`：
```js
$.browser.device = (/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase();
```
通过上面那段代码基本就能检测到我们能常用的移动终端了，但是后来我在stackoverflow发现一哥们检测得更加全面牛逼：
```js
var isMobile = false;//默认PC端
// 检测userAgent
if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent)
    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4)))
{
　　isMobile = true;
}
if(isMobile){<br>　　//移动端的处理逻辑<br>}
```

# 通过Window.matchMedia()检测
思路：`Window.matchMedia()`用来检查mediaquery语句，。它返回一个`MediaQueryList`对象。该对象有两个属性
media：查询语句的内容。
matches：如果查询结果为真，值为true，否则为false
```js
var isMobile = false;//默认PC端
var result = window.matchMedia("<code>only screen and</code> (max-width: 760px)");
if (result.matches){
　　isMobile = true;
}
```
如果在PC端上使用`Window.matchMedia()`的话IE10以下是不支持的，但是我们只是用来检测终端哈，IE不支持就算了，移动端上安卓3.0以上都没有问题，so~~

# 检测移动端的TouchEvent事件
思路：使用`document.createEvent()`创建TouchEvent事件，如果成功那就是移动端了，返回true，pc端是没有TouchEvent事件的，所以会出错，返回false
```js
var isMobile = false;//默认PC端
function mobile() {
    try{
        document.createEvent("TouchEvent");
        return true;
    }
    catch(e){
        return false;
    }
}
isMobile=mobile();
```

# 使用Device.js库
这个库就没啥好讲的了，自己跟着套代码就ＯＫ
github地址 https://github.com/matthewhudson/device.js
不想看英文的孩子，扔个中文教程 https://segmentfault.com/a/1190000000373735