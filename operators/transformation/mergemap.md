# mergeMap

#### 函数签名: `mergeMap(project: function: Observable, resultSelector: function: any, concurrent: number): Observable`

## 映射成 observable 并发出值。

---

:bulb:  flatMap 是 mergeMap 的别名！

:bulb: 如果同一时间应该只有一个内部 subscription 是有效的，请尝试 [`switchMap`](switchmap.md)！

:bulb: 如果内部 observables 发送和订阅的顺序很重要，请尝试 [`concatMap`](concatmap.md)！

---

### 为什么使用 `mergeMap`？

当想要打平内部 observable 并手动控制内部订阅数量时，此操作符是最适合的。

例如，当使用 [`switchMap`](switchmap.md) 时，源 observable 发出值时，每个内部订阅都是完成的，只允许存在一个活动的内部订阅。与此相反，`mergeMap` 允许同一时间存在多个活动的内部订阅。正因为如此，`mergeMap` 最常见的用例便是不会被取消的请求，可以将其考虑成写，而不是读。注意如果需要考虑顺序的话，
[`concatMap`](concatmap.md) 会是更好的选择。

注意，因为 `mergeMap` 同时维护多个活动的内部订阅，由于这些长期活动的内部订阅，所以是有可能产生内存泄露的。举个例子，如果你将 observable 映射成内部的定时器或 DOM 事件流。在这些案例中，如果你仍然想用 `mergeMap` 的话，你应该利用另一个操作符来管理内部订阅的完成，比如 [`take`](../filtering/take.md) 或 [`takeUntil`](../filtering/takeuntil.md)。你还可以使用 `concurrent` 参数来限制活动的内部订阅的数量，参见 [示例 4](#%E7%A4%BA%E4%BE%8B%204%3A%20%E4%BD%BF%E7%94%A8%20concurrent%20%E5%80%BC%E8%BF%9B%E8%A1%8C%20mergeMap)。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 observable 进行 mergeMap

(
[StackBlitz](https://stackblitz.com/edit/typescript-4mlj3e?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/mojurubana/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/41awjgda/) )

```js
import { of } from 'rxjs/observable/of';
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
[StackBlitz](https://stackblitz.com/edit/typescript-cxgrtg?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/vuhecorana/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/o9kxpvsv/) )

```js
import { of } from 'rxjs/observable/of';
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
[StackBlitz](https://stackblitz.com/edit/typescript-rlfc72?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/wajokocage/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/zu9a6vr4/) )

```js
import { of } from 'rxjs/observable/of';
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
[StackBlitz](https://stackblitz.com/edit/typescript-arsrsh?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/qaqucuwise/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/2rmLxpyz/) )

```js
import { interval } from 'rxjs/observable/interval';
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

### 相关食谱

* [HTTP 论述](../../recipes/http-polling.md)

### 其他资源

* [mergeMap](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-mergeMap) :newspaper: - 官方文档
* [map vs flatMap](https://egghead.io/lessons/rxjs-rxjs-map-vs-flatmap) :video_camera: :dollar: - Ben Lesh
* [RxJS 中的异步请求和响应](https://egghead.io/lessons/rxjs-04-reactive-programming-async-requests-and-responses-in-rxjs) :video_camera: :dollar: - André Staltz
* [使用 RxJS 的 mergeMap 操作符来映射并合并高阶 observables](https://egghead.io/lessons/rxjs-use-rxjs-mergemap-to-map-and-merge-high-order-observables?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz
* [使用 RxJS 的 mergeMap 操作符来进行细粒度的自定义行为](https://egghead.io/lessons/rxjs-use-rxjs-mergemap-for-fine-grain-custom-behavior?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mergeMap.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mergeMap.ts)
