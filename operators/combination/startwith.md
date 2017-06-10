# startWith

#### 签名: `startWith(an: Values): Observable`

## 发出给定的第一个值

---

:bulb: [BehaviorSubject](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/api/subjects/behaviorsubject.md) 也可以从初始值开始！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/startwith-spec.ts) )

##### 示例 1: 对数字序列使用 startWith

( [StackBlitz](https://stackblitz.com/edit/typescript-e4fhpw?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/lezuravizu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/e8dn3ggp/) )

```js
import { startWith } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

// 发出 (1,2,3)
const source = of(1, 2, 3);
// 从0开始
const example = source.pipe(startWith(0));
// 输出: 0,1,2,3
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: startWith 用作 scan 的初始值

( [StackBlitz](https://stackblitz.com/edit/typescript-a6k8a8?file=index.ts&devtoolsheight=50) | |
[jsBin](http://jsbin.com/gemevuzoha/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/54r3g83e/) )

```js
import { startWith, scan } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

// 发出 ('World!', 'Goodbye', 'World!')
const source = of('World!', 'Goodbye', 'World!');
// 以 'Hello' 开头，后面接当前字符串
const example = source.pipe(
  startWith('Hello'),
  scan((acc, curr) => `${acc} ${curr}`)
);
/*
  输出:
  "Hello"
  "Hello World!"
  "Hello World! Goodbye"
  "Hello World! Goodbye World!"
*/
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 使用多个值进行 startWith 

( [StackBlitz](https://stackblitz.com/edit/typescript-qyxyhu?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/cumupemuxa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ckcyj3ms/) )

```js
import { startWith } from 'rxjs/operators';
import { interval } from 'rxjs/observable/interval';

// 每1秒发出值
const source = interval(1000);
// 以 -3, -2, -1 开始
const example = source.pipe(startWith(-3, -2, -1));
// 输出: -3, -2, -1, 0, 1, 2....
const subscribe = example.subscribe(val => console.log(val));
```

### 相关食谱

* [智能计数器](../../recipes/smartcounter.md)

### 其他资源

* [startWith](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-startWith) :newspaper: - 官方文档
* [使用 startWith 显示初始值](https://egghead.io/lessons/rxjs-displaying-initial-data-with-startwith?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [当加载时使用 startWith 清除数据](https://egghead.io/lessons/rxjs-reactive-programming-clear-data-while-loading-with-rxjs-startwith?course=introduction-to-reactive-programming) :video_camera: :dollar: - André Staltz
* [组合操作符: concat, startWith](https://egghead.io/lessons/rxjs-combination-operators-concat-startwith?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/startWith.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/startWith.ts)
