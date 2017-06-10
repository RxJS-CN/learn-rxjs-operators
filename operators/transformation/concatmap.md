# concatMap

#### 签名: `concatMap(project: function, resultSelector: function): Observable`

## 将值映射成内部 observable，并按顺序订阅和发出。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 演示 `concatMap` 和 [`mergeMap`](./mergemap.md) 之间的区别

( [StackBlitz](https://stackblitz.com/edit/typescript-pkyxa1?file=index.ts&devtoolsheight=100) )

:bulb: Note the difference between `concatMap` and [`mergeMap`](./mergemap.md).
Because `concatMap` does not subscribe to the next observable until the previous
completes, the value from the source delayed by 2000ms will be emitted first.
Contrast this with [`mergeMap`](./mergemap.md) which subscribes immediately to
inner observables, the observable with the lesser delay (1000ms) will emit,
followed by the observable which takes 2000ms to complete.

```js
// RxJS v6+
import { of } from 'rxjs';
import { concatMap, delay, mergeMap } from 'rxjs/operators';

//emit delay value
const source = of(2000, 1000);
// map value from source into inner observable, when complete emit result and move to next
const example = source.pipe(
  concatMap(val => of(`Delayed by: ${val}ms`).pipe(delay(val)))
);
//output: With concatMap: Delayed by: 2000ms, With concatMap: Delayed by: 1000ms
const subscribe = example.subscribe(val =>
  console.log(`With concatMap: ${val}`)
);

// showing the difference between concatMap and mergeMap
const mergeMapExample = source
  .pipe(
    // just so we can log this after the first example has run
    delay(5000),
    mergeMap(val => of(`Delayed by: ${val}ms`).pipe(delay(val)))
  )
  .subscribe(val => console.log(`With mergeMap: ${val}`));
```

##### 示例 2: 映射成 promise

( [StackBlitz](https://stackblitz.com/edit/typescript-rv9byk?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/celixodeba/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/Lym33L97//) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { concatMap } from 'rxjs/operators';

// 发出 'Hello' 和 'Goodbye'
const source = of('Hello', 'Goodbye');
// 使用 promise 的示例
const examplePromise = val => new Promise(resolve => resolve(`${val} World!`));
// 将 source 的值映射成内部 observable，当一个完成发出结果后再继续下一个
const example = source.pipe(concatMap(val => examplePromise(val)));
// 输出: 'Example w/ Promise: 'Hello World', Example w/ Promise: 'Goodbye World'
const subscribe = example.subscribe(val =>
  console.log('Example w/ Promise:', val)
);
```

##### 示例 3: 应用投射函数

( [StackBlitz](https://stackblitz.com/edit/typescript-2elzt7?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/vihacewozo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/5sr5zzgy/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { concatMap } from 'rxjs/operators';

// 发出 'Hello' 和 'Goodbye'
const source = of('Hello', 'Goodbye');
// 使用 promise 的示例
const examplePromise = val => new Promise(resolve => resolve(`${val} World!`));
// 返回结果前，第一个参数的结果将传递给第二个参数选择器函数
const example = source.pipe(
  concatMap(val => examplePromise(val), result => `${result} w/ selector!`)
);
// 输出: 'Example w/ Selector: 'Hello w/ Selector', Example w/ Selector: 'Goodbye w/ Selector'
const subscribe = example.subscribe(val =>
  console.log('Example w/ Selector:', val)
);
```

### 其他资源

* [concatMap](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-concatMap) :newspaper: - 官方文档
* [使用 RxJS 的 concatMap 操作符来映射并连接高阶 observables](https://egghead.io/lessons/rxjs-use-rxjs-concatmap-to-map-and-concat-high-order-observables?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatMap.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concatMap.ts)
