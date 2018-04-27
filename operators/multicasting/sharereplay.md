# shareReplay

#### 函数签名: `shareReplay(bufferSize?: number, windowTime?: number, scheduler?I IScheduler): Observable`

## 共享源 observable 并重放指定次数的发出。

### 为什么使用 `shareReplay`？

通常啊，当有副作用或繁重的计算时，你不希望在多个订阅者之间重复执行时，会使用 `shareReplay` 。
当你知道流的后来订阅者也需要访问之前发出的值，`shareReplay` 在这种场景下也是有价值的。
这种在订阅过程中重放值的能力是区分 [`share`](./share.md) 和 `shareReplay` 的关键。

例如，加入你有一个发出最后访问 url 的 observable 。
在第一个示例中，我们将使用 [`share`](./share.md):

```js
// 使用 subject 模拟 url 的变化
const routeEnd = new Subject<{data: any, url: string}>();

// 提取 url 并与后来订阅者共享
const lastUrl = routeEnd.pipe(
  pluck('url'),
  share()
);

// 起始订阅者是必须的
const initialSubscriber = lastUrl.subscribe(console.log);

// 模拟路由变化
routeEnd.next({data: {}, url: 'my-path'});

// 没有任何输出
const lateSubscriber = lastUrl.subscribe(console.log);
```

上面的示例中，`lateSubscriber` 订阅源 observable 后没有任何输出。
现在我们想要访问订阅中的最新发出值，可以通过 `shareReplay` 来完成:

```js
import { Subject } from 'rxjs/Subject';
import { ReplaySubject } from 'rxjs/ReplaySubject';
import { pluck, share, shareReplay, tap } from 'rxjs/operators';

// 使用 subject 模拟 url 的变化
const routeEnd = new Subject<{data: any, url: string}>();

// 提取 url 并与后来订阅者共享
const lastUrl = routeEnd.pipe(
  tap(_ => console.log('executed')),
  pluck('url'),
  // 默认为重放最后一个值
  shareReplay()
);

// 起始订阅者是必须的
const initialSubscriber = lastUrl.subscribe(console.log);

// 模拟路由变化
// 输出: 'executed', 'my-path'
routeEnd.next({data: {}, url: 'my-path'});

// 输出: 'my-path'
const lateSubscriber = lastUrl.subscribe(console.log);
```

注意，如果使用 `ReplaySubject` 订阅 `lastUrl` 流，然后再订阅 `ReplaySubject`，
这种行为与使用 shareReplay 类似:

```js
// 使用 subject 模拟 url 的变化
const routeEnd = new Subject<{data: any, url: string}>();

// 使用 ReplaySubject 来替代 shareReplay
const shareWithReplay = new ReplaySubject();

// 取 url 并与后来订阅者共享
const lastUrl = routeEnd.pipe(
  pluck('url')
)
.subscribe(val => shareWithReplay.next(val));

// 模拟路由变化
routeEnd.next({data: {}, url: 'my-path'});

// 订阅 ReplaySubject 
// 输出: 'my path'
shareWithReplay.subscribe(console.log);
```

事实上，如果深入源码，我们可以发现两者之间使用的技术是类似的。
当订阅发生后，`shareReplay` 会订阅源 observable，并通过内部的 `ReplaySubject` 
来发送值:

(
[source](https://github.com/ReactiveX/rxjs/blob/b25db9f369b07f26cf2fc11714ec1990b78a4536/src/internal/operators/shareReplay.ts#L26-L37)
)

```js
  return function shareReplayOperation(this: Subscriber<T>, source: Observable<T>) {
    refCount++;
    if (!subject || hasError) {
      hasError = false;
      subject = new ReplaySubject<T>(bufferSize, windowTime, scheduler);
      subscription = source.subscribe({
        next(value) { subject.next(value); },
        error(err) {
          hasError = true;
          subject.error(err);
        },
        complete() {
          isComplete = true;
          subject.complete();
        },
      });
    }


    const innerSub = subject.subscribe(this);


    return () => {
      refCount--;
      innerSub.unsubscribe();
      if (subscription && refCount === 0 && isComplete) {
        subscription.unsubscribe();
      }
    };
  };
}
```

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 多个订阅者共享源 observable

( [Stackblitz](https://stackblitz.com/edit/typescript-qfhryg?file=index.ts&devtoolsheight=50) )

```js
import { Subject } from 'rxjs/Subject';
import { ReplaySubject } from 'rxjs/ReplaySubject';
import { pluck, share, shareReplay, tap } from 'rxjs/operators';

// 使用 subject 模拟 url 的变化
const routeEnd = new Subject<{data: any, url: string}>();
// 提取 url 并与后来订阅者共享
const lastUrl = routeEnd.pipe(
  tap(_ => console.log('executed')),
  pluck('url'),
  // 默认为重放最后一个值
  shareReplay()
);
// 起始订阅者是必须的
const initialSubscriber = lastUrl.subscribe(console.log)
// 模拟路由变化
// 输出: 'executed', 'my-path'
routeEnd.next({data: {}, url: 'my-path'});
// 输出: 'my-path'
const lateSubscriber = lastUrl.subscribe(console.log);
```

### 其他资源

* [shareReplay](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-shareReplay)
  :newspaper: - 官方文档

---

> :file_folder: 源码:
> [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/shareReplay.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/shareReplay.ts)
