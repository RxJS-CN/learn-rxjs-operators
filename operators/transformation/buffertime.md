# bufferTime

#### 签名: `bufferTime(bufferTimeSpan: number, bufferCreationInterval: number, scheduler: Scheduler): Observable`

## 收集发出的值，直到经过了提供的时间才将其作为数组发出。

### 示例

##### 示例 1: 缓冲2秒

( [StackBlitz](https://stackblitz.com/edit/typescript-haqxd1?file=index.ts&devtoolsheight=50) | [jsBin](http://jsbin.com/bafakiyife/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/vx7vwg01/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { bufferTime } from 'rxjs/operators';

// 创建每500毫秒发出值的 observable
const source = interval(500);
// 2秒后，将缓冲值作为数组发出
const example = source.pipe(bufferTime(2000));
// 打印值到控制台
// 输出: [0,1,2]...[3,4,5,6]
const subscribe = example.subscribe(val =>
  console.log('Buffered with Time:', val)
);
```

##### 示例 2: 多个有效的缓冲区

( [StackBlitz](https://stackblitz.com/edit/typescript-9blquz?file=index.ts&devtoolsheight=100) | [jsBin](http://jsbin.com/tadiwiniri/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/7k4ygj1x/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { bufferTime } from 'rxjs/operators';

// 创建每500毫秒发出值的 observable
const source = interval(500);
/*
  bufferTime 还接受第二个参数，何时开始下一个缓冲区(时间单位为毫秒)
  举例来说，如果第一个参数(bufferTimeSpan)是2秒，而第二个参数(bufferCreationInterval)是1秒:
*/
const example = source.pipe(bufferTime(2000, 1000));
// 打印值到控制台
const subscribe = example.subscribe(val =>
  console.log('Start Buffer Every 1s:', val)
);
```

### 其他资源

- [bufferTime](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-bufferTime) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferTime.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferTime.ts)
