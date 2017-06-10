# throttleTime

#### 签名: `throttleTime(duration: number, scheduler: Scheduler): Observable`

## 当指定的持续时间经过后发出最新值。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每5秒接收最新值

( [jsBin](http://jsbin.com/koqujayizo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/4zysLc3y/) )

```js
import { interval } from 'rxjs/observable/interval';
import { throttleTime } 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
/*
  节流5秒
  节流结束前发出的最后一个值将从源 observable 中发出
*/
const example = source.pipe(throttleTime(5000));
// 输出: 0...6...12
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 对合并的 observable 节流

( [jsBin](http://jsbin.com/takipadaza/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/xhd1zy3m/) )

```js
import { interval } from 'rxjs/observable/interval';
import { merge } from 'rxjs/observable/merge';
import { throttleTime, ignoreElements } from 'rxjs/operators';

const source = merge(
  //  每0.75秒发出值
  interval(750),
  // 每1秒发出值
  interval(1000)
);
// 在发出值的中间进行节流
const example = source.pipe(throttleTime(1200));
// 输出: 0...1...4...4...8...7
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [throttleTime](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-throttleTime) :newspaper: - 官方文档
* [过滤操作符: throttle 和 throttleTime](https://egghead.io/lessons/rxjs-filtering-operators-throttle-and-throttletime?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/throttleTime.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/throttleTime.ts)
