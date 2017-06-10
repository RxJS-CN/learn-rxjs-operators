# empty

#### 签名: `empty(scheduler: Scheduler): Observable`

## 立即完成的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: empty 会立即完成

(
[StackBlitz](https://stackblitz.com/edit/typescript-ospewh?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/rodubucaqa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/bz71mzuy/) )

```js
import { empty } from 'rxjs/observable/empty';

// 创建的 observable 会立即完成
const example = empty();
// 输出: 'Complete!'
const subscribe = example.subscribe({
  next: () => console.log('Next'),
  complete: () => console.log('Complete!')
});
```

##### Example 2: `empty` with timer

(
[StackBlitz](https://stackblitz.com/edit/typescript-ur5svp?file=index.ts&devtoolsheight=50)
)

```js
import { interval } from 'rxjs/observable/interval';
import { fromEvent } from 'rxjs/observable/fromEvent';
import { merge } from 'rxjs/observable/merge';
import { empty } from 'rxjs/observable/empty';
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
    // if timer is paused return empty observable
    switchMap(val => (val ? interval$ : empty())),
    scan((acc, curr) => (curr ? curr + acc : acc), countdownSeconds),
    takeWhile(v => v >= 0)
  )
  .subscribe(setHTML('remaining'));
```

### 其他资源

* [empty](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-empty) :newspaper: - 官方文档
* [Creation operators: empty, never, and throw](https://egghead.io/lessons/rxjs-creation-operators-empty-never-throw?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/EmptyObservable.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/EmptyObservable.ts)
