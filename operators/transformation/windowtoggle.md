# windowToggle

#### 函数签名: `windowToggle(openings: Observable, closingSelector: function(value): Observable): Observable`

## 以 openings 发出为起始，以 closingSelector 发出为结束，收集并发出源 observable 中的值的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 根据渐增的定时器开关窗口

(
[StackBlitz](https://stackblitz.com/edit/typescript-3nsyte?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/xasofupuka/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/3xmmuzy4/) )

```js
// RxJS v6+
import { timer, interval } from 'rxjs';
import { tap, windowToggle, mergeAll } from 'rxjs/operators';

// 立即发出值，然后每秒发出值
const source = timer(0, 1000);
// 每5秒开关窗口
const toggle = interval(5000);
const example = source.pipe(
  // 每5秒开启窗口
  windowToggle(toggle, val => interval(val * 1000)),
  tap(_ => console.log('NEW WINDOW!'))
);

const subscribeTwo = example
  .pipe(
    // 窗口发出嵌套的 observable
    mergeAll()
    /*
      输出:
      "NEW WINDOW!"
      5
      "NEW WINDOW!"
      10
      11
      "NEW WINDOW!"
      15
      16
      "NEW WINDOW!"
      20
      21
      22
    */
  )
  .subscribe(val => console.log(val));
```

### 其他资源

- [windowToggle](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-windowToggle) :newspaper: - 官方文档
- [使用 windowToggle 有条件地分割 RxJS observable](https://egghead.io/lessons/rxjs-split-an-rxjs-observable-conditionally-with-windowtoggle?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowToggle.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowToggle.ts)
