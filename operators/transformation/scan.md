# scan

#### 函数签名: `scan(accumulator: function, seed: any): Observable`

## 随着时间的推移进行归并。

---

:bulb: 此操作符是许多基于 [Redux](http://redux.js.org) 实现的 RxJS 的核心！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 随着时间的推移计算总数

( [StackBlitz](https://stackblitz.com/edit/typescript-jkisea?file=index.ts&devtoolsheight=50) )

```js
import { of } from 'rxjs/observable/of';
import { scan } from 'rxjs/operators';

const source = of(1, 2, 3);
// 基础的 scan 示例，从0开始，随着时间的推移计算总数
const example = source.pipe(scan((acc, curr) => acc + curr, 0));
// 输出累加值
// 输出: 1,3,6
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 对对象进行累加

( [StackBlitz](https://stackblitz.com/edit/typescript-pjmrta?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/fusunoguqu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/36rbu38b/) )

```js
import { Subject } from 'rxjs/Subject';
import { scan } from 'rxjs/operators';

const subject = new Subject();
// scan 示例，随着时间的推移构建对象
const example = subject.pipe(
  scan((acc, curr) => Object.assign({}, acc, curr), {})
);
// 输出累加值
const subscribe = example.subscribe(val =>
  console.log('Accumulated object:', val)
);
// subject 发出的值会被添加成对象的属性
// {name: 'Joe'}
subject.next({ name: 'Joe' });
// {name: 'Joe', age: 30}
subject.next({ age: 30 });
// {name: 'Joe', age: 30, favoriteLanguage: 'JavaScript'}
subject.next({ favoriteLanguage: 'JavaScript' });
```

##### 示例 3: 随机发出累加数组中的值。

( [StackBlitz](https://stackblitz.com/edit/typescript-sxhtbf?file=index.ts&devtoolsheight=50) )

```js
import { interval } from 'rxjs/observable/interval';
import { scan, map, distinctUntilChanged } from 'rxjs/operators';

// 累加数组中的值，并随机发出此数组中的值
const scanObs = interval(1000)
  .pipe(
    scan((a, c) => [...a, c], []),
    map(r => r[Math.floor(Math.random() * r.length)]),
    distinctUntilChanged()
  )
  .subscribe(console.log);
```

### 相关食谱

* [智能计数器](../../recipes/smartcounter.md)
* [进度条](../../recipes/progressbar.md)

### 其他资源

* [scan](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-scan) :newspaper: - 官方文档
* [使用 RxJS 中的 reduce 和 scan 聚集流](https://egghead.io/lessons/rxjs-aggregating-streams-with-reduce-and-scan-using-rxjs) :video_camera: - Ben Lesh
* [使用 scan 更新数据](https://egghead.io/lessons/rxjs-updating-data-with-scan?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [转换操作符: scan](https://egghead.io/lessons/rxjs-transformation-operator-scan?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/scan.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/scan.ts)
