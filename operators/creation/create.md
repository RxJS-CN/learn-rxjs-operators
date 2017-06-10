# create

#### 签名: `create(subscribe: function)`

## 使用给定的订阅函数来创建 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 发出多个值的 observable

( [jsBin](http://jsbin.com/qorugiwaba/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/td5107he/) )

```js
import { Observable } from 'rxjs/Observable';
/*
  创建在订阅函数中发出 'Hello' 和 'World' 的 observable 。
*/
const hello = Observable.create(function(observer) {
  observer.next('Hello');
  observer.next('World');
});

// 输出: 'Hello'...'World'
const subscribe = hello.subscribe(val => console.log(val));
```

##### 示例 2: 基于定时器发出偶数的 observable

( [jsBin](http://jsbin.com/lodilohate/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/vtozg6uf/) )

```js
import { Observable } from 'rxjs/Observable';

/*
  每秒自增值并且只发出偶数
*/
const evenNumbers = Observable.create(function(observer) {
  let value = 0;
  const interval = setInterval(() => {
    if (value % 2 === 0) {
      observer.next(value);
    }
    value++;
  }, 1000);

  return () => clearInterval(interval);
});
// 输出: 0...2...4...6...8
const subscribe = evenNumbers.subscribe(val => console.log(val));
// 10秒后取消订阅
setTimeout(() => {
  subscribe.unsubscribe();
}, 10000);
```


### 其他资源

* [create](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-create) :newspaper: - 官方文档
* [创建操作符: Create()](https://egghead.io/lessons/rxjs-creation-operator-create?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz
* [使用 Observable.create 来实现细粒度的控制](https://egghead.io/lessons/rxjs-using-observable-create-for-fine-grained-control) :video_camera: :dollar: - Shane Osbourne

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/GenerateObservable.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/GenerateObservable.ts)
