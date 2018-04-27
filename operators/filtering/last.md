# last

#### 函数签名: `last(predicate: function): Observable`

## 根据提供的表达式，在源 observable 完成时发出它的最后一个值。

---

:bulb: 与 last 对应的操作符是 [**first**](first.md)！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 序列中的最后一个值

( [jsBin](http://jsbin.com/pevaqeloki/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/b05r434a/) )

```js
import { from } from 'rxjs/observable/from';
import { last } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 没有参数则发出最后一个值
const example = source.pipe(last());
// 输出: "Last value: 5"
const subscribe = example.subscribe(val => console.log(`Last value: ${val}`));
```

##### 示例 2: 最后一个通过 predicate 函数的值

( [jsBin](http://jsbin.com/yagexuwari/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/pkx2btsh/) )

```js
import { from } from 'rxjs/observable/from';
import { last } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 发出最后一个偶数
const exampleTwo = source.pipe(last(num => num % 2 === 0));
// 输出: "Last to pass test: 4"
const subscribeTwo = exampleTwo.subscribe(val =>
  console.log(`Last to pass test: ${val}`)
);
```

##### 示例 3: 使用结果选择器的 last

( [jsBin](http://jsbin.com/hobinukisu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/76247162/) )

```js
import { from } from 'rxjs/observable/from';
import { last } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 提供第二个参数，它是一个可选的投射函数
const exampleTwo = source.pipe(
  last(
    v => v > 4,
    v => `The highest emitted number was ${v}`
  )
);
// 输出: 'The highest emitted number was 5'
const subscribeTwo = exampleTwo.subscribe(val => console.log(val));
```

##### 示例 4: 使用默认值的 last

( [jsBin](http://jsbin.com/fudubebabi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/L7fbx3vp/) )

```js
import { from } from 'rxjs/observable/from';
import { last } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 没有值通过的话则发出默认值
const exampleTwo = source.pipe(last(v => v > 5, v => v, 'Nothing!'));
// 输出: 'Nothing!'
const subscribeTwo = exampleTwo.subscribe(val => console.log(val));
```

### 其他资源

* [last](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-last) :newspaper: - 官方文档
* [过滤操作符: takeLast, last](https://egghead.io/lessons/rxjs-filtering-operators-takelast-last?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/last.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/last.ts)
