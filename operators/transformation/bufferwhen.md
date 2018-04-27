# bufferWhen

#### 函数签名: `bufferWhen(closingSelector: function): Observable`

## 收集值，直到关闭选择器发出值才发出缓冲的值。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 发出基于 interval 缓冲的值

( [StackBlitz](https://stackblitz.com/edit/typescript-mn6za1?file=index.ts&devtoolsheight=50) | [jsBin](http://jsbin.com/vugerupube/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/nr9agfuL/) )

```js
import { interval } from 'rxjs/observable/interval';
import { bufferWhen } from 'rxjs/operators';

// 每1秒发出值
const oneSecondInterval = interval(1000);
// 返回的 observable 每5秒发出值
const fiveSecondInterval = () => interval(5000);
// 每5秒发出缓冲的值
const bufferWhenExample = oneSecondInterval.pipe(bufferWhen(fiveSecondInterval));
// 输出值
// 输出: [0,1,2,3]...[4,5,6,7,8]
const subscribe = bufferWhenExample.subscribe(val =>
  console.log('Emitted Buffer: ', val)
);
```

### 其他资源

* [bufferWhen](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-bufferWhen) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferWhen.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferWhen.ts)
