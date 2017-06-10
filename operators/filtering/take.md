# take

#### 签名: ` take(count: number): Observable`

## 在完成前发出N个值(N由参数决定)。

### Why use `take`

When you are interested in only the first set number of emission, you want to
use `take`. Maybe you want to see what the user first clicked on when he/she
first entered the page, you would want to subscribe to the click event and just
take the first emission. There is a race and you want to observe the race, but
you're only interested in the first who crosses the finish line. This operator
is clear and straight forward, you just want to see the first _n_ numbers of
emission to do whatever it is you need.

---

:bulb: 如果想基于某个逻辑或另一个 observable 来取任意数量的值，你可以 [takeUntil](takeuntil.md) 或 [takeWhile](takewhile.md)！

:bulb: `take` is the opposite of `skip` where `take` will take the first _n_
number of emissions while `skip` will skip the first _n_ number of emissions.

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 从源 observable 中取第一个值

( [jsBin](http://jsbin.com/vaxitupiwi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/f9bz0tr3/) )

```js
import { of } from 'rxjs/observable/of';
import { take } 'rxjs/operators';

// 发出 1,2,3,4,5
const source = of(1, 2, 3, 4, 5);
// 取第一个发出的值然后完成
const example = source.pipe(take(1));
// 输出: 1
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 从源 observable 中取前5个值

( [jsBin](http://jsbin.com/kexenuzulu/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/g1fhxgua/) )

```js
import { interval } from 'rxjs/observable/interval';
import { take } 'rxjs/operators';

// 每1秒发出值
const interval = interval(1000);
// 取前5个发出的值
const example = interval.pipe(take(5));
// 输出: 0,1,2,3,4
const subscribe = example.subscribe(val => console.log(val));
```

##### Example 3: Taking first click loclation

([jsFiddle](https://jsfiddle.net/ElHuy/9c5j064x/))

```html
<div id="locationDisplay">
  Where would you click first?
</div>
```

```js
import { fromEvent } from 'rxjs/observable/fromEvent';
import { take, tap } 'rxjs/operators';

const oneClickEvent = fromEvent(document, 'click').pipe(
    take(1),
    tap(v => {
      document.getElementById('locationDisplay').innerHTML
        = `Your first click was on location ${v.screenX}:${v.screenY}`;
    })
  )

const subscribe = oneClickEvent.subscribe();
```

### 其他资源

* [take](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-take) :newspaper: - 官方文档
* [过滤操作符: take, first, skip](https://egghead.io/lessons/rxjs-filtering-operators-take-first-skip?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/take.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/take.ts)
