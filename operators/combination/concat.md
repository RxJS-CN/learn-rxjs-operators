# concat

#### 签名: `concat(observables: ...*): Observable`

## 按照顺序，前一个 observable 完成了再订阅下一个 observable 并发出值。

---

:bulb:  你可以把 concat 想象成 ATM 机前的长队，下一次交易 (subscription) 不能在前一个交易完成前开始！

:bulb:  此操作符可以既有静态方法，又有实例方法！

:bulb:  如果产生值的顺序不是首要考虑的，那么试试用 [merge](merge.md) 来代替！

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/concat-spec.ts) )

##### 示例 1: concat 2个基础的 observables

( [StackBlitz](https://stackblitz.com/edit/typescript-oqm79a?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/gegubutele/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/rxwnr3hh/) )

```js
import { concat } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

// 发出 1,2,3
const sourceOne = of(1, 2, 3);
// 发出 4,5,6
const sourceTwo = of(4, 5, 6);
// 先发出 sourceOne 的值，当完成时订阅 sourceTwo
const example = sourceOne.pipe(concat(sourceTwo));
// 输出: 1,2,3,4,5,6
const subscribe = example.subscribe(val =>
  console.log('Example: Basic concat:', val)
);
```

##### 示例 2: concat 作为静态方法

( [StackBlitz](https://stackblitz.com/edit/typescript-oqtzx7?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/xihagewune/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/5qdtvhu8/) )

```js
import { of } from 'rxjs/observable/of';
import { concat } from 'rxjs/observable/concat';

// 发出 1,2,3
const sourceOne = of(1, 2, 3);
// 发出 4,5,6
const sourceTwo = of(4, 5, 6);

// 作为静态方法使用
const example = concat(sourceOne, sourceTwo);
// 输出: 1,2,3,4,5,6
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 使用延迟的 souce observable 进行 concat

( [StackBlitz](https://stackblitz.com/edit/typescript-rkvfgp?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/nezonosubi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/L2s49msx/) )

```js
import { delay, concat } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

// 发出 1,2,3
const sourceOne = of(1, 2, 3);
// 发出 4,5,6
const sourceTwo = of(4, 5, 6);

// 延迟3秒，然后发出
const sourceThree = sourceOne.pipe(delay(3000));
// sourceTwo 要等待 sourceOne 完成才能订阅
const example = sourceThree.pipe(concat(sourceTwo));
// 输出: 1,2,3,4,5,6
const subscribe = example.subscribe(val =>
  console.log('Example: Delayed source one:', val)
);
```

##### 示例 4: 使用不完成的 source observable 进行 concat

( [StackBlitz](https://stackblitz.com/edit/typescript-pccj1d?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/vixajoxaze/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/4bhtb81u/) )

```js
import { interval } from 'rxjs/observable/interval';
import { of } from 'rxjs/observable/of';
import { concat } from 'rxjs/observable/concat';

// 当 source 永远不完成时，随后的 observables 永远不会运行
const source = concat(interval(1000), of('This', 'Never', 'Runs'));
// 输出: 0,1,2,3,4....
const subscribe = source.subscribe(val =>
  console.log(
    'Example: Source never completes, second observable never runs:',
    val
  )
// 输出: 1,2,3,4....
const subscribe = source.subscribe(val => console.log('Example: Source never completes, second observable never runs:', val));
```


### 其他资源

* [concat](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-concat) :newspaper: - 官方文档
* [组合操作符: concat, startWith](https://egghead.io/lessons/rxjs-combination-operators-concat-startwith?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concat.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/concat.ts)
