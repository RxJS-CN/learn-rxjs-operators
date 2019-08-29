# takeWhile

#### 函数签名: `takeWhile(predicate: function(value, index): boolean): Observable`

## 发出值，直到提供的表达式结果为 false 。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 使用限定条件取值

(
[StackBlitz](https://stackblitz.com/edit/typescript-af3hdf?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/zanefaqexu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/yakd4jgc/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { takeWhile } from 'rxjs/operators';

// 发出 1,2,3,4,5
const source = of(1, 2, 3, 4, 5);
// 允许值发出直到 source 中的值大于4，然后便完成
const example = source.pipe(takeWhile(val => val <= 4));
// 输出: 1,2,3,4
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: takeWhile() 和 filter() 的区别

(
[StackBlitz](https://stackblitz.com/edit/typescript-roozza?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/yatoqurewi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/r497jgw3/4/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { takeWhile, filter } from 'rxjs/operators';

// 发出 3, 3, 3, 9, 1, 4, 5, 8, 96, 3, 66, 3, 3, 3
const source = of(3, 3, 3, 9, 1, 4, 5, 8, 96, 3, 66, 3, 3, 3);

// 允许值通过直到源发出的值不等于3，然后完成
// 输出: [3, 3, 3]
source
  .pipe(takeWhile(it => it === 3))
  .subscribe(val => console.log('takeWhile', val));

// 输出: [3, 3, 3, 3, 3, 3, 3]
source
  .pipe(filter(it => it === 3))
  .subscribe(val => console.log('filter', val));
```

### 相关食谱

- [智能计数器](../../recipes/smartcounter.md)

### 其他资源

- [takeWhile](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-takeWhile) :newspaper: - 官方文档
- [使用 takeWhile 完成流](https://egghead.io/lessons/rxjs-completing-a-stream-with-takewhile?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/takeWhile.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/takeWhile.ts)
