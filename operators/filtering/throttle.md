# throttle

#### 签名: `throttle(durationSelector: function(value): Observable | Promise): Observable`

## 仅当由提供的函数所确定的持续时间已经过去时才发出值。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 节流2秒，时间由第2个 observable 决定

( [jsBin](http://jsbin.com/wohefujipo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/h8na4m0p/) )

```js
import { interval } from 'rxjs/observable/interval';
import { throttle } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 节流2秒后才发出最新值
const example = source.pipe(throttle(val => interval(2000)));
// 输出: 0...3...6...9
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 使用 promise 进行节流

( [jsBin](http://jsbin.com/seyaguwunu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/w5Lbzz9f/) )

```js
import { interval } from 'rxjs/observable/interval';
import { throttle, map } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 基于 source 自增地增加解析的时间
const promise = val =>
  new Promise(resolve =>
    setTimeout(() => resolve(`Resolved: ${val}`), val * 100)
  );
// 当 promise 解析时发出 source 的项
const example = source
  .pipe(
    throttle(promise),
    map(val => `Throttled off Promise: ${val}`);
  );


const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [throttle](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-throttle) :newspaper: - 官方文档
* [过滤操作符: throttle 和 throttleTime](https://egghead.io/lessons/rxjs-filtering-operators-throttle-and-throttletime?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/throttle.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/throttle.ts)
