# pluck

#### 签名: `pluck(properties: ...args): Observable`

## 选择属性来发出。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例

##### 示例 1: 提取对象属性

( [StackBlitz](https://stackblitz.com/edit/typescript-1pxyt1?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/zokaxiwahe/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/58v9xq0f/) )

```js
import { from } from 'rxjs/observable/from';
import { pluck } from 'rxjs/operators';

const source = from([{ name: 'Joe', age: 30 }, { name: 'Sarah', age: 35 }]);
// 提取 name 属性
const example = source.pipe(pluck('name'));
// 输出: "Joe", "Sarah"
const subscribe = example.subscribe(val => console.log(val));
```

##### 示例 2: 提取嵌套的属性

( [StackBlitz](https://stackblitz.com/edit/typescript-ybhnsd?file=index.ts&devtoolsheight=50) |
[jsBin](http://jsbin.com/joqesidugu/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/n592m597/) )

```js
import { from } from 'rxjs/observable/from';
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

* [pluck](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-pluck) :newspaper: - 官方文档

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pluck.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/pluck.ts)
