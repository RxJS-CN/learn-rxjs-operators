# switchMap

#### 签名: ` switchMap(project: function: Observable, resultSelector: function(outerValue, innerValue, outerIndex, innerIndex): any): Observable`

## 映射成 observable，完成前一个内部 observable，发出值。

---

:bulb: 如果你想要维护多个内部 subscription 的话， 请尝试 [`mergeMap`](mergemap.md)！

:bulb: 此操作符通常被认为是 [`mergeMap`](mergemap.md) 的安全版本！

:bulb: 此操作符可以取消正在进行中的网络请求！

---

### 为什么使用 `switchMap`？

`switchMap` 和其他打平操作符的主要区别是它具有取消效果。在每次发出时，会取消前一个内部 observable (你所提供函数的结果) 的订阅，然后订阅一个新的 observable 。你可以通过短语**切换成一个新的 observable**来记忆它。

它能在像 [typeaheads](https://angular-2-training-book.rangle.io/handout/http/search_with_switchmap.html) 这样的场景下完美使用，当有新的输入时便不再关心之前请求的响应结果。在内部 observable 长期存活可能会导致内存泄露的情况下，这也是一种安全的选择，例如，如果你使用 [mergeMap](mergemap.md) 和 interval，并忘记正确处理内部订阅。记住，`switchMap` 同一时间只维护一个内部订阅，在[示例 1](#%E7%A4%BA%E4%BE%8B-1-%E6%AF%8F5%E7%A7%92%E9%87%8D%E6%96%B0%E5%90%AF%E5%8A%A8-interval)中可以清楚出看到这一点。

不过要小心，在每个请求都需要完成的情况下，考虑写数据库，你可能要避免使用 `switchMap` 。如果源 observable 发出速度足够快的话，`switchMap` 可以取消请求。在这些场景中，[mergeMap](mergemap.md) 是正确的选择。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每5秒重新启动 interval

(
[StackBlitz](https://stackblitz.com/edit/typescript-eb62ap?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/birepuveya/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6pz981gd/) )

```js
// RxJS v6+
import { timer, interval } from 'rxjs';
import { switchMap } from 'rxjs/operators';

// 立即发出值， 然后每5秒发出值
const source = timer(0, 5000);
// 当 source 发出值时切换到新的内部 observable，发出新的内部 observable 所发出的值
const example = source.pipe(switchMap(() => interval(500)));
// 输出: 0,1,2,3,4,5,6,7,8,9...0,1,2,3,4,5,6,7,8
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 每次点击时重置

(
[StackBlitz](https://stackblitz.com/edit/typescript-s4pvix?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/zoruboxogo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/y11v8aqz/) )

```js
// RxJS v6+
import { interval, fromEvent } from 'rxjs';
import { switchMap, mapTo } from 'rxjs/operators';

// 发出每次点击
const source = fromEvent(document, 'click');
// 如果3秒内发生了另一次点击，则消息不会被发出
const example = source.pipe(
  switchMap(val => interval(3000).pipe(mapTo('Hello, I made it!')))
);
// (点击)...3s...'Hello I made it!'...(点击)...2s(点击)...
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 使用 `resultSelector` 函数

(
[StackBlitz](https://stackblitz.com/edit/typescript-bmibzi?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/qobapubeze/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/nqfu534y/) )

```js
// RxJS v6+
import { timer, interval } from 'rxjs';
import { switchMap } from 'rxjs/operators';

// 立即发出值， 然后每5秒发出值
const source = timer(0, 5000);
// 当 source 发出值时切换到新的内部 observable，调用投射函数并发出值
const example = source.pipe(
  switchMap(
    _ => interval(2000),
    (outerValue, innerValue, outerIndex, innerIndex) => ({
      outerValue,
      innerValue,
      outerIndex,
      innerIndex
    })
  )
);
/*
	输出:
	{outerValue: 0, innerValue: 0, outerIndex: 0, innerIndex: 0}
	{outerValue: 0, innerValue: 1, outerIndex: 0, innerIndex: 1}
	{outerValue: 1, innerValue: 0, outerIndex: 1, innerIndex: 0}
	{outerValue: 1, innerValue: 1, outerIndex: 1, innerIndex: 1}
*/
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 4: 使用 switchMap 的倒计时定时器

( [StackBlitz](https://stackblitz.com/edit/typescript-ivdebg?file=index.ts) )

```js
// RxJS v6+
import { interval, fromEvent, merge, empty } from 'rxjs';
import { switchMap, scan, takeWhile, startWith, mapTo } from 'rxjs/operators';

const countdownSeconds = 10;
const setHTML = id => val => (document.getElementById(id).innerHTML = val);
const pauseButton = document.getElementById('pause');
const resumeButton = document.getElementById('resume');
const interval$ = interval(1000).pipe(mapTo(-1));

const pause$ = fromEvent(pauseButton, 'click').pipe(mapTo(false));
const resume$ = fromEvent(resumeButton, 'click').pipe(mapTo(true));

const timer$ = merge(pause$, resume$)
  .pipe(
    startWith(true),
    switchMap(val => (val ? interval$ : empty())),
    scan((acc, curr) => (curr ? curr + acc : acc), countdownSeconds),
    takeWhile(v => v >= 0)
  )
  .subscribe(setHTML('remaining'));
```

###### HTML

```html
<h4>
Time remaining: <span id="remaining"></span>
</h4>
<button id="pause">
Pause Timer
</button>
<button id="resume">
Resume Timer
</button>
```

### 相关食谱

- [智能计数器](../../recipes/smartcounter.md)
- [进度条](../../recipes/progressbar.md)
- [HTTP 轮询](../../recipes/http-polling.md)

### 其他资源

- [switchMap](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-switchMap) :newspaper: - 官方文档
- [避免 switchMap 的相关 Bugs](https://blog.angularindepth.com/switchmap-bugs-b6de69155524) - Nicholas Jamieson
- [使用 switchMap 开启流](https://egghead.io/lessons/rxjs-starting-a-stream-with-switchmap?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
- [使用 RxJS 的 switchMap 操作符来映射并打平高阶 observables](https://egghead.io/lessons/rxjs-use-rxjs-switchmap-to-map-and-flatten-higher-order-observables?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz
- [在 RxJS 中，使用 switchMap 作为打平 observables 的安全默认操作符](https://egghead.io/lessons/rxjs-use-switchmap-as-a-safe-default-to-flatten-observables-in-rxjs?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/switchMap.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/switchMap.ts)
