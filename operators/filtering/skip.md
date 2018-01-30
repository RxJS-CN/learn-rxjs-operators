# skip

#### 签名: `skip(the: Number): Observable`

## 跳过N个(由参数提供)发出值。

### 为什么使用 `skip`？

`skip` 允许你忽略源 observable 开头的n个值。通常，当你总是想忽略 observable 的某些值时，应该使用 `skip` 。或许你不需要这些开头的值，或许你订阅了 `Replay` 或 `BehaviorSubject` 从而不需要初始值。如果你不关心开头的一组值，那就使用 `skip` 吧。

你可以使用 [`filter`](./filter.md) 加索引来模拟 `skip` 。例如 `.filter((val, index) => index > 1)` 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 在发送前跳过N个值

( [jsBin](http://jsbin.com/hacepudabi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ar1eqbya/) )

```js
import { interval } from 'rxjs/observable/interval';
import { skip } 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 跳过前5个发出值
const example = source.pipe(skip(5));
// 输出: 5...6...7...8........
const subscribe = example.subscribe(val => console.log(val));
```

#### 示例 2: filter 特定用法的简写形式

( [jsBin](http://jsbin.com/judamurego/edit?js,console) |
[jsFiddle](https://jsfiddle.net/ElHuy/4jswLn3z/) )

```js
import { from } from 'rxjs/observable/from';
import { skip, filter } 'rxjs/operators';

const numArrayObs = from([1,2,3,4,5,6,7,8,9,10]);

// 3,4,5...
const skipObs = numArrayObs.pipe(skip(2))
    .subscribe(console.log);

// 3,4,5...
const filterObs = numArrayObs.pipe(
    filter((val, index) => index > 1)
  )
  .subscribe(console.log);

// 同样的输出！
```

### 其他资源

* [skip](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-skip) :newspaper: - 官方文档
* [过滤操作符: take, first, skip](https://egghead.io/lessons/rxjs-filtering-operators-take-first-skip?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skip.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skip.ts)
