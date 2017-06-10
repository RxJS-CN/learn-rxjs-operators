# windowTime

#### 签名: `windowTime(windowTimeSpan: number, windowCreationInterval: number, scheduler: Scheduler): Observable`

## 在每个提供的时间跨度内，收集源 obsercvable 中的值的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每个指定持续时间都会开启新窗口

(
[StackBlitz](https://stackblitz.com/edit/typescript-hkrjsc?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/mifayacoqo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/g04b3qeb/) )

```js
// RxJS v6+
import { timer } from 'rxjs';
import { windowTime, tap, mergeAll } from 'rxjs/operators';

// 立即发出值，然后每秒发出值
const source = timer(0, 1000);
const example = source.pipe(
  // 每3秒开启一个新窗口
  windowTime(3000),
  tap(_ => console.log('NEW WINDOW!'))
);

const subscribeTwo = example
  .pipe(
    // 窗口发出嵌套的 observable
    mergeAll()
    /*
      输出:
      "NEW WINDOW!"
      0
      1
      2
      "NEW WINDOW!"
      3
      4
      5
    */
  )
  .subscribe(val => console.log(val));
```

### 其他资源

- [windowTime](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-windowTime) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowTime.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowTime.ts)
