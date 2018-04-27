# combineLatest

#### 函数签名: `combineLatest(observables: ...Observable, project: function): Observable`

## 当任意 observable 发出值时，发出每个 observable 的最新值。

---

:bulb:  此操作符可以既有静态方法，又有实例方法！

:bulb:  当源 observable 完成时，可以使用 [combineAll](combineall.md) 来应用 combineLatest 以发出 observables ！

---

### 为什么使用 `combineLatest`？

当有多个长期活动的 observables 且它们依靠彼此来进行一些计算或决定时，此操作符是最适合的。[示例 3](#%E7%A4%BA%E4%BE%8B%203%3A%20%E7%BB%84%E5%90%882%E4%B8%AA%E6%8C%89%E9%92%AE%E7%9A%84%E4%BA%8B%E4%BB%B6)可作为基础示例演示，来自多个按钮的事件被组合在一起，以生成每个按钮的计数和总体总数，RxJS 文档中的 combineLatest 操作符的示例 [BMI 计算](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-combineLatest) 也可作为示例。

注意，**`combineLatest` 直到每个 observable 都至少发出一个值后才会发出初始值。**这和 [`withLatestFrom`](withlatestfrom.md) 的行为是一致的，这常常会成为陷阱，既没有输出，也不报错，但是一个(或多个)内部 observables 可能无法正常工作，或者订阅延迟。

最后，如果你只需要 observables 发出一个值，或只需要它们完成前的最新值时，[`forkJoin`](forkjoin.md) 会是更好的选择。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/combinelatest-spec.ts) )

##### 示例 1: 组合3个定时发送的 observables

( [StackBlitz](https://stackblitz.com/edit/typescript-wmfmtv?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/tinumesuda/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/mygy9j86/69/) )

```js
import { timer } from 'rxjs/observable/timer';
import { combineLatest } from 'rxjs/observable/combineLatest';

// timerOne 在1秒时发出第一个值，然后每4秒发送一次
const timerOne = timer(1000, 4000);
// timerTwo 在2秒时发出第一个值，然后每4秒发送一次
const timerTwo = timer(2000, 4000);
// timerThree 在3秒时发出第一个值，然后每4秒发送一次
const timerThree = timer(3000, 4000);

// 当一个 timer 发出值时，将每个 timer 的最新值作为一个数组发出
const combined = combineLatest(timerOne, timerTwo, timerThree);

const subscribe = combined.subscribe(latestValues => {
  // 从 timerValOne、timerValTwo 和 timerValThree 中获取最新发出的值
	const [timerValOne, timerValTwo, timerValThree] = latestValues;
  /*
  	示例:
    timerOne first tick: 'Timer One Latest: 1, Timer Two Latest:0, Timer Three Latest: 0
    timerTwo first tick: 'Timer One Latest: 1, Timer Two Latest:1, Timer Three Latest: 0
    timerThree first tick: 'Timer One Latest: 1, Timer Two Latest:1, Timer Three Latest: 1
  */
    console.log(
      `Timer One Latest: ${timerValOne},
     Timer Two Latest: ${timerValTwo},
     Timer Three Latest: ${timerValThree}`
    );
  }
);
```

##### 示例 2: 使用 projection 函数的 combineLatest

( [StackBlitz](https://stackblitz.com/edit/typescript-fcmjfl?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/codotapula/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/uehasmb6/) )

```js
import { timer } from 'rxjs/observable/timer';
import { combineLatest } from 'rxjs/observable/combineLatest';

// timerOne 在1秒时发出第一个值，然后每4秒发送一次
const timerOne = timer(1000, 4000);
// timerTwo 在2秒时发出第一个值，然后每4秒发送一次
const timerTwo = timer(2000, 4000);
// timerThree 在3秒时发出第一个值，然后每4秒发送一次
const timerThree = timer(3000, 4000);

// combineLatest 还接收一个可选的 projection 函数
const combinedProject = combineLatest(
  timerOne,
  timerTwo,
  timerThree,
  (one, two, three) => {
    return `Timer One (Proj) Latest: ${one}, 
              Timer Two (Proj) Latest: ${two}, 
              Timer Three (Proj) Latest: ${three}`;
  }
);
// 输出值
const subscribe = combinedProject.subscribe(latestValuesProject =>
  console.log(latestValuesProject)
);
```

##### 示例 3: 组合2个按钮的事件

( [StackBlitz](https://stackblitz.com/edit/typescript-sfbopd?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/buridepaxi/edit?html,js,output) |
[jsFiddle](https://jsfiddle.net/btroncone/9rsf6t9v/14/) )

```js
import { mapTo, startWith, scan, tap, map } from 'rxjs/operators';
import { fromEvent } from 'rxjs/observable/fromEvent';
import { combineLatest } from 'rxjs/observable/combineLatest';

// 用来设置 HTML 的辅助函数
const setHtml = id => val => (document.getElementById(id).innerHTML = val);

const addOneClick$ = id =>
  fromEvent(document.getElementById(id), 'click').pipe(
    // 将每次点击映射成1
    mapTo(1),
    startWith(0),
    // 追踪运行中的总数
    scan((acc, curr) => acc + curr),
    // 为适当的元素设置 HTML
    tap(setHtml(`${id}Total`))
  );

const combineTotal$ = combineLatest(addOneClick$('red'), addOneClick$('black'))
  .pipe(map(([val1, val2]) => val1 + val2))
  .subscribe(setHtml('total'));
```

###### HTML

```html
<div>
  <button id='red'>Red</button>
  <button id='black'>Black</button>
</div>
<div>Red: <span id="redTotal"></span> </div>
<div>Black: <span id="blackTotal"></span> </div>
<div>Total: <span id="total"></span> </div>
```

### 其他资源

* [combineLatest](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-combineLatest) :newspaper: - 官方文档
* [使用 combineLatest 组合流](https://egghead.io/lessons/rxjs-combining-streams-with-combinelatest?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [组合操作符: combineLatest](https://egghead.io/lessons/rxjs-combination-operator-combinelatest?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineLatest.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineLatest.ts)
