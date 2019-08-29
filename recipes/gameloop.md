# 游戏循环

_作者 [@barryrowe](https://twitter.com/barryrowe)_

本食谱演示了使用组合流来创建游戏循环的一种方式。本食谱旨在突出如何用响应式的方式来重新思考现有问题。在这个示例中，我们将提供整体循环以及自上帧以来的增量时间。与此相结合的是用户输入流，以及当前的游戏状态，我们可以用它来更新我们的对象，并根据每帧的发出来将其渲染到屏幕上。

<div class="ua-ad"><a href="https://ultimatecourses.com/courses/rxjs"><img src="https://ultimatecourses.com/assets/img/banners/rxjs-banner-desktop.svg"></a></div>

### 示例代码

(
[StackBlitz](https://stackblitz.com/edit/rxjs-5-based-game-loop-jlhyfx?file=index.ts&devtoolsheight=50)
)

```js
import { BehaviorSubject, Observable, of, fromEvent } from 'rxjs';
import { buffer, bufferCount, expand, filter, map,  share, tap, withLatestFrom } from 'rxjs/operators';

import { IFrameData } from './frame.interface';
import { KeyUtil } from './keys.util';
import { clampMag, runBoundaryCheck, clampTo30FPS } from './game.util';

const boundaries = {
  left: 0,
  top: 0,
  bottom: 300,
  right: 400
};
const bounceRateChanges = {
  left: 1.1,
  top: 1.2,
  bottom: 1.3,
  right: 1.4
}
const baseObjectVelocity = {
  x: 30,
  y: 40,
  maxX: 250,
  maxY: 200
};

const gameArea: HTMLElement = document.getElementById('game');
const fps: HTMLElement = document.getElementById('fps');

/**
 * 这是游戏循环的核心逻辑。每一帧都更新对象和游戏状态。
 * 传入的 `deltaTime` 以秒为单位，我们还给定了当前状态和任意的输入状态。
 * 返回值为更新后的游戏状态。
 */
const update = (deltaTime: number, state: any, inputState: any): any => {
  //console.log("Input State: ", inputState);
  if(state['objects'] === undefined) {
    state['objects'] = [
      {
        // 变形属性
        x: 10, y: 10, width: 20, height: 30,
        // 状态属性
        isPaused: false, toggleColor: '#FF0000', color: '#000000',
        // 移动属性
        velocity: baseObjectVelocity
      },
      {
        // 变形属性
        x: 200, y: 249, width: 50, height: 20,
        // 状态属性
        isPaused: false, toggleColor: '#00FF00', color: '#0000FF',
        // 移动属性
        velocity: {x: -baseObjectVelocity.x, y: 2*baseObjectVelocity.y} }
    ];
  } else {

    state['objects'].forEach((obj) => {
      // 处理输入
      if (inputState['spacebar']) {
        obj.isPaused = !obj.isPaused;
        let newColor = obj.toggleColor;
        obj.toggleColor = obj.color;
        obj.color = newColor;
      }

      // 处理游戏循环的更新
      if(!obj.isPaused) {

        // 应用速率运动
        obj.x = obj.x += obj.velocity.x*deltaTime;
        obj.y = obj.y += obj.velocity.y*deltaTime;  

        // 边界检查
        const didHit = runBoundaryCheck(obj, boundaries);
        // 处理边界调整
        if(didHit){
          if(didHit === 'right' || didHit === 'left') {
            obj.velocity.x *= -bounceRateChanges[didHit];
          } else {
            obj.velocity.y *= -bounceRateChanges[didHit];
          }
        }
      }

      // 如果我们的边界反弹使得我们的速度变得太快，就钳制速度。
      obj.velocity.x = clampMag(obj.velocity.x, 0, baseObjectVelocity.maxX);
      obj.velocity.y = clampMag(obj.velocity.y, 0, baseObjectVelocity.maxY);
    });
  }

  return state;
}

/**
 * 这是渲染函数。我们接收给定的游戏状态并根据它们的最新属性来渲染页面。
 */
const render = (state: any) => {
  const ctx: CanvasRenderingContext2D = (/*<HTMLCanvasElement>*/gameArea).getContext('2d');
  // 清除 canvas
  ctx.clearRect(0, 0, gameArea.clientWidth, gameArea.clientHeight);

  // 渲染所有对象 (都是简单的矩形)
  state['objects'].forEach((obj) => {
    ctx.fillStyle = obj.color;
    ctx.fillRect(obj.x, obj.y, obj.width, obj.height);
  });  
};



/**
 * 这个函数返回一个 observable，一旦浏览器返回一个动画帧步骤，该 observable 将发出下一个帧。
 * 鉴于前一帧计算得出的增量时间，我们将其钳制至30FPS，以防长帧的出现。
 */
const calculateStep: (prevFrame: IFrameData) => Observable<IFrameData> = (prevFrame: IFrameData) => {
  return Observable.create((observer) => {

    requestAnimationFrame((frameStartTime) => {
      // 毫秒转化成秒
      const deltaTime = prevFrame ? (frameStartTime - prevFrame.frameStartTime)/1000 : 0;
      observer.next({
        frameStartTime,
        deltaTime
      });
    })
  })
  .pipe(
    map(clampTo30FPS)
  )
};

/**
 * 这是帧的核心流。我们使用 `expand` 操作符来递归调用上面的 `calculateStep` 函数，
 * 它会基于 `window.requestAnimationFrame` 的调用返回每一个新帧。
 * `expand` 发出被调用函数返回的 observable 的值，并递归调用具有相同发出值的函数。
 * 这非常适合计算我们的帧步骤，因为每个步骤都需要知道上一帧的时间来计算下一帧。
 * 一旦当前请求的帧已经返回，我们还想要求一个新的帧。
 */
const frames$ = of(undefined)
  .pipe(
    expand((val) => calculateStep(val)),
    // expand 发出提供给它的第一个值，
    // 在这里我们只想忽略值为 undefined 的输入帧
    filter(frame => frame !== undefined),
    map((frame: IFrameData) => frame.deltaTime),
    share()
  )

// 这是 keyDown 输入事件的核心流。
// 每次按键后它会发出类似 `{"spacebar": 32}` 的对象
const keysDown$ = fromEvent(document, 'keydown')
  .pipe(
    map((event: KeyboardEvent) => {
      const name = KeyUtil.codeToKey(''+event.keyCode);
      if (name !== ''){
        let keyMap = {};
        keyMap[name] = event.code;
        return keyMap;
      } else {
        return undefined;
      }
    }),
    filter((keyMap) => keyMap !== undefined)
  );

// 这里我们将 keyDown 流缓冲起来，直到发出新的帧。
// 我们将得到自从上一帧发出后的所有 keyDown 事件。
// 我们将其归并为单个对象。
const keysDownPerFrame$ = keysDown$
  .pipe(
    buffer(frames$),
    map((frames: Array<any>) => {
      return frames.reduce((acc, curr) => {
        return Object.assign(acc, curr);
      }, {});
    })
  );

// 因为每一帧我们都会更新游戏状态，所以可以使用 Observable 作为一系列状态
// 进行追踪，最新的发出值即为当前游戏状态。
const gameState$ = new BehaviorSubject({});

// 这是运行游戏的代码！
// 我们订阅 `frames$` 流以开始，并确保组合了输入流的最新发出，以获取游戏状态更新所
// 必须的数据。
frames$
  .pipe(
    withLatestFrom(keysDownPerFrame$, gameState$),
    // 课后作业: 处理 keyUp 并映射成真正的按键状态变化对象
    map(([deltaTime, keysDown, gameState]) => update(deltaTime, gameState, keysDown)),
    tap((gameState) => gameState$.next(gameState))

  )
  .subscribe((gameState) => {
    render(gameState);
  });


// 平均每10帧计算一下FPS
frames$ 
  .pipe(
    bufferCount(10),
    map((frames) => {
      const total = frames
        .reduce((acc, curr) => {
          acc += curr;
          return acc;
        }, 0);

        return 1/(total/frames.length);
    })
  ).subscribe((avg) => {
    fps.innerHTML = Math.round(avg) + '';
  })
```

##### 辅助 js 文件

- [game.util.ts](https://stackblitz.com/edit/rxjs-5-based-game-loop?file=game.util.ts)
- [keys.util.ts](https://stackblitz.com/edit/rxjs-5-based-game-loop?file=keys.util.ts)
- [frame.interface.ts](https://stackblitz.com/edit/rxjs-5-based-game-loop?file=frame.interface.ts)

##### html

```html
<canvas width="400px" height="300px" id="game"></canvas>
<div id="fps"></div>
<p class="instructions">
  Each time a block hits a wall, it gets faster. You can hit SPACE to pause the boxes. They will change colors to show they are paused.
</p>
```

### 使用到的操作符

- [buffer](../operators/transformation/buffer.md)
- [bufferCount](../operators/transformation/bufferCount.md)
- [expand](../operators/transformation/expand.md)
- [filter](../operators/filtering/filter.md)
- [fromEvent](../operators/creation/fromevent.md)
- [map](../operators/transformation/map.md)
- [share](../operators/multicasting/share.md)
- [tap](../operators/utility/do.md)
- [withLatestFrom](../operators/transformation/withlatestfrom.md)
