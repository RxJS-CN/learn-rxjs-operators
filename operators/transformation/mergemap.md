# mergeMap

#### 签名: `mergeMap(project: function: Observable, resultSelector: function: any, concurrent: number): Observable`

## 映射成 observable 并发出值。

---

:bulb:  flatMap 是 mergeMap 的别名！

:bulb: 如果同一时间应该只有一个内部 subscription 是有效的，请尝试 [`switchMap`](switchmap.md)！

:bulb: 如果内部 observables 发送和订阅的顺序很重要，请尝试 [`concatMap`](concatmap.md)！

---

### Why use `mergeMap`?

This operator is best used when you wish to flatten an inner observable but want
to manually control the number of inner subscriptions.

For instance, when using [`switchMap`](switchmap.md) each inner subscription is
completed when the source emits, allowing only one active inner subscription. In
contrast, `mergeMap` allows for multiple inner subscriptions to be active at a
time. Because of this, one of the most common use-case for `mergeMap` is
requests that should not be canceled, think writes rather than reads. Note that
if order must be maintained [`concatMap`](concatmap.md) is a better option.

Be aware that because `mergeMap` maintains multiple active inner subscriptions
at once it's possible to create a memory leak through long-lived inner
subscriptions. A basic example would be if you were mapping to an observable
with an inner timer, or a stream of dom events. In these cases, if you still
wish to utilize `mergeMap` you may want to take advantage of another operator to
manage the completion of the inner subscription, think
[`take`](../filtering/take.md) or [`takeUntil`](../filtering/takeuntil.md). You
can also limit the number of active inner subscriptions at a time with the
`concurrent` parameter, seen in
[example 4](#example-4-mergemap-with-concurrent-value).

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 observable 进行 mergeMap

(
[StackBlitz](https://stackblitz.com/edit/typescript-f8ghcx?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/mojurubana/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/41awjgda/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

// 发出 'Hello'
const source = of('Hello');
// 映射成 observable 并将其打平
const example = source.pipe(mergeMap(val => of(`${val} World!`)));
// 输出: 'Hello World!'
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 使用 promise 进行 mergeMap

(
[StackBlitz](https://stackblitz.com/edit/typescript-pnnsrq?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/vuhecorana/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/o9kxpvsv/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

// 发出 'Hello'
const source = of('Hello');
// mergeMap 还会发出 promise 的结果
const myPromise = val =>
  new Promise(resolve => resolve(`${val} World From Promise!`));
// 映射成 promise 并发出结果
const example = source.pipe(mergeMap(val => myPromise(val)));
// 输出: 'Hello World From Promise'
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 使用 `resultSelector` 函数进行 mergeMap

(
[StackBlitz](https://stackblitz.com/edit/typescript-9p6ws7?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/wajokocage/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/zu9a6vr4/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

/*
  你还可以提供第二个参数，它接收源 observable 的值并发出内部 observable 或 promise 的值
*/
// 发出 'Hello'
const source = of('Hello');
// mergeMap 还会发出 promise 的结果
const myPromise = val =>
  new Promise(resolve => resolve(`${val} World From Promise!`));
const example = source.pipe(
  mergeMap(
    val => myPromise(val),
    (valueFromSource, valueFromPromise) => {
      return `Source: ${valueFromSource}, Promise: ${valueFromPromise}`;
    }
  )
);
// 输出: "Source: Hello, Promise: Hello World From Promise!"
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 4: 使用 concurrent 值进行 mergeMap

(
[StackBlitz](https://stackblitz.com/edit/typescript-r3gcr4?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/qaqucuwise/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/2rmLxpyz/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { mergeMap, take } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);

const example = source.pipe(
  mergeMap(
    //project
    val => interval(5000).pipe(take(2)),
    //resultSelector
    (oVal, iVal, oIndex, iIndex) => [oIndex, oVal, iIndex, iVal],
    //concurrent
    2
  )
);
/*
		输出:
		[0, 0, 0, 0] <--第一个内部 observable
		[1, 1, 0, 0] <--第二个内部 observable
		[0, 0, 1, 1] <--第一个内部 observable
		[1, 1, 1, 1] <--第二个内部 observable
		[2, 2, 0, 0] <--第三个内部 observable
		[3, 3, 0, 0] <--第四个内部 observable
*/
const subscribe = example.subscribe(val => console.log(val));
```

### Related Recipes

- [HTTP Polling](../../recipes/http-polling.md)

### 其他资源

- [mergeMap](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-mergeMap) :newspaper: - 官方文档
- [map vs flatMap](https://egghead.io/lessons/rxjs-rxjs-map-vs-flatmap) :video_camera: :dollar: - Ben Lesh
- [RxJS 中的异步请求和响应](https://egghead.io/lessons/rxjs-04-reactive-programming-async-requests-and-responses-in-rxjs) :video_camera: :dollar: - André Staltz
- [使用 RxJS 的 mergeMap 操作符来映射并合并高阶 observables](https://egghead.io/lessons/rxjs-use-rxjs-mergemap-to-map-and-merge-high-order-observables?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz
- [使用 RxJS 的 mergeMap 操作符来进行细粒度的自定义行为](https://egghead.io/lessons/rxjs-use-rxjs-mergemap-for-fine-grain-custom-behavior?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mergeMap.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mergeMap.ts)
