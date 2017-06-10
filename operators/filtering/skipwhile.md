# skipWhile

#### 签名: `skipWhile(predicate: Function): Observable`

## 跳过源 observable 发出的值，直到提供的表达式结果为 false 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 当值小于阈值的时候跳过

( [jsBin](http://jsbin.com/bemikuleya/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/3ymfxb09/) )

```js
import { interval } from 'rxjs/observable/interval';
import { skipWhile } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
// 当源 observable 发出的值小于5的时候，则跳过该值
const example = source.pipe(skipWhile(val => val < 5));
// 输出: 5...6...7...8........
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [skipWhile](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-skipWhile) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skipWhile.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/skipWhile.ts)
