# windowCount

#### 函数签名: `windowCount(windowSize: number, startWindowEvery: number): Observable`

## 源 observable 中的值的 observable，每次发出N个值(N由参数决定)。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每发出x个项就开启一个新窗口

( [StackBlitz](https://stackblitz.com/edit/typescript-uhg3vb?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/nezuvacexe/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/xjgbnqp5/) )

```js
import { interval } from 'rxjs/observable/interval';
import { windowCount, mergeAll, tap } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
const example = source.pipe(
  // 每发出4个值就开启新窗口
  windowCount(4),
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
      "NEW WINDOW!"
      4
      5
      6
      7
    */
  )
  .subscribe(val => console.log(val));
```

### 其他资源

* [windowCount](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-windowCount) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowCount.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/windowCount.ts)
