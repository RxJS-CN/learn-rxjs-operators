# let

#### 签名: `let(function): Observable`

## 让我拥有完整的 observable 。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 let 重用错误处理逻辑

( [jsBin](http://jsbin.com/rosuborara/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/qtq1h8vw/) )

```js
// 自定义错误处理逻辑
const retryThreeTimes = obs =>
  obs.retry(3).catch(_ => Rx.Observable.of('ERROR!'));
const examplePromise = val =>
  new Promise(resolve => resolve(`Complete: ${val}`));

// 伪造的请求
const subscribe = Rx.Observable.of('some_url')
  .mergeMap(url => examplePromise(url))
  // 能够在使用 let 的多个地方重用错误处理逻辑
  .let(retryThreeTimes)
  // 输出: Complete: some_url
  .subscribe(result => console.log(result));

const customizableRetry = retryTimes => obs =>
  obs.retry(retryTimes).catch(_ => Rx.Observable.of('ERROR!'));

// 伪造的请求
const secondSubscribe = Rx.Observable.of('some_url')
  .mergeMap(url => examplePromise(url))
  // 能够在使用 let 的多个地方重用错误处理逻辑
  .let(customizableRetry(3))
  // 输出: Complete: some_url
  .subscribe(result => console.log(result));
```

##### 示例 2: 使用 let 应用于 map

( [jsBin](http://jsbin.com/jiyupaxomo/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6n7w3b22/) )

```js
// 将数组作为序列发出
const source = Rx.Observable.from([1, 2, 3, 4, 5]);
// 演示 let 和其他操作符间的区别
const test = source
  .map(val => val + 1)
  /*
    取消下面一行的注释会导致失败，let 的行为不同于大多数操作符
    val 在这里是 observable
    */
  //.let(val => val + 2)
  .subscribe(val => console.log('VALUE FROM ARRAY: ', val));

const subscribe = source
  .map(val => val + 1)
  // 'let' 会让你拥有整个的 observable 
  .let(obs => obs.map(val => val + 2))
  // 输出: 4,5,6,7,8
  .subscribe(val => console.log('VALUE FROM ARRAY WITH let: ', val));
```

##### 示例 3: 使用 let 应用于多个操作符

( [jsBin](http://jsbin.com/zamizapaho/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/gxsq1woc/) )

```js
// 将数组作为序列发出
const source = Rx.Observable.from([1, 2, 3, 4, 5]);

// let 提供了灵活性，可以将多个操作符添加到源 observale，然后返回
const subscribeTwo = source
  .map(val => val + 1)
  .let(obs =>
    obs
      .map(val => val + 2)
      // 还可以只返回偶数
      .filter(val => val % 2 === 0)
  )
  // 输出: 4,6,8
  .subscribe(val => console.log('let WITH MULTIPLE OPERATORS: ', val));
```

##### 示例 4: 通过函数应用于操作符

( [jsBin](http://jsbin.com/vojelelamu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/ah09dL9e/) )

```js
// 将数组作为序列发出
const source = Rx.Observable.from([1, 2, 3, 4, 5]);
 
// 传入你自己的函数来将操作符添加到 observable 
const obsArrayPlusYourOperators = yourAppliedOperators => {
  return source.map(val => val + 1).let(yourAppliedOperators);
};
const addTenThenTwenty = obs => obs.map(val => val + 10).map(val => val + 20);
const subscribe = obsArrayPlusYourOperators(addTenThenTwenty)
	// 输出: 32, 33, 34, 35, 36
	.subscribe(val => console.log('let FROM FUNCTION:', val));
```

### 其他资源

* [let](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/api/core/operators/let.md) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/let.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/let.ts)
