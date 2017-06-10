# exhaustMap

#### 签名: `exhaustMap(project: function, resultSelector: function): Observable`

## 映射成内部 observable，忽略其他值直到该 observable 完成。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 interval 的 exhaustMap 

( [Stackblitz](https://stackblitz.com/edit/typescript-3qydhn?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/woposeqobo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/9ovzapp9/) )

```js
// RxJS v6+
import { interval, merge, of } from 'rxjs';
import { delay, take, exhaustMap } from 'rxjs/operators';

const sourceInterval = interval(1000);
const delayedInterval = sourceInterval.pipe(delay(10), take(4));

const exhaustSub = merge(
  // 延迟10毫秒，然后开始 interval 并发出4个值
  delayedInterval,
  // 立即发出
  of(true)
)
  .pipe(exhaustMap(_ => sourceInterval.pipe(take(5))))
  /*
   *  第一个发出的值 (of(true)) 会被映射成每秒发出值、 
   *  5秒后完成的 interval observable 。
   *  因为 delayedInterval 的发送是晚于前者的，虽然 observable 
   *  仍然是活动的，但它们会被忽略。
   *
   *  与类似的操作符进行下对比:
   *  concatMap 会进行排队
   *  switchMap 会在每次发送时切换成新的内部 observable
   *  mergeMap 会为每个发出值维护新的 subscription
   */
  // 输出: 0, 1, 2, 3, 4
  .subscribe(val => console.log(val));
```

##### 示例 2: 另一个使用 interval 的 exhaustMap 

( [Stackblitz](https://stackblitz.com/edit/typescript-vxussb?file=index.ts&devtoolsheight=100) |
[jsBin](http://jsbin.com/fizuduzuti/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/5ck8yg5k/3/) )

```js
// RxJS v6+
import { interval } from 'rxjs';
import { exhaustMap, tap, take } from 'rxjs/operators';

const firstInterval = interval(1000).pipe(take(10));
const secondInterval = interval(1000).pipe(take(2));

const exhaustSub = firstInterval
  .pipe(
    exhaustMap(f => {
      console.log(`Emission Corrected of first interval: ${f}`);
      return secondInterval;
    })
  )
  /*
    当我们订阅第一个 interval 时，它开始发出值(从0开始)。
    这个值会映射成第二个 interval，然后它开始发出值(从0开始)。
    当第二个 interval 出于激活状态时，第一个 interval 的值会被忽略。
    我们可以看到 firstInterval 发出的数字为3，6，等等...

    输出:
    Emission of first interval: 0
    0
    1
    Emission of first interval: 3
    0
    1
    Emission of first interval: 6
    0
    1
    Emission of first interval: 9
    0
    1
*/
  .subscribe(s => console.log(s));
```

### Outside Examples

##### `exhaustMap` for login effect in [@ngrx example app](https://github.com/ngrx/platform/tree/a9e522953832b09bb329bac4524637bc608c450a/example-app)

(
[Source](https://github.com/ngrx/platform/blob/a9e522953832b09bb329bac4524637bc608c450a/example-app/app/auth/effects/auth.effects.ts#L18-L30)
)

```js
@Effect()
  login$ = this.actions$.pipe(
    ofType(AuthActionTypes.Login),
    map((action: Login) => action.payload),
    exhaustMap((auth: Authenticate) =>
      this.authService
        .login(auth)
        .pipe(
          map(user => new LoginSuccess({ user })),
          catchError(error => of(new LoginFailure(error)))
        )
    )
  );
```

### 其他资源

* [exhaustMap](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-exhaustMap) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/exhaustMap.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/exhaustMap.ts)
