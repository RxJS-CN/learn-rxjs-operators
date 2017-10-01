# 理解操作符导入

在消费或创建依赖于 RxJS 的公共库时，你可能遇到处理运算符导入的问题。在项目中引入操作符最主要的方式像下面这样导入:

```js
import 'rxjs/add/operator/take';
```

这会将导入的操作符添加到 `Observable` 的原型上，以便在整个项目中使用:

[(源码)](https://github.com/ReactiveX/rxjs/blob/master/src/add/operator/take.ts)

```js
import { Observable } from '../../Observable';
import { take } from '../../operator/take';

Observable.prototype.take = take;

declare module '../../Observable' {
  interface Observable<T> {
    take: typeof take;
  }
}
```

对于私有项目和模块，这种方法通常是“没问题的”，但当整个团队使用同一个 [npm](https://www.npmjs.com/) 包或库时再使用这种导入方式，问题就会出现。

<div class="native-ad"></div>

### 简单示例

来看看问题出在哪里，假设**小A**创建了一个公有的 Angular 组件库。在这个库中需要一些操作符，下面以传统的方式进行了导入:

*some-public-library.ts*

```js
import 'rxjs/add/operator/take';
import 'rxjs/add/operator/concatMap';
import 'rxjs/add/operator/switchMap';
```

**小B**引用了小A的库。尽管他并没有导入这些操作符，但他依然可以直接使用。**这可能不是什么大问题，但确实会带来一些困扰**。小B继续使用库和这些操作符，一切都很正常...

一个月后，**小A**决定更新自己的库。他不再需要 `switchMap` 或 `concatMap`，所以他删除了导入:

*some-public-library.ts*

```js
import 'rxjs/add/operator/take';
```

**小B**更新了依赖并构建自己的项目，但这次失败了。他本身并没有引入 `switchMap` 或 `concatMap`，只是基于第三方的依赖才能**正常运行**。如果你并没有意识到这样会产生问题，那可能需要一点时间来弄清楚。

### 解决方案

不再使用这种导入方式:

```js
import 'rxjs/add/operator/take';
```

我们可以这样来进行导入:

```js
import { take } from 'rxjs/operator/take';
```

这样可以保持 `Observable` 原型的干净，这样来直接调用它们:

```js
import { take } from 'rxjs/operator/take';
import { of } from 'rxjs/observable/of';

take.call(
  of(1,2,3), 
  2
);
```

然而这样代码很快就会变得**丑陋不堪**，想象一下这样更长的调用链:

```js
import { take } from 'rxjs/operator/take';
import { map } from 'rxjs/operator/map';
import { of } from 'rxjs/observable/of';

map.call(
  take.call(
    of(1,2,3), 
    2
  ),
  val => val + 2
);
```

很快我们的代码块将变得几乎无法理解。我们怎样才能两全其美呢？

### Pipeable 操作符

现在 RxJS 提供了 [`pipe`](https://github.com/ReactiveX/rxjs/blob/755df9bf908108974e38aaff79887279f2cde008/src/Observable.ts#L305-L329) 辅助函数，它存在于 `Observable` 上，它缓解了操作符不在原型上所带来的问题。我们还继续使用上面丑陋的代码块:

```js
import { take, map } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

map.call(
  take.call(
    of(1,2,3), 
    2
  ),
  val => val + 2
);
```

并将其转换成:

```js
import { take, map } from 'rxjs/operators';
import { of } from 'rxjs/observable/of';

of(1,2,3)
  .pipe(
    take(2),
    map(val => val + 2)
  );
```

Much easier to read, right? This also has the benefit of greatly reducing the RxJS bundle size in your application. For more on this, check out [Ashwin Sureshkumar's](https://twitter.com/Sureshkumar_Ash) excellent article [Reduce Angular app bundle size using lettable operators](https://hackernoon.com/rxjs-reduce-bundle-size-using-lettable-operators-418307295e85).
