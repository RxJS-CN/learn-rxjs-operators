# race

#### 函数签名: `race(): Observable`

## 使用首先发出值的 observable 。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 使用 4个 observables 进行 race

(
[StackBlitz](https://stackblitz.com/edit/typescript-cvfmug?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/goqiwobeno/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/8jcmb1ec/) )

```js
// RxJS v6+
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

(
[StackBlitz](https://stackblitz.com/edit/typescript-in6fw6?file=index.ts&devtoolsheight=100)
| [jsFiddle](https://jsfiddle.net/gbeL4t55/2/) )

```js
// RxJS v6+
import { delay, map } from 'rxjs/operators';
import { of, race } from 'rxjs';

// 抛出错误并忽略其他的 observables 。
const first = of('first').pipe(
  delay(100),
  map(_ => {
    throw 'error';
  })
);
const second = of('second').pipe(delay(200));
const third = of('third').pipe(delay(300));
// nothing logged
race(first, second, third).subscribe(val => console.log(val));
```

### 其他资源

- [race](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-race) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/race.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/race.ts)
