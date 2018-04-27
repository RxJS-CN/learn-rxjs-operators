# delay

#### 函数签名: `delay(delay: number | Date, scheduler: Scheduler): Observable`

## 根据给定时间延迟发出值。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 延迟时间持续增加

(
[StackBlitz](https://stackblitz.com/edit/typescript-twjn8r?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/zebatixije/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/1kxtzcu6/) )

```js
// RxJS v6+
import { of, merge } from 'rxjs';
import { mapTo, delay } from 'rxjs/operators';

// 发出一项
const example = of(null);
// 每延迟一次输出便增加1秒延迟时间
const message = merge(
  example.pipe(mapTo('Hello')),
  example.pipe(
    mapTo('World!'),
    delay(1000)
  ),
  example.pipe(
    mapTo('Goodbye'),
    delay(2000)
  ),
  example.pipe(
    mapTo('World!'),
    delay(3000)
  )
);
// 输出: 'Hello'...'World!'...'Goodbye'...'World!'
const subscribe = message.subscribe(val => console.log(val));
```

### 相关食谱

- [进度条](../../recipes/progressbar.md)

### 其他资源

- [delay](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-delay) :newspaper: - 官方文档
- [转换操作符: delay 和 delayWhen](https://egghead.io/lessons/rxjs-transformation-operators-delay-and-delaywhen?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/delay.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/delay.ts)
