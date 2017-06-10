# skipUntil

#### 签名: `skipUntil(the: Observable): Observable`

## 跳过源 observable 发出的值，直到提供的 observable 发出值。

### 示例

##### 示例 1: 跳过值直到另个 observable 发出值

( [jsBin](http://jsbin.com/tapizososu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/xLu8nf77/) )

```js
import { interval } from 'rxjs/observable/interval';
import { timer } from 'rxjs/observable/timer';
import { skipUntil } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 跳过源 observable 发出的值，直到内部 observable 发出值 (6s后)
const example = source.pipe(skipUntil(timer(6000)));
// 输出: 5...6...7...8........
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [skipUntil](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-skipUntil) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skipUntil.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skipUntil.ts)
