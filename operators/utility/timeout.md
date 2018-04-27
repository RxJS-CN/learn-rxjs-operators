# timeout

#### 函数签名: `timeout(due: number, scheduler: Scheduler): Observable`

## 在指定时间间隔内不发出值就报错

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 2.5秒后超时

(
[StackBlitz](https://stackblitz.com/edit/typescript-gl1hhr?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/gonakiniho/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/nr4e1ofy/1/) )

```js
import { of } from 'rxjs/observable/of';
import { concatMap, timeout, catchError, delay } from 'rxjs/operators';

// 模拟请求
function makeRequest(timeToDelay) {
  return of('Request Complete!').pipe(delay(timeToDelay));
}

of(4000, 3000, 2000)
  .pipe(
    concatMap(duration =>
      makeRequest(duration).pipe(
        timeout(2500),
        catchError(error => of(`Request timed out after: ${duration}`))
      )
    )
  )
  /*
    *  "Request timed out after: 4000"
    *  "Request timed out after: 3000"
    *  "Request Complete!"
    */
  .subscribe(val => console.log(val));
```

### 其他资源

* [timeout](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/api/core/operators/timeout.md)
  :newspaper: - 官方文档

---

> :file_folder: 源码:
> [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/timeout.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/timeout.ts)
