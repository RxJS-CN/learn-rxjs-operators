# retryWhen

#### 函数签名: `retryWhen(receives: (errors: Observable) => Observable, the: scheduler): Observable`

## 当发生错误时，基于自定义的标准来重试 observable 序列。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 在指定的时间间隔后触发重试

(
[StackBlitz](https://stackblitz.com/edit/typescript-zpbsw6?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/miduqexalo/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/49mkhsyr/) )

```js
// RxJS v6+
import { timer, interval } from 'rxjs';
import { map, tap, retryWhen, delayWhen } from 'rxjs/operators';

// 每1秒发出值
const source = interval(1000);
const example = source.pipe(
  map(val => {
    if (val > 5) {
      // 错误将由 retryWhen 接收
      throw val;
    }
    return val;
  }),
  retryWhen(errors =>
    errors.pipe(
      // 输出错误信息
      tap(val => console.log(`Value ${val} was too high!`)),
      // 5秒后重启
      delayWhen(val => timer(val * 1000))
    )
  )
);
/*
  输出:
  0
  1
  2
  3
  4
  5
  "Value 6 was too high!"
  --等待5秒后然后重复此过程
*/
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 时间间隔增加的自定义重试

(
[StackBlitz](https://stackblitz.com/edit/angular-cwnknr?file=app%2Frxjs-utils.ts)
)

```js
import { Observable, _throw, timer } from 'rxjs';
import { mergeMap, finalize } from 'rxjs/operators';

export const genericRetryStrategy = ({
  maxRetryAttempts = 3,
  scalingDuration = 1000,
  excludedStatusCodes = []
}: {
  maxRetryAttempts?: number,
  scalingDuration?: number,
  excludedStatusCodes?: number[]
} = {}) => (attempts: Observable<any>) => {
  return attempts.pipe(
    mergeMap((error, i) => {
      const retryAttempt = i + 1;
      // 如果达到最大重试次数或响应的状态码
      // 不是我们想重试的，就抛出错误
      if (
        retryAttempt > maxRetryAttempts ||
        excludedStatusCodes.find(e => e === error.status)
      ) {
        return _throw(error);
      }
      console.log(
        `Attempt ${retryAttempt}: retrying in ${retryAttempt *
          scalingDuration}ms`
      );
      // 重试的时间间隔不断增长: 1秒、2秒，以此类推
      return timer(retryAttempt * scalingDuration);
    }),
    finalize(() => console.log('We are done!'))
  );
};
```

```js
import { Component, OnInit } from '@angular/core';
import { catchError, retryWhen  } from 'rxjs/operators';
import { of } from 'rxjs';
import { genericRetryStrategy } from './rxjs-utils';
import { AppService } from './app.service';

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: [ './app.component.css' ]
})
export class AppComponent implements OnInit  {
  constructor(private _appService: AppService) {}

  ngOnInit() {
    this._appService
      .getData(500)
      .pipe(
        retryWhen(genericRetryStrategy()),
        catchError(error => of(error))
      )
      .subscribe(console.log);

    // 排除状态码，增加延迟以保持日志清晰
    setTimeout(() => {
    this._appService
      .getData(500)
      .pipe(
        retryWhen(genericRetryStrategy({
          scalingDuration: 2000,
          excludedStatusCodes: [500]
        })),
        catchError(error => of(error))
      )
      .subscribe(e => console.log('Exluded code:', e.status));

    }, 8000);
  }
}
```

### 其他资源

- [retryWhen](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-retryWhen) :newspaper: - 官方文档
- [错误处理操作符: retry 和 retryWhen](https://egghead.io/lessons/rxjs-error-handling-operator-retry-and-retrywhen?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/retryWhen.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/retryWhen.ts)
