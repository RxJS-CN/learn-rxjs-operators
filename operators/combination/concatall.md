# concatAll

#### 函数签名: `concatAll(): Observable`

## 收集 observables，当前一个完成时订阅下一个。

---

:warning:  当源 observable 发出的速度要比内部 observables 完成更快时，请小心 [backpressure (背压)](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/backpressure.md) ！

:bulb:  在很多情况下，你可以使用只使用单个操作符 [concatMap](../transformation/concatmap.md) 来替代！
> 译者注：concatMap === map + concatAll

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/concatall-spec.ts) )

##### 示例 1: 使用 observable 来进行 concatAll

(
[StackBlitz](https://stackblitz.com/edit/typescript-zwtpc7?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/nakinenuva/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8dfuf2y6/) )

```js
// RxJS v6+
import { map, concatAll } from 'rxjs/operators';
import { of, interval } from 'rxjs';

// 每2秒发出值
const source = interval(2000);
const example = source.pipe(
  // 为了演示，增加10并作为 observable 返回
  map(val => of(val + 10)),
  // 合并内部 observables 的值
  concatAll()
);
// 输出: 'Example with Basic Observable 10', 'Example with Basic Observable 11'...
const subscribe = example.subscribe(val =>
  console.log('Example with Basic Observable:', val)
);
```

##### 示例 2: 使用 promise 来进行 concatAll

(
[StackBlitz](https://stackblitz.com/edit/typescript-3w4px3?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/bekegeyopu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/w7kp7qLs/) )

```js
// RxJS v6+
import { map, concatAll } from 'rxjs/operators';
import { interval } from 'rxjs';

// 创建并解析一个基础的 promise
const samplePromise = val => new Promise(resolve => resolve(val));
// 每2秒发出值
const source = interval(2000);

const example = source.pipe(
  map(val => samplePromise(val)),
  // 合并解析过的 promise 的值
  concatAll()
);
// 输出: 'Example with Promise 0', 'Example with Promise 1'...
const subscribe = example.subscribe(val =>
  console.log('Example with Promise:', val)
);
```

##### 示例 3: 当内部 observables 完成时进行延迟

(
[StackBlitz](https://stackblitz.com/edit/typescript-ft3rbf?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/pojolatile/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8230ucbg/) )

```js
// RxJS v6+
import { take, concatAll } from 'rxjs/operators';
import { interval, of } from 'rxjs/observable/interval';

const obs1 = interval(1000).pipe(take(5));
const obs2 = interval(500).pipe(take(2));
const obs3 = interval(2000).pipe(take(1));
// 发出3个 observables
const source = of(obs1, obs2, obs3);
// 按顺序订阅每个内部 obserable，前一个完成了再订阅下一个
const example = source.pipe(concatAll());
/*
  输出: 0,1,2,3,4,0,1,0
  怎么运行的...
  订阅每个内部 observable 并发出值，当一个完成了才订阅下一个
  obs1: 0,1,2,3,4 (complete)
  obs2: 0,1 (complete)
  obs3: 0 (complete)
*/

const subscribe = example.subscribe(val => console.log(val));
```

### 相关食谱

- [进度条](../../recipes/progressbar.md)

### 其他资源

- [concatAll](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-concatAll) :newspaper: - 官方文档
- [使用 RxJS 的 concatAll 来打平高阶 observable](https://egghead.io/lessons/rxjs-flatten-a-higher-order-observable-with-concatall-in-rxjs?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatAll.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatAll.ts)
