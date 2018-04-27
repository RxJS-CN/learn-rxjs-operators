# last

#### 函数签名: `last(predicate: function): Observable`

## 根据提供的表达式，在源 observable 完成时发出它的最后一个值。

---

:bulb: 与 last 对应的操作符是 [**first**](first.md)！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 序列中的最后一个值

(
[StackBlitz](https://stackblitz.com/edit/typescript-ma7knv?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/pevaqeloki/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/b05r434a/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { last } 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 没有参数则发出最后一个值
const example = source.pipe(last());
// 输出: "Last value: 5"
const subscribe = example.subscribe(val => console.log(`Last value: ${val}`));
```

##### 示例 2: 最后一个通过 predicate 函数的值

(
[StackBlitz](https://stackblitz.com/edit/typescript-tk42hj?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/yagexuwari/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/pkx2btsh/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { last } 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 发出最后一个偶数
const exampleTwo = source.pipe(last(num => num % 2 === 0));
// 输出: "Last to pass test: 4"
const subscribeTwo = exampleTwo.subscribe(val =>
  console.log(`Last to pass test: ${val}`)
);
```

##### 示例 3: 使用结果选择器的 last

(
[StackBlitz](https://stackblitz.com/edit/typescript-nrc1an?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/fudubebabi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/L7fbx3vp/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { last } 'rxjs/operators';

const source = from([1, 2, 3, 4, 5]);
// 没有值通过的话则发出默认值
const exampleTwo = source.pipe(last(v => v > 5, 'Nothing!'));
// 输出: 'Nothing!'
const subscribeTwo = exampleTwo.subscribe(val => console.log(val));
```

### 其他资源

- [last](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-last) :newspaper: - 官方文档
- [过滤操作符: takeLast, last](https://egghead.io/lessons/rxjs-filtering-operators-takelast-last?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/last.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/last.ts)
