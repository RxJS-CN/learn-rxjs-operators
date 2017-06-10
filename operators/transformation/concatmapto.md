# concatMapTo

#### 签名: `concatMapTo(observable: Observable, resultSelector: function): Observable`

## 当前一个 observable 完成时订阅提供的 observable 并发出值。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 映射成基础的 observable (模拟请求)

( [StackBlitz](https://stackblitz.com/edit/typescript-fkkh6c?file=index.ts&devtoolsheight=50) )

```js
// RxJS v6+
import { of, interval } from 'rxjs';
import { concatMapTo, delay, take } from 'rxjs/operators';

//emit value every 2 seconds
const sampleInterval = interval(500).pipe(take(5));
const fakeRequest = of('Network request complete').pipe(delay(3000));
//wait for first to complete before next is subscribed
const example = sampleInterval.pipe(concatMapTo(fakeRequest));
//result
//output: Network request complete...3s...Network request complete'
const subscribe = example.subscribe(val => console.log(val));
```

##### Example 2: Using projection with `concatMap`

( [StackBlitz](https://stackblitz.com/edit/typescript-8kcfm1?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/fogefebisu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/s19wtscb/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { concatMapTo, take } from 'rxjs/operators';
// 每2秒发出值
const interval$ = interval(2000);
// 每1秒发出值，共5秒
const source = interval(1000).pipe(take(5));
/*
  ***小心***: 像这种情况下，源 observable 以比内部 observable 完成速度更快的速度发出，内存问题可能会出现。
  (interval 每1秒发出值，source 每5秒钟完成)
*/
// ource 会在5秒后完成， 发出 0,1,2,3,4
const example = interval$.pipe(
  concatMapTo(
    source,
    (firstInterval, secondInterval) => `${firstInterval} ${secondInterval}`
  )
);
/*
  输出: 0 0
          0 1
          0 2
          0 3
          0 4
          1 0
          1 1
          继续...

*/
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

- [concatMapTo](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-concatMapTo) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatMapTo.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatMapTo.ts)
