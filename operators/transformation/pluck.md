# pluck

#### 函数签名: `pluck(properties: ...args): Observable`

## 选择属性来发出。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例

##### 示例 1: 提取对象属性

(
[StackBlitz](https://stackblitz.com/edit/typescript-jkda4e?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/zokaxiwahe/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/58v9xq0f/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { pluck } from 'rxjs/operators';

const source = from([{ name: 'Joe', age: 30 }, { name: 'Sarah', age: 35 }]);
// 提取 name 属性
const example = source.pipe(pluck('name'));
// 输出: "Joe", "Sarah"
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 提取嵌套的属性

(
[StackBlitz](https://stackblitz.com/edit/typescript-rinjzk?file=index.ts&devtoolsheight=100)
| [jsBin](http://jsbin.com/joqesidugu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/n592m597/) )

```js
// RxJS v6+
import { from } from 'rxjs';
import { pluck } from 'rxjs/operators';

const source = from([
  { name: 'Joe', age: 30, job: { title: 'Developer', language: 'JavaScript' } },
  // 当找不到 job 属性的时候会返回 undefined
  { name: 'Sarah', age: 35 }
]);
// 提取 job 中的 title 属性
const example = source.pipe(pluck('job', 'title'));
// 输出: "Developer" , undefined
const subscribe = example.subscribe(val => console.log(val));
```

### 其他资源

- [pluck](https://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-pluck) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pluck.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pluck.ts)
