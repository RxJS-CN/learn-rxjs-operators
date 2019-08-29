# combineAll

#### 函数签名: `combineAll(project: function): Observable`

## 当源 observable 完成时，对收集的 observables 使用 [combineLatest](combinelatest.md) 。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

( [示例测试](https://github.com/btroncone/learn-rxjs/blob/master/operators/specs/combination/combineall-spec.ts) )

##### 示例 1: 映射成内部的 interval observable

(
[StackBlitz](https://stackblitz.com/edit/typescript-fbxfyh?file=index.ts&devtoolsheight=100)
)

```js
// RxJS v6+
import { take, map, combineAll } from 'rxjs/operators';
import { interval } from 'rxjs';

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

* [combineAll](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-combineAll) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineAll.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/combineAll.ts)
