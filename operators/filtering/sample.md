# sample

#### 签名: `sample(sampler: Observable): Observable`

## 当提供的 observable 发出时从源 observable 中取样。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 每2秒对源 observable 取样

(
[StackBlitz](https://stackblitz.com/edit/typescript-envpsp?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/gemebopifu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8wsbuvjb/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { sample } 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 每2秒对源 observable 最新发出的值进行取样
const example = source.pipe(sample(interval(2000)));
// 输出: 2..4..6..8..
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 当 interval 发出时对源 observable 取样

(
[StackBlitz](https://stackblitz.com/edit/typescript-sgat7t?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/cunicepube/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/b33kg9dn/) )

```js
// RxJS v6+
import { interval, zip, from } from 'rxjs';
import { sample } from 'rxjs/operators';

const source = zip(
  // 发出 'Joe', 'Frank' and 'Bob' in sequence
  from(['Joe', 'Frank', 'Bob']),
  // 每2秒发出值
  interval(2000)
);
// 每2.5秒对源 observable 最新发出的值进行取样
const example = source.pipe(sample(interval(2500)));
// 输出: ["Joe", 0]...["Frank", 1]...........
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 区分拖拽和点击

来源: [Stack Overflow](https://stackoverflow.com/a/44865892/2774547)
作者: [Dorus](https://stackoverflow.com/users/402027/dorus)

(
[StackBlitz](https://stackblitz.com/edit/typescript-vk8p3e?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/riwipicilo/1/edit?html,js,console,output) |
[jsFiddle](https://jsfiddle.net/6yy6q0Lo/1/) )

```js
// RxJS v6+
import { fromEvent, merge } from 'rxjs';
import { sample, mapTo } from 'rxjs/operators';

const listener = merge(
  fromEvent(document, 'mousedown').pipe(mapTo(false)),
  fromEvent(document, 'mousemove').pipe(mapTo(true))
)
  .pipe(sample(fromEvent(document, 'mouseup')))
  .subscribe(isDragging => {
    console.log('Were you dragging?', isDragging);
  });
```

### 其他资源

- [sample](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-sample) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/sample.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/sample.ts)
