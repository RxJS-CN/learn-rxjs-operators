# reduce

#### 签名: `reduce(accumulator: function, seed: any): Observable`

## 将源 observalbe 的值归并为单个值，当源 observable 完成时将这个值发出。

:bulb: 类似于 [`Array.prototype.reduce()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce?v=a)

:bulb: 如果每次发送时都需要当前的累加值，请使用 [scan](scan.md)!

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 数字流的加和

(
[StackBlitz](https://stackblitz.com/edit/typescript-hdsv5e?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/dakuneneho/edit?js,console) |
[jsFiddle](https://jsfiddle.net/f8fw7yka/) )

```js
// RxJS v6+
import { of } from 'rxjs';
import { reduce } from 'rxjs/operators';

const source = of(1, 2, 3, 4);
const example = source.pipe(reduce((acc, val) => acc + val));
// 输出: Sum: 10'
const subscribe = example.subscribe(val => console.log('Sum:', val));
```

### 其他资源

- [reduce](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-reduce) :newspaper: - 官方文档
- [scan() vs reduce() | RxJS 教程](https://www.youtube.com/watch?v=myEeo2rZc3g) :video_camera: - Academind

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/reduce.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/reduce.ts)
