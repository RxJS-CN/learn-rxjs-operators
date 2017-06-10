# distinctUntilChanged

#### 签名: ` distinctUntilChanged(compare: function): Observable`

## 只有当当前值与之前最后一个值不同时才将其发出。

---

:bulb: distinctUntilChanged 默认使用 `===` 进行比较, 对象引用必须匹配！

---

### 示例

##### 示例 1: 使用基础值进行 distinctUntilChanged

( [jsBin](http://jsbin.com/qoyoxeheva/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/xc2vzct7/) )

```js
import { from } from 'rxjs/observable/from';
import { distinctUntilChanged } from 'rxjs/operators';

// 基于最新发出的值进行比较，只输出不同的值
const myArrayWithDuplicatesInARow = from([1, 1, 2, 2, 3, 1, 2, 3]);

const distinctSub = myArrayWithDuplicatesInARow
  .pipe(distinctUntilChanged())
  // 输出: 1,2,3,1,2,3
  .subscribe(val => console.log('DISTINCT SUB:', val));

const nonDistinctSub = myArrayWithDuplicatesInARow
  // 输出 : 1,1,2,2,3,1,2,3
  .subscribe(val => console.log('NON DISTINCT SUB:', val));
```

##### 示例 2: 使用对象进行 distinctUntilChanged

( [jsBin](http://jsbin.com/mexocipave/1/edit?js,console) |
[jsFiddle](https://jsfiddle.net/btroncone/t4ava5b4/) )

```js
import { from } from 'rxjs/observable/from';
import { distinctUntilChanged } from 'rxjs/operators';

const sampleObject = { name: 'Test' };
// 对象必须有相同的引用
const myArrayWithDuplicateObjects = from([
  sampleObject,
  sampleObject,
  sampleObject
]);
// 基于最新发出的值进行比较，只输出不同的对象
const nonDistinctObjects = myArrayWithDuplicateObjects
  .pipe(distinctUntilChanged())
  // 输出: 'DISTINCT OBJECTS: {name: 'Test'}
  .subscribe(val => console.log('DISTINCT OBJECTS:', val));
```

### 其他资源

* [distinctUntilChanged](http://cn.rx.js.org/class/es6/Observable.js~Observable.html#instance-method-distinctUntilChanged) :newspaper: - 官方文档
* [过滤操作符: distinct 和 distinctUntilChanged](https://egghead.io/lessons/rxjs-filtering-operators-distinct-and-distinctuntilchanged?course=rxjs-beyond-the-basics-operators-in-depth) :video_camera: :dollar: - André Staltz

---
> :file_folder: 源码:  [https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/distinctUntilChanged.ts](https://github.com/ReactiveX/rxjs/blob/master/src/internal/operators/distinctUntilChanged.ts)
