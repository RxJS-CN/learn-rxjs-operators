# buffer

#### 签名: `buffer(closingNotifier: Observable): Observable`

## 收集输出值，直到提供的 observable 发出才将收集到的值作为数组发出。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 缓冲值直到点击页面

( [StackBlitz](https://stackblitz.com/edit/typescript-p1fckr?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/fazimarajo/edit?js,console,output) |
[jsFiddle](https://jsfiddle.net/btroncone/7451s67k/) )

```js
import { interval } from 'rxjs/observable/interval';
import { fromEvent } from 'rxjs/observable/fromEvent';
import { buffer } from 'rxjs/operators';

// 创建每1秒发出值的 observable
const myInterval = interval(1000);
// 创建页面点击事件的 observable
const bufferBy = fromEvent(document, 'click');
/*
  收集由 myInterval 发出的所有值，直到我们点击页面。此时 bufferBy 会发出值以完成缓存。
  将自上次缓冲以来收集的所有值传递给数组。
*/
const myBufferedInterval = myInterval.pipe(buffer(bufferBy));
// 打印值到控制台
// 例如 输出: [1,2,3] ... [4,5,6,7,8]
const subscribe = myBufferedInterval.subscribe(val =>
  console.log(' Buffered Values:', val)
);
```

### 相关食谱

* [游戏循环](../../recipes/gameloop.md)

### 其他资源

* [buffer](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-buffer) :newspaper: - 官方文档
* [转换操作符: buffer](https://egghead.io/lessons/rxjs-transformation-operator-buffer?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/buffer.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/buffer.ts)
