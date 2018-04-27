# bufferToggle

#### 函数签名: `bufferToggle(openings: Observable, closingSelector: Function): Observable`

## 开启开关以捕获源 observable 所发出的值，关闭开关以将缓冲的值作为数组发出。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 interval 来切换缓冲的开关

( [StackBlitz](https://stackblitz.com/edit/typescript-41puau?file=index.ts&devtoolsheight=50) | [jsBin](http://jsbin.com/relavezugo/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6ad3w3wf/) )

```js
import { interval } from 'rxjs/observable/interval';
import { bufferToggle } from 'rxjs/operators';

// 每1秒发出值
const sourceInterval = interval(1000);
// 5秒后开启第一个缓冲区，然后每5秒钟开启新的缓冲区
const startInterval = interval(5000);
// 3秒后发出值以关闭相应的缓冲区
const closingInterval = val => {
  console.log(`Value ${val} emitted, starting buffer! Closing in 3s!`);
  return interval(3000);
};
// 每5秒会开启一个新的缓冲区以收集发出的值，3秒后发出缓冲的值
const bufferToggleInterval = sourceInterval.pipe(
  bufferToggle(
    startInterval,
    closingInterval
  )
);
// 输出到控制台
// 输出: Emitted Buffer: [4,5,6]...[9,10,11]
const subscribe = bufferToggleInterval.subscribe(val =>
  console.log('Emitted Buffer:', val)
);
```

### 其他资源

* [bufferToggle](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-bufferToggle) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferToggle.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferToggle.ts)
