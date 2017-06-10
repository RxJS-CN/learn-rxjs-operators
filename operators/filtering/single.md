# single

#### 签名: `single(a: Function): Observable`

## 发出通过表达式的单一项。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 发出通过断言的第一个数字

( [jsBin](http://jsbin.com/solecibuza/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/26r5y90s/) )

```js
import { from } from 'rxjs/observable/from';
import { single } 'rxjs/operators';

// 发出 (1,2,3,4,5)
const source = from([1, 2, 3, 4, 5]);
// 发出匹配断言函数的一项
const example = source.pipe(single(val => val === 4));
// 输出: 4
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [single](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-single) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/single.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/single.ts)
