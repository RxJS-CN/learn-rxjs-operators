# first

#### 函数签名: `first(predicate: function, select: function)`

## 发出第一个值或第一个通过给定表达式的值。

---

:bulb: 与 first 对应的操作符是 [**last**](last.md)！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

(
[example tests](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/filtering/first-spec.ts)
)

##### 示例 1: 序列中的第一个值

( [jsBin](http://jsbin.com/kayenuxoma/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/uncey4v9/) )

```js
import { from } from 'rxjs/observable/from';
import { first } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 没有参数则发出第一个值
const example = source.pipe(first());
// 输出: "First value: 1"
const subscribe = example.subscribe(val => console.log(`First value: ${val}`));
```

##### 示例 2: 第一个通过 predicate 函数的值

( [jsBin](http://jsbin.com/pujowawovu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/pt36r8cu/) )

```js
import { from } from 'rxjs/observable/from';
import { first } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 发出通过测试的第一项
const example = source.pipe(first(num => num === 5));
// 输出: "First to pass test: 5"
const subscribe = example.subscribe(val =>
  console.log(`First to pass test: ${val}`)
);
```

##### 示例 3: 使用可选的 projection 函数

( [jsBin](http://jsbin.com/qijekijaja/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/qosu0cx6/) )

```js
const source = Rx.Observable.from([1, 2, 3, 4, 5]);
// 使用可选的 projection 函数
const example = source.first(
  num => num % 2 === 0,
  (result, index) => `First even: ${result} is at index: ${index}`
);
// 输出: "First even: 2 at index: 1"
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 4: 利用默认值

( [jsBin](http://jsbin.com/qoganeleqa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/owx2jdg1/3/) )

```js
const source = Rx.Observable.from([1, 2, 3, 4, 5]);
// 没有值通过的话则发出默认值
const example = source.first(val => val > 5, val => `Value: ${val}`, 'Nothing');
// 输出: 'Nothing'
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [first](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-first) :newspaper: - 官方文档
* [过滤操作符: take, first, skip](https://egghead.io/lessons/rxjs-filtering-operators-take-first-skip?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/first.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/first.ts)
