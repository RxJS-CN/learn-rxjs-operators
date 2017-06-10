# retry

#### 签名: `retry(number: number): Observable`

## 如果发生错误，以指定次数重试 observable 序列。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 出错的话可以重试2次

( [jsBin](http://jsbin.com/yovacuxuqa/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/hg7z16bo/) )

```js
import { interval } from 'rxjs/observable/interval';
import { of } from 'rxjs/observable/of';
import { _throw } from 'rxjs/observable/throw';
import { mergeMap, retry } 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
const example = source.pipe(
  mergeMap(val => {
    // 抛出错误以进行演示
    if (val > 5) {
      return _throw('Error!');
    }
    return of(val);
  }),
  // 出错的话可以重试2次
  retry(2)
);
/*
  输出:
  0..1..2..3..4..5..
  0..1..2..3..4..5..
  0..1..2..3..4..5..
  "Error!: Retried 2 times then quit!"
*/
const subscribe = example.subscribe({
  next: val => console.log(val),
  error: val => console.log(`${val}: Retried 2 times then quit!`)
});
```

### 其他资源

* [retry](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-retry) :newspaper: - 官方文档
* [错误处理操作符: retry 和 retryWhen](https://egghead.io/lessons/rxjs-error-handling-operator-retry-and-retrywhen?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/retry.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/retry.ts)
