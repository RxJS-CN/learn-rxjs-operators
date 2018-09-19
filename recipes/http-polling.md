# HTTP 轮询

_作者 [@barryrowe](https://twitter.com/barryrowe)_

本食谱演示了通过定时器来进行 HTTP 轮询。在 Web 应用中这是常见任务，RxJS 可以很好地处理此项任务，因为将一系列 HTTP 请求和响应当做是数据流很容易。

<div class="ua-ad"><a href="https://ultimateangular.com/?ref=76683_kee7y7vk"><img src="https://ultimateangular.com/assets/img/banners/ua-leader.svg"></a></div>

### 示例代码

(
[StackBlitz](https://stackblitz.com/edit/rxjs-http-poll-recipe-jc5cj7?file=index.ts&devtoolsheight=50)
)

```ts
// 导入样式
import './style.css';

import { Observable, Subscription, of, fromEvent, from, empty, merge, timer } from 'rxjs';
import { map, mapTo, switchMap, tap, mergeMap, takeUntil, filter, finalize } from 'rxjs/operators';

declare type RequestCategory = 'cats' | 'meats';

// Cat 请求的常量
const CATS_URL = "https://placekitten.com/g/{w}/{h}";
function mapCats(response): Observable<string> {

  return from(new Promise((resolve, reject) => {
      var blob = new Blob([response], {type: "image/png"});
      let reader = new FileReader();
      reader.onload = (data: any) => {
        resolve(data.target.result);
      };
      reader.readAsDataURL(blob);
  }));
}

// Meat 请求的常量
const MEATS_URL = "https://baconipsum.com/api/?type=meat-and-filler";
function mapMeats(response): Observable<string> {
  const parsedData = JSON.parse(response);
  return of(parsedData ? parsedData[0] : '');
}

/*************************
 * 我们的操作状态
 *************************/
 // 请求数据的类型
let requestCategory: RequestCategory = 'cats';
// 当前轮询的订阅
let pollingSub: Subscription;
/*************************/

/**
 * 此函数会对给定的 URL 发起 AJAX 请求，并使用提供的映射函数对响应 JSON 
 * 进行映射，然后在返回的 Observable 上发出结果。
 */
function requestData(url: string, mapFunc: (any) => Observable<string>): Observable<string> {
  console.log(url)
  const xhr = new XMLHttpRequest();
  return from(new Promise<string>((resolve, reject) => {

    // 为 placekitten 的图像生成随机尺寸
    // 这样每次请求我们得到的都是新的猫
    const w = Math.round(Math.random() * 400);
    const h = Math.round(Math.random() * 400);
    const targetUrl = url
      .replace('{w}', w.toString())
      .replace('{h}', h.toString());

    xhr.addEventListener("load", () => {
      resolve(xhr.response);
    });
    xhr.open("GET", targetUrl);
    if(requestCategory === 'cats') {
      // 猫的 url 返回的是二进制数据
      // 所以我们需要这样进行响应
      xhr.responseType = "arraybuffer";
    }
    xhr.send();
  }))
  .pipe(
    switchMap((data) => mapFunc(xhr.response)),
    tap((data) => console.log('Request result: ', data))
  );
}


/**
 * 此函数会根据给定的状态开始轮询，轮询时间
 * 由提供的 interval 决定 (默认为 5 秒)
 */
function startPolling(category: RequestCategory, interval: number = 5000): Observable<string> {
  const url = category === 'cats' ? CATS_URL : MEATS_URL;
  const mapper = category === 'cats' ? mapCats : mapMeats;

  return timer(0, interval)
    .pipe(
      switchMap(_ => requestData(url, mapper))
    );
}

// 获取 DOM 元素以绑定事件
const startButton = document.getElementById('start');
const stopButton = document.getElementById('stop');
const text = document.getElementById('text');
const pollingStatus = document.getElementById('polling-status');
const catsRadio = document.getElementById('catsCheckbox');
const meatsRadio = document.getElementById('meatsCheckbox');
const catsClick$ = fromEvent(catsRadio, 'click').pipe(mapTo('cats'));
const meatsClick$ = fromEvent(meatsRadio, 'click').pipe(mapTo('meats'));
const catImage: HTMLImageElement = <HTMLImageElement>document.getElementById('cat');
// 停止轮询
let stopPolling$ = fromEvent(stopButton, 'click');

function updateDom(result) {
  if (requestCategory === 'cats') {
    catImage.src = result;
    console.log(catImage);
  } else {
    text.innerHTML = result;
  }
}

function watchForData(category: RequestCategory) {
    // 开始新的轮询
    return startPolling(category, 5000).pipe(
      tap(updateDom),
      takeUntil(
        // 无论是点击按钮还是切换分类，都将停止轮询
        merge(
          stopPolling$,
          merge(catsClick$, meatsClick$).pipe(filter(c => c !== category))
        )
      ),
      // 仅用于演示目的
      finalize(() => pollingStatus.innerHTML = 'Stopped')
    )
}

// 处理表单更新
catsClick$
  .subscribe((category: RequestCategory) => {
    requestCategory = category;
    catImage.style.display = 'block';
    text.style.display = 'none';
  });

meatsClick$
  .subscribe((category: RequestCategory) => {
    requestCategory = category;
    catImage.style.display = 'none';
    text.style.display = 'block';
  });

// 开始轮询
fromEvent(startButton, 'click')
.pipe(
  // 仅用于演示目的
  tap(_ => pollingStatus.innerHTML = 'Started'),
  mergeMap(_ => watchForData(requestCategory))
)
.subscribe();
```

### 使用到的操作符

- [filter](../operators/filtering/filter.md)
- [fromEvent](../operators/creation/fromevent.md)
- [from](../operators/creation/from.md)
- [map](../operators/transformation/map.md)
- [mapTo](../operators/transformation/mapTo.md)
- [merge](../operators/combination/merge.md)
- [mergeMap](../operators/transformation/mergemap.md)
- [switchMap](../operators/transformation/switchmap.md)
- [timer](../operators/creation/timer.md)
