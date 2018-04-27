# from

#### 签名: `from(ish: ObservableInput, mapFn: function, thisArg: any, scheduler: Scheduler): Observable`

## 将数组、promise 或迭代器转换成 observable 。

---

:bulb:  对于数组和迭代器，所有包含的值都会被作为序列发出！

:bulb:  此操作符也可以用来将字符串作为字符的序列发出！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 数组转换而来的 observable 

(
[StackBlitz](https://stackblitz.com/edit/typescript-sckwsw?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/foceyuketi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/o7kb5e6j/) )

```js
// RxJS v6+
import { from } from 'rxjs';

// 将数组作为值的序列发出
const arraySource = from([1, 2, 3, 4, 5]);
// 输出: 1,2,3,4,5
const subscribe = arraySource.subscribe(val => console.log(val));
```

##### 示例 2: promise 转换而来的 observable

(
[StackBlitz](https://stackblitz.com/edit/typescript-clpg1f?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/tamofinujo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/2czc5sae/) )

```js
// RxJS v6+
import { from } from 'rxjs';

// 发出 promise 的结果
const promiseSource = from(new Promise(resolve => resolve('Hello World!')));
// 输出: 'Hello World'
const subscribe = promiseSource.subscribe(val => console.log(val));
```

##### 示例 3: 集合转换而来的 observable

(
[StackBlitz](https://stackblitz.com/edit/typescript-drfckx?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/tezohobudu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ae6hu9a8/) )

```js
// RxJS v6+
import { from } from 'rxjs';

// 使用 js 的集合
const map = new Map();
map.set(1, 'Hi');
map.set(2, 'Bye');

const mapSource = from(map);
// 输出: [1, 'Hi'], [2, 'Bye']
const subscribe = mapSource.subscribe(val => console.log(val));
```

##### 示例 4: 字符串转换而来的 observable

(
[StackBlitz](https://stackblitz.com/edit/typescript-19nejh?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/wenozubana/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/hfvzjcvL/) )

```js
// RxJS v6+
import { from } from 'rxjs';

// 将字符串作为字符序列发出
const source = from('Hello World');
// 输出: 'H','e','l','l','o',' ','W','o','r','l','d'
const subscribe = source.subscribe(val => console.log(val));
```

### 相关食谱

- [进度条](../../recipes/progressbar.md)
- [HTTP 轮询](../../recipes/http-polling.md)

### 其他资源

- [from](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-from) :newspaper: - 官方文档
- [创建操作符: from, fromArray, fromPromise](https://egghead.io/lessons/rxjs-creation-operators-from-fromarray-frompromise?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/from.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/from.ts)
