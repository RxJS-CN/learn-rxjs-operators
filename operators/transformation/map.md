# map

#### 函数签名: `map(project: Function, thisArg: any): Observable`

## 对源 observable 的每个值应用投射函数。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 每个数字加10

( [StackBlitz](https://stackblitz.com/edit/typescript-a7bnxb?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/padasukano/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/yd38awLa/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { map } from 'rxjs/operators';

// 发出 (1,2,3,4,5)
const source = from([1, 2, 3, 4, 5]);
// 每个数字加10
const example = source.pipe(map(val => val + 10));
// 输出: 11,12,13,14,15
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 映射成单一属性

( [StackBlitz](https://stackblitz.com/edit/typescript-qgpnju?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/detozumale/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/tdLd5tgc/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { map } from 'rxjs/operators';

// 发出 ({name: 'Joe', age: 30}, {name: 'Frank', age: 20},{name: 'Ryan', age: 50})
const source = from([
  { name: 'Joe', age: 30 },
  { name: 'Frank', age: 20 },
  { name: 'Ryan', age: 50 }
]);
// 提取每个 person 的 name 属性
const example = source.pipe(map(({ name }) => name));
// 输出: "Joe","Frank","Ryan"
const subscribe = example.subscribe(val => console.log(val));
```

### 相关食谱

* [智能计数器](../../recipes/smartcounter.md)
* [游戏循环](../../recipes/gameloop.md)
* [HTTP 轮询](../../recipes/http-polling.md)

### 其他资源

* [map](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-map) :newspaper: - 官方文档
* [map vs flatMap](https://egghead.io/lessons/rxjs-rxjs-map-vs-flatmap) :video_camera: - Ben Lesh
* [转换操作符: map 和 mapTo](https://egghead.io/lessons/rxjs-transformation-operator-map-and-mapto?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/map.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/map.ts)
