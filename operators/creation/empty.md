# empty

#### 函数签名: `empty(scheduler: Scheduler): Observable`

## 立即完成的 observable 。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: empty 会立即完成

(
[StackBlitz](https://stackblitz.com/edit/typescript-aqfpkq?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/rodubucaqa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/bz71mzuy/) )

```js
// RxJS v6+
import { empty } from 'rxjs';

// 输出: 'Complete!'
const subscribe = empty().subscribe({
  next: () => console.log('Next'),
  complete: () => console.log('Complete!')
});
```

##### 示例 2: 使用定时器的 `empty` 

(
[StackBlitz](https://stackblitz.com/edit/typescript-uujo8t?file=index.ts&devtoolsheight=50)
)

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
    // 如果定时器暂停，则返回空的 Observable
    switchMap(val => (val ? interval$ : empty())),
    scan((acc, curr) => (curr ? curr + acc : acc), countdownSeconds),
    takeWhile(v => v >= 0)
  )
  .subscribe(setHTML('remaining'));
```

### 其他资源

- [empty](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-empty) :newspaper: - 官方文档
- [Creation operators: empty, never, and throw](https://egghead.io/lessons/rxjs-creation-operators-empty-never-throw?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/EmptyObservable.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/EmptyObservable.ts)
