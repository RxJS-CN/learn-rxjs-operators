# windowWhen

#### 签名: `windowWhen(closingSelector: function(): Observable): Observable`

## 在提供的时间帧处关闭窗口，并发出从源 observable 中收集的值的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 根据定时器开启和关闭窗口

(
[StackBlitz](https://stackblitz.com/edit/typescript-52tu8k?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/tuhaposemo/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/gnx9fb3h/) )

```js
// RxJS v6+
import { interval, timer } from 'rxjs';
import { windowWhen, tap, mergeAll } from 'rxjs/operators';

// 立即发出值，然后每秒发出值
const source = timer(0, 1000);
const example = source.pipe(
  // 每5秒关闭窗口并发出从源 observable 中收集的值的 observable
  windowWhen(() => interval(5000)),
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
      3
      4
      "NEW WINDOW!"
      5
      6
      7
      8
      9
    */
  )
  .subscribe(val => console.log(val));
```

### 其他资源

- [windowWhen](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-windowWhen) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowWhen.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowWhen.ts)
