# bufferCount

#### 签名: `bufferCount(bufferSize: number, startBufferEvery: number = null): Observable`

## 收集发出的值，直到收集完提供的数量的值才将其作为数组发出。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 收集缓冲区并在指定数量的值后发出

( [StackBlitz](https://stackblitz.com/edit/typescript-8qxfpn?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/suveqaromu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ky9myc5b/) )

```js
import { interval } from 'rxjs/observable/interval';
import { bufferCount } from 'rxjs/operators';

// 创建每1秒发出值的 observable
const source = interval(1000);
// 在发出3个值后，将缓冲的值作为数组传递
const bufferThree = source.pipe(bufferCount(3));
// 打印值到控制台
// 输出: [0,1,2]...[3,4,5]
const subscribe = bufferThree.subscribe(val =>
  console.log('Buffered Values:', val)
);
```

##### 示例 2: 重叠的缓冲

( [StackBlitz](https://stackblitz.com/edit/typescript-1otlmo?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/kiloxiraya/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/3c67qcz1/) )

```js
import { interval } from 'rxjs/observable/interval';
import { bufferCount } from 'rxjs/operators';

// 创建每1秒发出值的 observable
const source = interval(1000);
/*
  bufferCount 还接受第二个参数，何时开启下一个缓冲区
  举例来说，如果第一个参数(bufferSize)是3，而第二个参数(startBufferEvery)是1:
  第一次 interval 的值:
  buffer 1: [0]
  第2次 interval 的值:
  buffer 1: [0,1]
  buffer 2: [1]
  第3次 interval 的值:
  buffer 1: [0,1,2] 缓冲数量已达到3，发出缓冲区
  buffer 2: [1,2]
  buffer 3: [2]
  第4次 interval 的值:
  buffer 2: [1,2,3] 缓冲数量已达到3，发出缓冲区
  buffer 3: [2, 3]
  buffer 4: [3]
*/
const bufferEveryOne = source.pipe(bufferCount(3, 1));
// 打印值到控制台
const subscribe = bufferEveryOne.subscribe(val =>
  console.log('Start Buffer Every 1:', val)
);
```

### 其他资源

* [bufferCount](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-bufferCount) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferCount.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/bufferCount.ts)
