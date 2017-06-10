# of / just

#### 签名: ` of(...values, scheduler: Scheduler): Observable`

## 按顺序发出任意数量的值。

### 示例

##### 示例 1: 发出数字序列

(
[StackBlitz](https://stackblitz.com/edit/typescript-kbpvmm?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/kodixitoji/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/f7b35ayz/) )

```js
// RxJS v6+
import { of } from 'rxjs';
// 依次发出提供的任意数量的值
const source = of(1, 2, 3, 4, 5);
// 输出: 1,2,3,4,5
const subscribe = source.subscribe(val => console.log(val));
```

##### 示例 2: 发出对象、数组和函数

(
[StackBlitz](https://stackblitz.com/edit/typescript-m1jbw9?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/xevobujama/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/d9rng4dj/) )

```js
// RxJS v6+
import { of } from 'rxjs';
// 出任意类型值
const source = of({ name: 'Brian' }, [1, 2, 3], function hello() {
  return 'Hello';
});
// 输出: {name: 'Brian}, [1,2,3], function hello() { return 'Hello' }
const subscribe = source.subscribe(val => console.log(val));
```


### 其他资源

- [of](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#static-method-of) :newspaper: - 官方文档
- [创建操作符: of](https://egghead.io/lessons/rxjs-creation-operator-of?course=rxjs-beyond-the-basics-creating-observables-from-scratch) :video_camera: :dollar: - André Staltz

> :file_folder: 源码:
> [https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/of.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/observable/of.ts)
