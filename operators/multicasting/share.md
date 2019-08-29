# share

#### 函数签名: `share(): Observable`

## 在多个订阅者间共享源 observable 。

---

:bulb:  share 就像是使用了 Subject 和 refCount 的 [multicast](multicast.md)！

---

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 多个订阅者共享源 observable 

(
[StackBlitz](https://stackblitz.com/edit/typescript-dlaa1p?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/jobiyomari/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/Lmesxxaq/) )

```js
// RxJS v6+
import { timer } from 'rxjs';
import { tap, mapTo, share } from 'rxjs/operators';

// 1秒后发出值
const source = timer(1000);
// 输出副作用，然后发出结果
const example = source.pipe(
  tap(() => console.log('***SIDE EFFECT***')),
  mapTo('***RESULT***')
);

/*
  ***不共享的话，副作用会执行两次***
  输出: 
  "***SIDE EFFECT***"
  "***RESULT***"
  "***SIDE EFFECT***"
  "***RESULT***"
*/
const subscribe = example.subscribe(val => console.log(val));
const subscribeTwo = example.subscribe(val => console.log(val));

// 在多个订阅者间共享 observable
const sharedExample = example.pipe(share());
/*
   ***共享的话，副作用只执行一次***
  输出:
  "***SIDE EFFECT***"
  "***RESULT***"
  "***RESULT***"
*/
const subscribeThree = sharedExample.subscribe(val => console.log(val));
const subscribeFour = sharedExample.subscribe(val => console.log(val));
```

### 相关食谱

- [进度条](../../recipes/progressbar.md)
- [游戏循环](../../recipes/gameloop.md)

### 其他资源

### 其他资源

- [share](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-share) :newspaper: - 官方文档
- [使用 share 共享流](https://egghead.io/lessons/rxjs-sharing-streams-with-share?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/share.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/share.ts)
