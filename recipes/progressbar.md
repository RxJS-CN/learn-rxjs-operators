# 进度条

_作者 [@barryrowe](https://twitter.com/barryrowe)_

本食谱演示了动态进度条的创建、模拟多个请求的管理，并在每个请求完成后更新总体进度。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例代码

(
[StackBlitz](https://stackblitz.com/edit/rxjs-5-progress-bar-wxdxwe?file=index.ts&devtoolsheight=50)
)

```js
import './style.css';

import { Observable, of, empty, fromEvent, from } from 'rxjs';
import {
  delay,
  switchMapTo,
  concatAll,
  count,
  scan,
  withLatestFrom,
  share
} from 'rxjs/operators';

const requestOne = of('first').pipe(delay(500));
const requestTwo = of('second').pipe(delay(800));
const requestThree = of('third').pipe(delay(1100));
const requestFour = of('fourth').pipe(delay(1400));
const requestFive = of('fifth').pipe(delay(1700));

const loadButton = document.getElementById('load');
const progressBar = document.getElementById('progress');
const content = document.getElementById('data');

// 请求完成后更新进度条
const updateProgress = progressRatio => {
  console.log('Progress Ratio: ', progressRatio);
  progressBar.style.width = 100 * progressRatio + '%';
  if (progressRatio === 1) {
    progressBar.className += ' finished';
  } else {
    progressBar.className = progressBar.className.replace(' finished', '');
  }
};
// 通知更新的简单辅助函数
const updateContent = newContent => {
  content.innerHTML += newContent;
};

const displayData = data => {
  updateContent(`<div class="content-item">${data}</div>`);
};

// 模拟5个不同时长的请求
const observables: Array<Observable<string>> = [
  requestOne,
  requestTwo,
  requestThree,
  requestFour,
  requestFive
];

const array$ = from(observables);
const requests$ = array$.pipe(concatAll());
const clicks$ = fromEvent(loadButton, 'click');

const progress$ = clicks$.pipe(
  switchMapTo(requests$),
  share()
);

const count$ = array$.pipe(count());

const ratio$ = progress$.pipe(
  scan(current => current + 1, 0),
  withLatestFrom(count$, (current, count) => current / count)
);

clicks$.pipe(switchMapTo(ratio$)).subscribe(updateProgress);

progress$.subscribe(displayData);
```

##### html

```html
<div class="progress-container">
  <div class="progress" id="progress"></div>
</div>

<button id="load">
Load Data
</button>

<div id="data">

</div>
```

_感谢 [@johnlinquist](https://twitter.com/johnlindquist) 对本示例的帮助！_

### 使用到的操作符

- [concatAll](../operators/transformation/concatall.md)
- [delay](../operators/utility/delay.md)
- [fromEvent](../operators/creation/fromevent.md)
- [from](../operators/creation/from.md)
- [scan](../operators/transformation/scan.md)
- [share](../operators/multicasting/share.md)
- [switchMap](../operators/transformation/switchmap.md)
- [withLatestFrom](../operators/transformation/withlatestfrom.md)
