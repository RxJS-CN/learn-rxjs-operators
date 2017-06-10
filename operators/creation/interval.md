# interval

#### 签名: `interval(period: number, scheduler: Scheduler): Observable`

## 基于给定时间间隔发出数字序列。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每秒发出自增数字

( [jsBin](http://jsbin.com/vigohomabo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/x3mrwzr0/) )

```js
import { interval } from 'rxjs/observable/interval';

// 每1秒发出数字序列中的值
const source = interval(1000);
// 数字: 0,1,2,3,4,5....
const subscribe = source.subscribe(val => console.log(val));
```

### 其他资源

* [interval](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-interval) :newspaper: - 官方文档
* [创建操作符: interval 和 timer](https://egghead.io/lessons/rxjs-creation-operators-interval-and-timer?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/interval.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/interval.ts)
