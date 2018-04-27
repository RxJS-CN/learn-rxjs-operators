# race

#### 签名: `race(): Observable`

## 使用首先发出值的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 4个 observables 进行 race

( [StackBlitz](https://stackblitz.com/edit/typescript-cuzgkn?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/goqiwobeno/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8jcmb1ec/) )

```js
import { mapTo } from 'rxjs/operators';
import { interval } from 'rxjs/observable/interval';
import { race } from 'rxjs/observable/race';

// 接收第一个发出值的 observable
const example = race(
  // 每1.5秒发出值
  interval(1500),
  // 每1秒发出值
  interval(1000).pipe(mapTo('1s won!')),
  // 每2秒发出值
  interval(2000),
  // 每2.5秒发出值
  interval(2500)
);
// 输出: "1s won!"..."1s won!"...etc
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 使用 error 进行 race

( [StackBlitz](https://stackblitz.com/edit/typescript-ptcwjp?file=index.ts&devtoolsheight=50) |
[jsFiddle](https://jsfiddle.net/gbeL4t55/2/) )

```js
import { delay, map } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';
import { race } from 'rxjs/observable/race';

// 抛出错误并忽略其他的 observables 。
const first = of('first').pipe(
  delay(100),
  map(_ => {
    throw 'error';
  })
);
const second = of('second').pipe(delay(200));
const third = of('third').pipe(delay(300));

race(first, second, third).subscribe(val => console.log(val));
```

### 其他资源

* [race](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-race) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/race.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/race.ts)
