# ignoreElements

#### 签名: `ignoreElements(): Observable`

## 忽略所有通知，除了 complete 和 error 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 忽略源 observable 的所有数据项

( [jsBin](http://jsbin.com/yiyefelubi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/59scjqss/) )

```js
import { interval } from 'rxjs/observable/interval';
import { take, ignoreElements } from 'rxjs/operators';

// 每100毫秒发出值
const source = interval(100);
// 忽略所有值，只发出 complete
const example = source.pipe(take(5), ignoreElements());
// 输出: "COMPLETE!"
const subscribe = example.subscribe(
  val => console.log(`NEXT: ${val}`),
  val => console.log(`ERROR: ${val}`),
  () => console.log('COMPLETE!')
);
```

##### 示例 2: 只显示错误

( [jsBin](http://jsbin.com/gogonawuze/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/srcwdgw6/) )

```js
import { interval } from 'rxjs/observable/interval';
import { _throw } from 'rxjs/observable/throw';
import { of } from 'rxjs/observable/of';
import { mergeMap, ignoreElements } from 'rxjs/operators';

// 每100毫秒发出值
const source = interval(100);
// 忽略所有值，只发出 error
const error = source.pipe(
  mergeMap(val => {
    if (val === 4) {
      return _throw(`ERROR AT ${val}`);
    }
    return of(val);
  }),
  ignoreElements()
);
// 输出: "ERROR: ERROR AT 4"
const subscribe = error.subscribe(
  val => console.log(`NEXT: ${val}`),
  val => console.log(`ERROR: ${val}`),
  () => console.log('SECOND COMPLETE!')
);
```

### 其他资源

* [ignoreElements](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-ignoreElements) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/ignoreElements.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/ignoreElements.ts)
