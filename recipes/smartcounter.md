# 智能计数器

一个在页面上带有动态更新数字效果的有趣元素就是智能计数器，也可以称之为里程表效果。不采用上下跳数的方式，而是快速地清点到期望的数字，这能达到一种很酷的效果。能做到这点的流行库的其中一个就是由 [Hubspot](https://github.com/HubSpot) 所写的 [odometer](https://github.com/HubSpot/odometer) 。让我们来看看如何使用短短几行 RxJS 代码来实现类似的效果。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

#### 原生 JS

( [JSBin](http://jsbin.com/jojucaqiki/1/edit?js,output) |
[JSFiddle](https://jsfiddle.net/btroncone/au4sqvxu/) )

```js
// 工具函数
const takeUntilFunc = (endRange, currentNumber) => {
  return endRange > currentNumber
    ? val => val <= endRange
    : val => val >= endRange;
};

const positiveOrNegative = (endRange, currentNumber) => {
  return endRange > currentNumber ? 1 : -1;
};

const updateHTML = id => val => (document.getElementById(id).innerHTML = val);
// 显示
const input = document.getElementById('range');
const updateButton = document.getElementById('update');

const subscription = (function(currentNumber) {
  return fromEvent(updateButton, 'click').pipe(
    map(_ => parseInt(input.value)),
    switchMap(endRange => {
      return timer(0, 20).pipe(
        mapTo(positiveOrNegative(endRange, currentNumber)),
        startWith(currentNumber),
        scan((acc, curr) => acc + curr),
        takeWhile(takeUntilFunc(endRange, currentNumber));
      )
    }),
    tap(v => (currentNumber = v)),
    startWith(currentNumber)
  )
  .subscribe(updateHTML('display'));
})(0);
```

###### HTML

```html
<input id="range" type="number">
<button id="update">Update</button>
<h3 id="display">0</h3>
```

我们可以轻易地获取我们的原生 JS 所写的智能计数器并将其包装在任何流行的基于 UI 库中。下面是 Angular 版本的智能计数器，它接收一个更新结束范围的 `Input` 输入属性并执行适当的转换。

#### Angular 版本

(
[StackBlitz](https://stackblitz.com/edit/angular-gcnqlq?file=app%2Fnumber-tracker.component.ts)
)

```js
import { Component, Input, OnDestroy } from '@angular/core';
import { Subject } from 'rxjs/Subject';
import { timer } from 'rxjs/observable/timer';
import { switchMap, startWith, scan, takeWhile, takeUntil, mapTo } from 'rxjs/operators';

@Component({
  selector: 'number-tracker',
  template: `
    <h3> {{ currentNumber }}</h3>
  `
})
export class NumberTrackerComponent implements OnDestroy {
  @Input()
  set end(endRange: number) {
    this._counterSub$.next(endRange);
  }
  @Input() countInterval = 20;
  public currentNumber = 0;
  private _counterSub$ = new Subject();
  private _onDestroy$ = new Subject();

  constructor() {
    this._counterSub$
      .pipe(
        switchMap(endRange => {
          return timer(0, this.countInterval).pipe(
            mapTo(this.positiveOrNegative(endRange, this.currentNumber)),
            startWith(this.currentNumber),
            scan((acc: number, curr: number) => acc + curr),
            takeWhile(this.isApproachingRange(endRange, this.currentNumber))
          )
        }),
        takeUntil(this._onDestroy$)
      )
      .subscribe((val: number) => this.currentNumber = val);
  }

  private positiveOrNegative(endRange, currentNumber) {
    return endRange > currentNumber ? 1 : -1;
  }

  private isApproachingRange(endRange, currentNumber) {
    return endRange > currentNumber
      ? val => val <= endRange
      : val => val >= endRange;
  }

  ngOnDestroy() {
    this._onDestroy$.next();
    this._onDestroy$.complete();
  }
}
```

###### HTML

```html
<p>
  <input type="number"
    (keyup.enter)="counterNumber = vanillaInput.value"
    #vanillaInput>
  <button
    (click)="counterNumber = vanillaInput.value">
    Update number
  </button>
</p>
<number-tracker [end]="counterNumber"></number-tracker>
```

### 使用到的操作符

* [fromEvent](../operators/creation/fromevent.md)
* [map](../operators/transformation/map.md)
* [mapTo](../operators/transformation/mapto.md)
* [scan](../operators/transformation/scan.md)
* [startWith](../operators/combination/startwith.md)
* [switchMap](../operators/transformation/switchmap.md)
* [takeWhile](../operators/filtering/takewhile.md)
