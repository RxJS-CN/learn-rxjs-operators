# defaultIfEmpty

#### 签名: `defaultIfEmpty(defaultValue: any): Observable`

## 如果在完成前没有发出任何通知，那么发出给定的值

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 没有值的 Observable.of 的默认值

(
[Stackblitz](https://stackblitz.com/edit/typescript-3btzml?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/yawumoqatu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8ex96cov/) )

```js
// RxJS v6+
import { defaultIfEmpty } from 'rxjs/operators';
import { of } from 'rxjs';

const empty = of();
// 当源 observable 为空时，发出 'Observable.of() Empty!'，否则发出源的任意值
const exampleOne = empty.pipe(defaultIfEmpty('Observable.of() Empty!'));
// 输出: 'Observable.of() Empty!'
const subscribe = exampleOne.subscribe(val => console.log(val));
```

##### 示例 2: Observable.empty 的默认值

(
[Stackblitz](https://stackblitz.com/edit/typescript-tyfjhu?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/kojafuvesu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/3edw828p/) )

```js
// RxJS v6+
import { defaultIfEmpty } from 'rxjs/operators';
import { empty } from 'rxjs';

// 空的 observable
const empty = empty();
// 当源 observable 为空时，发出 'Observable.empty()!'，否则发出源的任意值
const example = empty.pipe(defaultIfEmpty('Observable.empty()!'));
// 输出: 'Observable.empty()!'
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

- [defaultIfEmpty](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-defaultIfEmpty) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/defaultIfEmpty.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/defaultIfEmpty.ts)
