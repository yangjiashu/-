### 动画

vue动画分为两种

1. css过度
2. css动画

在Html标签中使用动画的元素要用`<transition>`标签包裹起来，并且用`name`属性指定动画名，用于在样式文件中设定动画样式。通常要使用动画的元素用`v-if`控制进入和离开。

#### 1.css过渡

在进入/离开的过程中有6个class切换
1. `v-enter`: 进入时的初始状态。即被插入之前的状态，插入动作时第一帧就会移除。
2. `v-enter-active`: 定义过渡时期的状态，与css中的`transition`属性配合使用。
3. `v-enter-to`: 定义进入动作结束时的状态，在插入动作的第一帧开始生效，与`v-enter`属性的消失同时发生。
4. `v-leave`,`v-leave-active`,`v-leave-to`: 离开动作，与进入动作同理。

#### 2.css动画

使用`animation`和`keyframe`的组合来使用，类和css过渡中的类一样。但是只需要设定`v-enter-active`和`v-leave-active`就可以了。

#### 自定义过渡的类名：和第三方库配合使用