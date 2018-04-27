# zip

#### 函数签名: `zip(observables: *): Observable`

### 描述

###### TL;DR: 在所有 observables 发出后，将它们的值作为数组发出

**zip** 操作符会订阅所有内部 observables，然后等待每个发出一个值。一旦发生这种情况，将发出具有相应索引的所有值。这会持续进行，直到至少一个内部 
observable 完成。

---

:bulb: 与 [interval](../creation/interval) 或 [timer](../creation/timer.md) 进行组合, zip 可以用来根据另一个 observable 进行定时输出！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 以交替的时间间隔对多个 observables 进行 zip

( [StackBlitz](https://stackblitz.com/edit/typescript-wd2mba?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/lireyisira/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ton462sg/) )

```js
import { delay } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';
import { zip } from 'rxjs/observable/zip';

const sourceOne = of('Hello');
const sourceTwo = of('World!');
const sourceThree = of('Goodbye');
const sourceFour = of('World!');
// 一直等到所有 observables 都发出一个值，才将所有值作为数组发出
const example = zip(
  sourceOne,
  sourceTwo.pipe(delay(1000)),
  sourceThree.pipe(delay(2000)),
  sourceFour.pipe(delay(3000))
);
// 输出: ["Hello", "World!", "Goodbye", "World!"]
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 当一个 observable 完成时进行 zip

( [StackBlitz](https://stackblitz.com/edit/typescript-q1sucs?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/fisitatesa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/oamyk3xr/) )

```js
import { take } from 'rxjs/operators';
import { interval } from 'rxjs/observable/interval';
import { zip } from 'rxjs/observable/zip';

// 每1秒发出值
const source = interval(1000);
// 当一个 observable 完成时，便不会再发出更多的值了
const example = zip(source, source.pipe(take(2)));
// 输出: [0,0]...[1,1]
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [zip](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-zip) :newspaper: - 官方文档
* [组合操作符: zip](https://egghead.io/lessons/rxjs-combination-operator-zip?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/zip.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/zip.ts)
