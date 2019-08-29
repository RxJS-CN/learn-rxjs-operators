# dematerialize

#### 函数签名: `dematerialize(): Observable`

## 将 notification 对象转换成 notification 值。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 将 notifications 转换成值。

(
[StackBlitz](https://stackblitz.com/edit/typescript-bxdwbg?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/vafedocibi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/jw08mouy/) )

```js
// RxJS v6+
import { from, Notification } from 'rxjs';
import { dematerialize } from 'rxjs/operators';

// 发出 next 和 error 通知
const source = from([
  Notification.createNext('SUCCESS!'),
  Notification.createError('ERROR!')
]).pipe(
  // 将 notification 对象转换成 notification 值
  dematerialize()
)

// 输出: 'NEXT VALUE: SUCCESS' 'ERROR VALUE: 'ERROR!'
const subscription = source.subscribe({
  next: val => console.log(`NEXT VALUE: ${val}`),
  error: val => console.log(`ERROR VALUE: ${val}`)
});
```

### 其他资源

- [dematerialize](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-dematerialize) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/demterialize.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/dematerialize.ts)
