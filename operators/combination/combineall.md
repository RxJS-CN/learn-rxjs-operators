# combineAll

#### 签名: `combineAll(project: function): Observable`

## 当源 observable 完成时，对收集的 observables 使用 [combineLatest](combinelatest.md) 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/combineall-spec.ts) )

##### 示例 1: 映射成内部的 interval observable

( [StackBlitz](https://stackblitz.com/edit/typescript-itxyuv?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/cokinogime/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/pvj1nbLa/) )

```js
import { take, map, combineAll } from 'rxjs/operators';
import { interval } from 'rxjs/observable/interval';

// 每秒发出值，并只取前2个
const source = interval(1000).pipe(take(2));
// 将 source 发出的每个值映射成取前5个值的 interval observable
const example = source.pipe(
  map(val => interval(1000).pipe(map(i => `Result (${val}): ${i}`), take(5)))
);
/*
  soure 中的2个值会被映射成2个(内部的) interval observables，
  这2个内部 observables 每秒使用 combineLatest 策略来 combineAll，
  每当任意一个内部 observable 发出值，就会发出每个内部 observable 的最新值。
*/
const combined = example.pipe(combineAll());
/*
  输出:
  ["Result (0): 0", "Result (1): 0"]
  ["Result (0): 1", "Result (1): 0"]
  ["Result (0): 1", "Result (1): 1"]
  ["Result (0): 2", "Result (1): 1"]
  ["Result (0): 2", "Result (1): 2"]
  ["Result (0): 3", "Result (1): 2"]
  ["Result (0): 3", "Result (1): 3"]
  ["Result (0): 4", "Result (1): 3"]
  ["Result (0): 4", "Result (1): 4"]
*/
const subscribe = combined.subscribe(val => console.log(val));
```

### 其他资源

* [combineAll](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-combineAll) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineAll.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineAll.ts)
