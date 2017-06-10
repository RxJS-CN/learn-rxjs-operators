# delayWhen

#### 签名: `delayWhen(selector: Function, sequence: Observable): Observable`

## 延迟发出值，延迟时间由提供函数决定。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 基于 observable 的延迟

(
[StackBlitz](https://stackblitz.com/edit/typescript-ydbk4j?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/topohekuje/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/b057mxkL/) )

```js
import { interval } from 'rxjs/observable/interval';
import { timer } from 'rxjs/observable/timer';
import { delayWhen } from 'rxjs/operators';

// 每1秒发出值
const message = interval(1000);
// 5秒后发出值
const delayForFiveSeconds = () => timer(5000);
// 5秒后，开始发出 interval 延迟的值
const delayWhenExample = message.pipe(delayWhen(delayForFiveSeconds));
// 延迟5秒后输出值
// 例如， 输出: 5s....1...2...3
const subscribe = delayWhenExample.subscribe(val => console.log(val));
```

### 其他资源

* [delayWhen](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-delayWhen) :newspaper: - 官方文档
* [转换操作符: delay 和 delayWhen](https://egghead.io/lessons/rxjs-transformation-operators-delay-and-delaywhen?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/delayWhen.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/delayWhen.ts)
