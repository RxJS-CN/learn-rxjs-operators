# forkJoin

#### 签名: `forkJoin(...args, selector : function): Observable`

## 当所有 observables 完成时，发出每个 observable 的最新值。

---

:bulb:  如果你想要多个 observables 按发出顺序相对应的值的组合，试试 [zip](zip.md)！

---

### Why use `forkJoin`?

This operator is best used when you have a group of observables and only care
about the final emitted value of each. One common use case for this is if you
wish to issue multiple requests on page load (or some other event) and only want
to take action when a response has been receieved for all. In this way it is
similar to how you might use
[`Promise.all`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all).

Be aware that if any of the inner observables supplied to `forkJoin` error you
will lose the value of any other observables that would or have already
completed if you do not [`catch`](../error_handling/catch.md) the
[error correctly on the inner observable](#example-4-getting-successful-results-when-one-innner-observable-errors).
If you are only concerned with all inner observables completing successfully you
can [catch the error on the outside](#example-3-handling-errors-on-outside).

It's also worth noting that if you have an observable that emits more than one
item, and you are concerned with the previous emissions `forkJoin` is not the
correct choice. In these cases you may better off with an operator like
[combineLatest](combinelatest.md) or [zip](zip.md).

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 发起可变数量的请求

(
[StackBlitz](https://stackblitz.com/edit/typescript-bqxg9x?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/remiduhimu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/5fj77920/81/) )

```js
// RxJS v6+
import { delay, take } from 'rxjs/operators';
import { forkJoin, of, interval } from 'rxjs';

const myPromise = val =>
  new Promise(resolve =>
    setTimeout(() => resolve(`Promise Resolved: ${val}`), 5000)
  );

/*
  当所有 observables 完成是，将每个 observable 
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

##### Example 2: Making a variable number of requests

(
[StackBlitz](https://stackblitz.com/edit/typescript-3mbbjw?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/febejakapi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/0b8Lnh7s/1/) )

```js
// RxJS v6+
import { mergeMap } from 'rxjs/operators';
import { forkJoin, of } from 'rxjs';

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

##### Example 3: Handling errors on outside

(
[StackBlitz](https://stackblitz.com/edit/typescript-xgskpm?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/gugawucixi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/6vz7tjx2/1/) )

```js
// RxJS v6+
import { delay, catchError } from 'rxjs/operators';
import { forkJoin, of, throwError } from 'rxjs';

/*
  when all observables complete, give the last
  emitted value from each as an array
*/
const example = forkJoin(
  //emit 'Hello' immediately
  of('Hello'),
  //emit 'World' after 1 second
  of('World').pipe(delay(1000)),
  // throw error
  _throw('This will error')
).pipe(catchError(error => of(error)));
//output: 'This will Error'
const subscribe = example.subscribe(val => console.log(val));
```

##### Example 4: Getting successful results when one inner observable errors

(
[StackBlitz](https://stackblitz.com/edit/typescript-hydgiu?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/memajepefe/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/emdu4doy/1/) )

```js
// RxJS v6+
import { delay, catchError } from 'rxjs/operators';
import { forkJoin, of, throwError } from 'rxjs';

/*
  when all observables complete, give the last
  emitted value from each as an array
*/
const example = forkJoin(
  //emit 'Hello' immediately
  of('Hello'),
  //emit 'World' after 1 second
  of('World').pipe(delay(1000)),
  // throw error
  _throw('This will error').pipe(catchError(error => of(error)))
);
//output: ["Hello", "World", "This will error"]
const subscribe = example.subscribe(val => console.log(val));
```

##### Example 5: forkJoin in Angular

( [plunker](https://plnkr.co/edit/ElTrOg8NfR3WbbAfjBXQ?p=preview) )

```js
@Injectable()
export class MyService {
  makeRequest(value: string, delayDuration: number) {
    // simulate http request
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
    // simulate 3 requests with different delays
    forkJoin(
      this._myService.makeRequest('Request One', 2000),
      this._myService.makeRequest('Request Two', 1000),
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

- [forkJoin](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-forkJoin) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/observable/ForkJoinObservable.ts](https://github.com/ReactiveX/rxjs/blob/master/src/observable/ForkJoinObservable.ts)
