# 学习 RxJS

RxJS 的清晰示例、解释及资源。

*作者 [@btroncone](https://twitter.com/BTroncone)*

## 前言

[RxJS](https://github.com/ReactiveX/rxjs) 是当前 web 开发中最热门的库之一。它提供强大的功能性方法来处理事件，并将集成点集中到越来越多的框架、库和实用程序中，这一切使得学习 Rx 变得前所未有的吸引人。并且它还有能力利用你之前所掌握的语言知识，因为它[几乎涵盖了所有语言](http://reactivex.io/languages.html)。如果熟练掌握响应式编程 (reactive programming) 的话，那它所提供的一切似乎都可以变得很容易。

**但是...**

学习 RxJS 和响应式编程很[难](https://twitter.com/hoss/status/742643506536153088)。它有着众多的概念，大量的表层 API 和从[命令式到声明式风格](http://codenugget.co/2015/03/05/declarative-vs-imperative-programming-web.html)的思维转换。本网站致力于让这些概念更容易理解，示例清晰且容易解释，并且功能参考了网络上最好的 RxJS 相关资源。目标是增强[官方文档](http://reactivex.io/rxjs/)，并且提供了一个全新的，新鲜的视角，以清除任何学习上的障碍和解决初学者的痛点。学习 Rx 或许是困难的，但是它绝对值得你去付出！

## 内容

#### 操作符

操作符是 observables 背后的马力，为复杂的异步任务提供了一种优雅的声明式解决方案。本章节涵盖了所有 [RxJS 5 操作符](/operators/README.md)，还附带在 [JSBin](https://jsbin.com) 和 [JSFiddle](https://jsfiddle.net) 均可执行的清晰示例。适当的时候，还会为每个操作符提供其他资源和使用技巧的链接。

##### 分类

* [组合](/operators/combination/README.md)
* [条件](/operators/conditional/README.md)
* [创建](/operators/creation/README.md)
* [错误处理](/operators/error_handling/README.md)
* [多播](/operators/multicasting/README.md)
* [过滤](/operators/filtering/README.md)
* [转换](/operators/transformation/README.md)
* [工具](/operators/utility/README.md)

**或者...**

[按字母顺序排列的完整列表](/operators/complete.md)

#### 概念

如果对 Observables 背后的工作原理没有扎实的基础知识，很容易感觉 RxJS 就像是“魔法”一般。本章节有助于巩固所需的主要概念，以便对响应式编程和 Observables 得心应手。

[完整的概念列表](/concepts/README.md)

#### 食谱

食谱用于使用 RxJS 的常用用例和有趣的解决方案。

[完整的食谱列表](/recipes/README.md)

## 介绍性资源

RxJS 和响应式编程的新手？除了本网站上发现的内容，这些优秀的文章和视频也将有助于你快速积累学习经验！

#### 阅读

* [RxJS 入门](http://reactivex.io/rxjs/manual/overview.html#introduction) - 官方文档
* [你已经错过的响应式编程-介绍](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754) - André Staltz

#### 视频

* [异步编程: 循环终结者](https://egghead.io/courses/mastering-asynchronous-programming-the-end-of-the-loop) - Jafar Husain
* [什么是 RxJS ？](https://egghead.io/lessons/rxjs-what-is-rxjs) - Ben Lesh
* [从零开始创建 Observable](https://egghead.io/lessons/rxjs-creating-observable-from-scratch) - Ben Lesh
* [介绍 RxJS 的弹珠测试](https://egghead.io/lessons/rxjs-introduction-to-rxjs-marble-testing) - Brian Troncone
* [介绍响应式编程](https://egghead.io/courses/introduction-to-reactive-programming) :dollar: - André Staltz
* [使用 Observables 的响应式编程](https://www.youtube.com/watch?v=HT7JiiqnYYc&feature=youtu.be) - Jeremy Lund

#### 练习

* [JavaScript 中的函数式编程](http://reactivex.io/learnrx/) - Jafar Husain

#### 工具

* [Rx Marbles - Rx Observables 的交互弹珠图](http://rxmarbles.com/) - André Staltz
* [Rx Visualizer - Rx Observables 的动画游乐场](https://rxviz.com) - Misha Moroshko
* [Reactive.how - 学习响应式编程的动画卡片](http://reactive.how) - Cédric Soulas

*对 RxJS 4 感兴趣？ 请查阅 [Denis Stoyanov's](https://github.com/xgrommx) 超棒的 [电子书](https://xgrommx.github.io/rx-book/)!*

## 翻译

  * [简体中文](https://rxjs-cn.github.io/learn-rxjs-operators)

### 参考文献注

本 GitBook 中包含的所有参考资料都是学习资源，其中有免费的，也有付费，它们在我学习 RxJS 时给予了极大的帮助。如果您遇到您认为应该包含在此处的文章或视频，请使用顶部菜单中的*编辑此页面*链接并提交 pull request (译者注：请去英文站提交相关链接的 PR，中文站中的 PR 是用来修复翻译中的问题)。对于您的反馈我将深表感谢！