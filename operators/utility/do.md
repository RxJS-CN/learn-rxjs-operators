# do / tap

#### 函数签名: `do(nextOrObserver: function, error: function, complete: function): Observable`

## Transparently perform actions or side-effects, such as logging.
## 透明地执行操作或副作用，比如打印日志。

---

:bulb: If you are using as a pipeable operator, `do` is known as `tap`!

---

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 使用 do 输出日志

(
[StackBlitz](https://stackblitz.com/edit/typescript-s1aymr?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/jimazuriva/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/qtyakorq/) )

```js
import { of } from 'rxjs/observable/of';
import { tap, map } from 'rxjs/operators';

const source = of(1, 2, 3, 4, 5);
// 使用 tap 透明地打印 source 中的值
const example = source.pipe(
  tap(val => console.log(`BEFORE MAP: ${val}`)),
  map(val => val + 10),
  tap(val => console.log(`AFTER MAP: ${val}`))
);

// 'tap' 并不转换值
// 输出: 11...12...13...14...15
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

* [do](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-do) :newspaper: - 官方文档
* [使用 do 打印流](https://egghead.io/lessons/rxjs-logging-a-stream-with-do?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
* [工具操作符: do](https://egghead.io/lessons/rxjs-utility-operator-do?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/do.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/do.ts)
