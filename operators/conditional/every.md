# every

#### 函数签名: `every(predicate: function, thisArg: any): Observable`

## 如果完成时所有的值都能通过断言，那么发出 true，否则发出 false 。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 一些值不符合条件

(
[Stackblitz](https://stackblitz.com/edit/typescript-299d7s?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/cibijotase/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/1b46tsm7/) )

```js
// RxJS v6+
import { every } from 'rxjs/operators';
import { of } from 'rxjs';

// 发出5个值
const source = of(1, 2, 3, 4, 5);
const example = source.pipe(
  // 每个值都是偶数吗？
  every(val => val % 2 === 0)
);
// 输出: false
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 所有值都符合条件

(
[Stackblitz](https://stackblitz.com/edit/typescript-ztrzqe?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/yuxefiviko/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/x34nLmcj/) )

```js
// RxJS v6+
import { every } from 'rxjs/operators';
import { of } from 'rxjs';

// 发出5个值
const allEvens = of(2, 4, 6, 8, 10);
const example = allEvens.pipe(
  // 每个值都是偶数吗？
  every(val => val % 2 === 0)
);
// 输出: true
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

- [every](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-every) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/every.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/every.ts)
