# toPromise

#### 签名: `toPromise() : Promise`

## 将 observable 转换成 promise 。

<div class="ua-ad"><div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div></div>

### 示例

##### 示例 1: 基础的 Promise

( [jsBin](http://jsbin.com/favoqecixi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/thykc9up/) )

```js
import { of } from 'rxjs/observable/of';
import { toPromise, delay } from 'rxjs/operators';

// 返回基础的 observable
const sample = val => of(val).pipe(delay(5000));
// 将基础的 observable 转换成 promise
const example = sample('First Example')
  .pipe(toPromise())
  // 输出: 'First Example'
  .then(result => {
    console.log('From Promise:', result);
  });
```

##### 示例 2: 使用 Promise.all

( [jsBin](http://jsbin.com/hutiyicaco/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/xzu6u7hs/) )

```js
import { of } from 'rxjs/observable/of';
import { delay } from 'rxjs/operators';

// 返回基础的 observable
const sample = val => of(val).pipe(delay(5000));
/*
  将每个 observable 转换成 promise 并使用 Promise.all 
  来等待所有 promise 解析完成
  (you should probably use forkJoin and no 'toPromise' instead!)
*/
const example = () => {
  return Promise.all([
    sample('Promise 1').pipe(toPromise()),
    sample('Promise 2').pipe(toPromise())
  ]);
}
// 输出: ["Promise 1", "Promise 2"]
example().then(val => {
  console.log('Promise.all Result:', val);
});
```

### 其他资源

* [toPromise](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-toPromise) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/toPromise.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/toPromise.ts)
