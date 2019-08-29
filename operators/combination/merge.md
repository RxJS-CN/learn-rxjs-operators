# merge

#### 函数签名: `merge(input: Observable): Observable`

## 将多个 observables 转换成单个 observable 。

---

:bulb:  此操作符可以既有静态方法，又有实例方法！

:bulb:  如果产生值的顺序是首要考虑的，那么试试用 [concat](concat.md) 来代替！

---

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 使用静态方法合并多个 observables 

(
[StackBlitz](https://stackblitz.com/edit/typescript-ohq6rx?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/conufujapi/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/qvq9dscu/) )

```js
// RxJS v6+
import { mapTo } from 'rxjs/operators';
import { interval, merge } from 'rxjs';

// 每2.5秒发出值
const first = interval(2500);
// 每2秒发出值
const second = interval(2000);
// 每1.5秒发出值
const third = interval(1500);
// 每1秒发出值
const fourth = interval(1000);

// 从一个 observable 中发出输出值
const example = merge(
  first.pipe(mapTo('FIRST!')),
  second.pipe(mapTo('SECOND!')),
  third.pipe(mapTo('THIRD')),
  fourth.pipe(mapTo('FOURTH'))
);
// 输出: "FOURTH", "THIRD", "SECOND!", "FOURTH", "FIRST!", "THIRD", "FOURTH"
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 使用实例方法合并2个 observables

(
[StackBlitz](https://stackblitz.com/edit/typescript-bcsl1r?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/wuwujokaqu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/me5ofcr0/) )

```js
// RxJS v6+
import { merge } from 'rxjs/operators';
import { interval } from 'rxjs';

// 每2.5秒发出值
const first = interval(2500);
// 每1秒发出值
const second = interval(1000);
// 作为实例方法使用
const example = first.pipe(merge(second));
// 输出: 0,1,0,2....
const subscribe = example.subscribe(val => console.log(val));
```

### 相关食谱

- [HTTP 轮询](../../recipes/http-polling.md)

### 其他资源

- [merge](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-merge) :newspaper: - 官方文档
- [使用 merge 处理多个流](https://egghead.io/lessons/rxjs-handling-multiple-streams-with-merge?course=step-by-step-async-javascript-with-rxjs) :video_camera: :dollar: - John Linquist
- [使用 merge1 共享网络请求](https://egghead.io/lessons/rxjs-reactive-programming-sharing-network-requests-with-rxjs-merge?course=introduction-to-reactive-programming) :video_camera: :dollar: - André Staltz
- [组合操作符: merge](https://egghead.io/lessons/rxjs-combination-operator-merge?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/merge.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/merge.ts)
