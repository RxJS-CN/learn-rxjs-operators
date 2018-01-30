# forkJoin

#### 签名: `forkJoin(...args, selector : function): Observable`

## 当所有 observables 完成时，发出每个 observable 的最新值。

---

:bulb:  如果你想要多个 observables 按发出顺序相对应的值的组合，试试 [zip](zip.md)！

:warning: 如果内部 observable 不完成的话，`forkJoin` 永远不会发出值！

---

### 为什么使用 `forkJoin`？

当有一组 observables，但你只关心每个 observable 最后发出的值时，此操作符是最适合的。此操作符的一个常见用例是在页面加载(或其他事件)时你希望发起多个请求，并在所有请求都响应后再采取行动。它可能与 [`Promise.all`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all) 的使用方式类似。

注意，如果任意作用于 `forkJoin` 的内部 observable 报错的话，对于那些在内部 observable 上没有正确 [`catch`](../error_handling/catch.md) 错误，从而导致完成的 observable，你将丢失它们的值 (参见示例 4)。如果你只关心所有内部 observables 是否成功完成的话，可以[在外部捕获错误](#%E5%9C%A8%E5%A4%96%E9%83%A8%E5%A4%84%E7%90%86%E9%94%99%E8%AF%AF)。

还需要注意的是如果 observable 发出的项多于一个的话，并且你只关心前一个发出的话，那么 `forkJoin` 并非正确的选择。在这种情况下，应该选择像 [combineLatest](combinelatest.md) 或 [zip](zip.md) 这样的操作符。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: Observables 再不同的时间间隔后完成

( [StackBlitz](https://stackblitz.com/edit/typescript-2qr3qi?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/remiduhimu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/5fj77920/81/) )

```js
import { delay, take } from 'rxjs/operators';
import { forkJoin } from 'rxjs/observable/forkJoin';
import { of } from 'rxjs/observable/of';
import { interval } from 'rxjs/observable/interval';

const myPromise = val =>
  new Promise(resolve =>
    setTimeout(() => resolve(`Promise Resolved: ${val}`), 5000)
  );

/*
  当所有 observables 完成时，将每个 observable 
  的最新值作为数组发出
*/
const example = forkJoin(
  // 立即发出 'Hello'
  of('Hello'),
  // 1秒后发出 'World'
  of('World').pipe(delay(1000)),
  // 1秒后发出0
  interval(1000).pipe(take(1)),
  // 以1秒的时间间隔发出0和1
  interval(1000).pipe(take(2)),
  // 5秒后解析 'Promise Resolved' 的 promise
  myPromise('RESULT')
);
//输出: ["Hello", "World", 0, 1, "Promise Resolved: RESULT"]
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 发起任意多个请求

( [StackBlitz](https://stackblitz.com/edit/typescript-uxbl41?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/febejakapi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/0b8Lnh7s/1/) )

```js
import { mergeMap } from 'rxjs/operators';
import { forkJoin } from 'rxjs/observable/forkJoin';
import { of } from 'rxjs/observable/of';

const myPromise = val =>
  new Promise(resolve =>
    setTimeout(() => resolve(`Promise Resolved: ${val}`), 5000)
  );

const source = of([1, 2, 3, 4, 5]);
// 发出数组的全部5个结果
const example = source.pipe(mergeMap(q => forkJoin(...q.map(myPromise))));
/*
  输出:
  [
   "Promise Resolved: 1",
   "Promise Resolved: 2",
   "Promise Resolved: 3",
   "Promise Resolved: 4",
   "Promise Resolved: 5"
  ]
*/
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 3: 在外部处理错误

( [StackBlitz](https://stackblitz.com/edit/typescript-3fgrkn?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/gugawucixi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6vz7tjx2/1/) )

```js
import { delay, catchError } from 'rxjs/operators';
import { forkJoin } from 'rxjs/observable/forkJoin';
import { of } from 'rxjs/observable/of';
import { _throw } from 'rxjs/observable/throw';

/*
  当所有 observables 完成时，将每个 observable 
  的最新值作为数组发出
*/
const example = forkJoin(
  // 立即发出 'Hello'
  of('Hello'),
  // 1秒后发出 'World'
  of('World').pipe(delay(1000)),
  // 抛出错误
  _throw('This will error')
).pipe(catchError(error => of(error)));
// 输出: 'This will Error'
const subscribe = example.subscribe(val => console.log(val));
```

##### Example 4: Getting successful results when one inner observable errors

( [StackBlitz](https://stackblitz.com/edit/typescript-z2nedm?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/memajepefe/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/emdu4doy/1/) )

```js
import { delay, catchError } from 'rxjs/operators';
import { forkJoin } from 'rxjs/observable/forkJoin';
import { of } from 'rxjs/observable/of';
import { _throw } from 'rxjs/observable/throw';

/*
  当所有 observables 完成时，将每个 observable 
  的最新值作为数组发出
*/
const example = forkJoin(
  // 立即发出 'Hello'
  of('Hello'),
  // 1秒后发出 'World'
  of('World').pipe(delay(1000)),
  // 抛出错误
  _throw('This will error').pipe(catchError(error => of(error)))
);
// 输出: ["Hello", "World", "This will error"]
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 5: Angular 中的 forkJoin

( [plunker](https://plnkr.co/edit/ElTrOg8NfR3WbbAfjBXQ?p=preview) )

```js
@Injectable()
export class MyService {
  makeRequest(value: string, delayDuration: number) {
    // 模拟 http 请求
    return of(`Complete: ${value}`).pipe(
      delay(delayDuration)
    );
  }
}

@Component({
  selector: 'my-app',
  template: `
    <div>
      <h2>forkJoin Example</h2>
      <ul>
        <li> {{propOne}} </li>
        <li> {{propTwo}} </li>
        <li> {{propThree}} </li>
      </ul>
    </div>
  `,
})
export class App {
  public propOne: string;
  public propTwo: string;
  public propThree: string;
  constructor(private _myService: MyService) {}

  ngOnInit() {
    // 使用不同的延迟模拟3个请求
    forkJoin(
      this._myService.makeRequest('Request One', 2000),
      this._myService.makeRequest('Request Two', 1000)
      this._myService.makeRequest('Request Three', 3000)
    )
    .subscribe(([res1, res2, res3]) => {
      this.propOne = res1;
      this.propTwo = res2;
      this.propThree = res3;
    });
  }
}
```

### 其他资源

* [forkJoin](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-forkJoin) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/observable/ForkJoinObservable.ts](https://github.com/ReactiveX/rxjs/blob/master/src/observable/ForkJoinObservable.ts)
