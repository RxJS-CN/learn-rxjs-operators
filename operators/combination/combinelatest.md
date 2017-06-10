# combineLatest

#### 签名: `combineLatest(observables: ...Observable, project: function): Observable`

## 当任意 observable 发出值时，发出每个 observable 的最新值。

---

:bulb:  此操作符可以既有静态方法，又有实例方法！

:bulb:  当源 observable 完成时，可以使用 [combineAll](combineall.md) 来应用 combineLatest 以发出 observables ！

---

### Why use `combineLatest`?

This operator is best used when you have multiple, long-lived observables that
rely on eachother for some calculation or determination. Basic examples of this
can be seen in [example three](#example-3-combining-events-from-2-buttons),
where events from multiple buttons are being combined to produce a count of each
and an overall total, or a
[calculation of BMI](http://reactivex.io/rxjs/class/es6/Observable.js~Observable.html#instance-method-combineLatest)
from the RxJS documentation.

Be aware that **`combineLatest` will not emit an initial value until each
observable emits at least one value**. This is the same behavior as
[`withLatestFrom`](withlatestfrom.md) and can be a _gotcha_ as there will be no
output and no error but one (or more) of your inner observables is likely not
functioning as intended, or a subscription is late.

Lastly, if you are working with observables that only emit one value, or you
only require the last value of each before completion, [`forkJoin`](forkjoin.md)
is likely a better option.

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/combinelatest-spec.ts) )

##### 示例 1: 组合3个定时发送的 observables

(
[StackBlitz](https://stackblitz.com/edit/typescript-vadvm2?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/tinumesuda/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/mygy9j86/69/) )

```js
// RxJS v6+
import { timer, combineLatest } from 'rxjs';

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

(
[StackBlitz](https://stackblitz.com/edit/typescript-prtbvd?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/codotapula/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/uehasmb6/) )

```js
// RxJS v6+
import { timer, combineLatest } from 'rxjs';

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

(
[StackBlitz](https://stackblitz.com/edit/typescript-ihcxud?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/buridepaxi/edit?html,js,output) |
[jsFiddle](https://jsfiddle.net/btroncone/9rsf6t9v/14/) )

```js
// RxJS v6+
import { fromEvent, combineLatest } from 'rxjs';
import { mapTo, startWith, scan, tap, map } from 'rxjs/operators';

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

* [combineLatest](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-combineLatest) :newspaper: - 官方文档
* [使用 combineLatest 组合流](https://egghead.io/lessons/rxjs-combining-streams-with-combinelatest?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [组合操作符: combineLatest](https://egghead.io/lessons/rxjs-combination-operator-combinelatest?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineLatest.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineLatest.ts)
