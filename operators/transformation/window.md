# window

#### 签名: `window(windowBoundaries: Observable): Observable`

## 时间窗口值的 observable 。

### 示例

##### 示例 1: 打开由内部 observable 指定的窗口

(
[StackBlitz](https://stackblitz.com/edit/typescript-avymzq?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/jituvajeri/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/rmgghg6d/) )

```js
// RxJS v6+
import { timer, interval } from 'rxjs';
import { window, scan, mergeAll } from 'rxjs/operators';

// 立即发出值，然后每秒发出值
const source = timer(0, 1000);
const example = source.pipe(window(interval(3000)));
const count = example.pipe(scan((acc, curr) => acc + 1, 0));
/*
  "Window 1:"
  0
  1
  2
  "Window 2:"
  3
  4
  5
  ...
*/
const subscribe = count.subscribe(val => console.log(`Window ${val}:`));
const subscribeTwo = example
  .pipe(mergeAll())
  .subscribe(val => console.log(val));
```

### 其他资源

- [window](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-window) :newspaper: - 官方文档
- [使用 window 分割 RxJS observable](https://egghead.io/lessons/rxjs-split-an-rxjs-observable-with-window?course=use-higher-order-observables-in-rxjs-effectively) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/window.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/window.ts)
