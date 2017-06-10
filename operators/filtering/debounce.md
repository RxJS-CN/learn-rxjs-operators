# debounce

#### 签名: `debounce(durationSelector: function): Observable`

## 根据一个选择器函数，舍弃掉在两次输出之间小于指定时间的发出值。

---

:bulb: 尽管没有 [debounceTime](debouncetime.md) 使用广泛，但当 debounce 的频率是变量时, **debounce** 是很重要的！

---

### 示例

##### 示例 1: 基于 timer 的 debounce

( [jsBin](http://jsbin.com/sorimeyoro/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/e5698yow/) )

```js
import { of } from 'rxjs/observable/of';
import { timer } from 'rxjs/observable/timer';
import { debounce } from 'rxjs/operators';

// 发出四个字符串
const example = of('WAIT', 'ONE', 'SECOND', 'Last will display');
/*
  只有在最后一次发送后再经过一秒钟，才会发出值，并抛弃在此之前的所有其他值
*/
const debouncedExample = example.pipe(debounce(() => timer(1000)));
/*
    在这个示例中，所有的值都将被忽略，除了最后一个
    输出: 'Last will display'
*/
const subscribe = debouncedExample.subscribe(val => console.log(val));
```

##### 示例 2: 基于 interval 的 dobounce

( [jsBin](http://jsbin.com/sotaretese/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6ab34nq6/) )

```js
import { interval } from 'rxjs/observable/interval';
import { timer } from 'rxjs/observable/timer';
import { debounce } from 'rxjs/operators';

// 每1秒发出值, 示例: 0...1...2
const interval = interval(1000);
// 每1秒都将 debounce 的时间增加200毫秒
const debouncedInterval = interval.pipe(debounce(val => timer(val * 200)));
/*
  5秒后，debounce 的时间会大于 interval 的时间，之后所有的值都将被丢弃
  输出: 0...1...2...3...4......(debounce 的时间大于1秒后则不再发出值)
*/
const subscribe = debouncedInterval.subscribe(val =>
  console.log(`Example Two: ${val}`)
);
```

### 其他资源

* [debounce](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-debounce) :newspaper: - 官方文档
* [转换操作符: debounce 和 debounceTime](https://egghead.io/lessons/rxjs-transformation-operators-debounce-and-debouncetime?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/debounce.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/debounce.ts)
