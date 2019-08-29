# mapTo

#### 函数签名: `mapTo(value: any): Observable`

## 将每个发出值映射成常量。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 将每个发出值映射成字符串

(
[StackBlitz](https://stackblitz.com/edit/typescript-fipd7a?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/qujolenili/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/4ojq56ng/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { mapTo } from 'rxjs/operators';

// 每2秒发出值
const source = interval(2000);
// 将所有发出值映射成同一个值
const example = source.pipe(mapTo('HELLO WORLD!'));
// 输出: 'HELLO WORLD!'...'HELLO WORLD!'...'HELLO WORLD!'...
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 将点击映射成字符串

(
[StackBlitz](https://stackblitz.com/edit/typescript-btghci?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/xaheciwara/1/edit?js,console,output) |
[jsFiddle](https://jsfiddle.net/btroncone/52fqL4nn/) )

```js
// RxJS v6+
import { fromEvent } from 'rxjs';
import { mapTo } from 'rxjs/operators';

// 发出每个页面点击
const source = fromEvent(document, 'click');
// 将所有发出值映射成同一个值
const example = source.pipe(mapTo('GOODBYE WORLD!'));
// 输出: (click)'GOODBYE WORLD!'...
const subscribe = example.subscribe(val => console.log(val));
```

### 相关食谱

* [HTTP 轮询](../../recipes/http-polling.md)
* [智能计数器](../../recipes/smartcounter.md)

### 其他资源

* [mapTo](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-mapTo) :newspaper: - 官方文档
* [使用 mapTo 来改变行为](https://egghead.io/lessons/rxjs-changing-behavior-with-mapto?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [转换操作符: map 和 mapTo](https://egghead.io/lessons/rxjs-transformation-operator-map-and-mapto?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mapTo.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mapTo.ts)
