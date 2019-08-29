# partition

#### 函数签名: `partition(predicate: function: boolean, thisArg: any): [Observable, Observable]`

## Split one observable into two based on provided predicate.

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 分割偶数和奇数

(
[StackBlitz](https://stackblitz.com/edit/typescript-gr3ljs?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/hipehexaku/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/q0xo7gvv/) )

```js
// RxJS v6+
import { from, merge } from 'rxjs';
import { partition, map } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5, 6]);
// 第一个值(events)返回 true 的数字集合，第二个值(odds)是返回 false 的数字集合
const [evens, odds] = source.pipe(partition(val => val % 2 === 0));
/*
  输出:
  "Even: 2"
  "Even: 4"
  "Even: 6"
  "Odd: 1"
  "Odd: 3"
  "Odd: 5"
*/
const subscribe = merge(
  evens.pipe(map(val => `Even: ${val}`)),
  odds.pipe(map(val => `Odd: ${val}`))
).subscribe(val => console.log(val));
```

##### 示例 2: 分割正常执行和错误

(
[StackBlitz](https://stackblitz.com/edit/typescript-vmfvp8?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/kukuguhuri/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/fe246u5p/) )

```js
// RxJS v6+
import { merge, of, from } from 'rxjs';
import { map, partition, catchError } from 'rxjs/operators';

const source = from([1, 2, 3, 4, 5, 6]);
// 如果大于3就抛出错误
const example = source.pipe(
  map(val => {
    if (val > 3) {
      throw `${val} greater than 3!`;
    }
    return { success: val };
  }),
  catchError(val => of({ error: val }))
);
// 分割正常执行或错误
const [success, error] = example.pipe(partition(res => res.success));
/*
  输出:
  "Success! 1"
  "Success! 2"
  "Success! 3"
  "Error! 4 greater than 3!"
*/
const subscribe = merge(
  success.pipe(map(val => `Success! ${val.success}`)),
  error.pipe(map(val => `Error! ${val.error}`))
).subscribe(val => console.log(val));
```

### 其他资源

- [partition](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-partition) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/partition.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/partition.ts)
