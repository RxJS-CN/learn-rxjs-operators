# mapTo

#### 签名: `mapTo(value: any): Observable`

## 将每个发出值映射成常量。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 将每个发出值映射成字符串

(
[StackBlitz](https://stackblitz.com/edit/typescript-zdgcuu?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/qujolenili/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/4ojq56ng/) )

```js
import { interval } from 'rxjs/observable/interval';
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
[StackBlitz](https://stackblitz.com/edit/typescript-qm5spu?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/xaheciwara/1/edit?js,console,output) |
[jsFiddle](https://jsfiddle.net/btroncone/52fqL4nn/) )

```js
import { fromEvent } from 'rxjs/observable/fromEvent';
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

* [mapTo](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-mapTo) :newspaper: - 官方文档
* [使用 mapTo 来改变行为](https://egghead.io/lessons/rxjs-changing-behavior-with-mapto?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [转换操作符: map 和 mapTo](https://egghead.io/lessons/rxjs-transformation-operator-map-and-mapto?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mapTo.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/mapTo.ts)
