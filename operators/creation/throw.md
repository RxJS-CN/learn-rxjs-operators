# throw

#### 函数签名: `throw(error: any, scheduler: Scheduler): Observable`

## 在订阅上发出错误

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 在订阅上抛出错误

(
[StackBlitz](https://stackblitz.com/edit/typescript-5d3stz?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/punubequju/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/mks82xqz/) )

```js
// RxJS v6+
import { throwError } from 'rxjs';

// 在订阅上使用指定值来发出错误
const source = throwError('This is an error!');
// 输出: 'Error: This is an error!'
const subscribe = source.subscribe({
  next: val => console.log(val),
  complete: () => console.log('Complete!'),
  error: val => console.log(`Error: ${val}`)
});
```

### 相关示例

- [3次重试后抛出错误](../error_handling/retrywhen.md)

### 其他资源

### 其他资源

- [throw](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-throw) :newspaper: - 官方文档
- [创建操作符: empty, never 和 throw](https://egghead.io/lessons/rxjs-creation-operators-empty-never-throw?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

> :file_folder: 源码:
> [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/throwError.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/throwError.ts)
