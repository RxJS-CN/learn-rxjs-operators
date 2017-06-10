# range

#### 签名: `range(start: number, count: number, scheduler: Scheduler): Observable`

## 依次发出给定区间内的数字。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 发出1-10的区间值

( [jsBin](http://jsbin.com/yalefomage/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/cfvfgwn9/) )

```js
import { range } from 'rxjs/observable/range';

// 依次发出1-10
const source = range(1, 10);
// 输出: 1,2,3,4,5,6,7,8,9,10
const example = source.subscribe(val => console.log(val));
```

### 其他资源

* [range](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-range) :newspaper: - 官方文档

---

> :file_folder: 源码:
> [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/range.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/range.ts)
