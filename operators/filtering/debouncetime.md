# debounceTime

#### 签名: `debounceTime(dueTime: number, scheduler: Scheduler): Observable`

## 舍弃掉在两次输出之间小于指定时间的发出值

---

:bulb:  此操作符在诸如预先知道用户的输入频率的场景下很受欢迎！

---

### 示例

##### 示例 1: 基于输入间隔时间的 debounce

( [jsBin](http://jsbin.com/kacijarogi/1/edit?js,console,output) |
[jsFiddle](https://jsfiddle.net/btroncone/7kbg4q2e/) )

```js
import { fromEvent } from 'rxjs/observable/fromEvent';
import { timer } from 'rxjs/observable/timer';
import { debounceTime, map } from 'rxjs/operators';

const input = document.getElementById('example');

// 对于每次键盘敲击，都将映射成当前输入值
const example = fromEvent(input, 'keyup').pipe(map(i => i.currentTarget.value));

// 在两次键盘敲击之间等待0.5秒方才发出当前值，
// 并丢弃这0.5秒内的所有其他值
const debouncedInput = example.pipe(debounceTime(500));

// 输出值
const subscribe = debouncedInput.subscribe(val => {
  console.log(`Debounced Input: ${val}`);
});
```

### 其他资源

* [debounceTime](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-debounceTime) :newspaper: - 官方文档
* [转换操作符: debounce 和 debounceTime](https://egghead.io/lessons/rxjs-transformation-operators-debounce-and-debouncetime?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/debounceTime.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/debounceTime.ts)
