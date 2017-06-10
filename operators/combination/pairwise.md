# pairwise

#### 签名: `pairwise(): Observable<Array>`

## 将前一个值和当前值作为数组发出

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1:

(
[StackBlitz](https://stackblitz.com/edit/typescript-tkuydr?file=index.ts&devtoolsheight=50)
| [jsBin](http://jsbin.com/keteyahido/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8va47bq3/) )

```js
// RxJS v6+
import { pairwise, take } from 'rxjs/operators';
import { interval } from 'rxjs';

// 返回: [0,1], [1,2], [2,3], [3,4], [4,5]
interval(1000)
  .pipe(
    pairwise(),
    take(5)
  )
  .subscribe(console.log);
```

### 其他资源

- [pairwise](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-pairwise) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pairwise.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pairwise.ts)
